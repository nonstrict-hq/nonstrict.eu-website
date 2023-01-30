---
date: 2023-01-30 12:00
authors: mathijs, tom
tags: Engineering blog, Screen Studio
intro: Building a commandline tool using Swift concurrency isn't as straight forward as you'd hope. Running on macOS pre-12 linker errors appear and back deployment is undocumented. We figured it out and documented it in this article.
hero: images/blog/shashwat-verma-J0cKFsL8EMU-unsplash.jpg
---

# Using async/await in a commandline tool on older macOS versions

*Fixing the `libswift_Concurrency.dylib could not be loaded` error.*

***tl;dr You need to ship `libswift_Concurrency.dylib` along with your CLI executable on macOS 10.15 and macOS 11, put it in `../lib` relative to your executable. You can add an rpath if you want a more convenient location (see blogpost).***

## Building a commandline tool with async/await

Swift concurrency seemed like a great fit for the new recorder backend for [Screen Studio](https://screen.studio) we built recently. It captures multiple devices in sync and features like async/await and task groups would help to write clear code that also executes in parallel where possible. The recorder is implemented as a macOS commandline tool that gets called from the Electron app and uses system native APIs to capture data from different devices.

We wanted to target macOS 10.15 Catalina and newer we where very happy with the back deployment of Swift concurrency that is available since the release of Xcode 13.2. It supports macOS 10.15 and newer, so we went ahead and started using it.

## Swift concurrency runtime is unavailable on older macOS pre-12

Once we ran an early version of our executable on macOS 11 Big Sur, we expected it to work out of the box because of the promise of back deployment, but it wouldn’t run at all. It crashes at the first function that uses any form of Swift concurrency with an error that `libswift_Concurrency.dylib` couldn’t be found/loaded:

```bash
dyld: lazy symbol binding failed: can't resolve symbol _swift_task_create in ./recorder because dependent dylib @rpath/libswift_Concurrency.dylib could not be loaded
dyld: can't resolve symbol _swift_task_create in ./recorder because dependent dylib @rpath/libswift_Concurrency.dylib could not be loaded
Abort trap: 6
```

Release notes nor the official docs mention anything about commandline tools, but the error is pretty clear that a dynamic library is expected to provide the concurrency implementation. Since macOS 12+ this library is shipped with the system, but older macOS versions don’t have this library on board.

A [minimal sample](https://github.com/nonstrict-hq/concurrency-cli-sample) we created confirmed that just adding `async` to the main function was enough to trigger this issue. And this post from [Joe Groff on the Swift forums](https://forums.swift.org/t/swift-concurrency-back-deployment/51908/20) confirmed that a copy of the concurrency runtime needs to be bundled with the executable:

> The main tradeoff would be that, in order to deploy to older OSes, your app will need to bundle a copy of the Swift 5.5 concurrency runtime for older OSes, similar to how back-deploying Swift to OSes before the stable ABI requires bundling a copy of the Swift 5.0 runtime.
> ***— Joe Groff, Oct ‘21***

## Bundling the dynamic library with your executable

### Locating the library

First question was where to locate the `libswift_Concurrency.dylib` on our system. In our search we crossed [a blog from Marco Eidinger](https://blog.eidinger.info/develop-a-command-line-tool-using-swift-concurrency#heading-bonus-tip) that contains a “bonus tip” on how to work around Xcode 13.2 not linking the concurrency library correctly. He points the linker to the correct location of the library at: 

`$(xcode-select -p)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift-5.5/macosx/libswift_Concurrency.dylib`

### Putting the library in the right place

You might try to just put that library next to your executable, but that won’t work. The linker isn’t looking next the executable. Figuring out where to put it we use `otool` to display the names of the shared libraries used:

```bash
❯ otool -L .build/release/recorder
.build/release/recorder (architecture x86_64):
    /usr/lib/libobjc.A.dylib (compatibility version 1.0.0, current version 228.0.0)
    [...output shortened...]
    @rpath/libswift_Concurrency.dylib (compatibility version 1.0.0, current version 5.7.1, weak)
    /usr/lib/swift/libswiftFoundation.dylib (compatibility version 1.0.0, current version 1.0.0)
.build/release/recorder (architecture arm64):
    /usr/lib/libobjc.A.dylib (compatibility version 1.0.0, current version 228.0.0)
    [...output shortened...]
    @rpath/libswift_Concurrency.dylib (compatibility version 1.0.0, current version 5.7.1, weak)
    /usr/lib/swift/libswiftFoundation.dylib (compatibility version 1.0.0, current version 1.0.0)
```

Notice how a lot of libraries refer to an absolute path in `/usr/lib`, but the concurrency lib uses `@rpath`. The rpath is also something that is set inside the binary and can give the linker multiple options to go looking for a library, let’s see what the rpath options are for our library:

```bash
❯ otool -l .build/release/recorder
[...output shortened...]
Load command 45
          cmd LC_RPATH
      cmdsize 32
         path /usr/lib/swift (offset 12)
Load command 46
          cmd LC_RPATH
      cmdsize 40
         path @executable_path/../lib (offset 12)
[...output shortened...]
```

Here we see first the linker will look at `/usr/lib/swift` then it will fallback to `@executable_path/../lib`. So we need to go one folder up from the location of the executable and then go into a `lib` folder and put the library there. (A smart hack is to put the executable and dynamic library next to each other in a folder called `lib`.)

Once the library is in the right place the commandline tool will run also on older macOS versions! 🎉

### Putting the library next to the executable

In our case the `../lib` location was inconvenient and easy to get wrong. We preferred put the library directly next to the binary inside the Electron app bundle. Turns out the linker takes an rpath flag you can use to add an extra rpath: `-rpath @executable_path`

When using Swift Package Manager (SPM) you can add `linkerSettings` to the `executableTarget` in your `Package.swift` file ([example](https://github.com/nonstrict-hq/concurrency-cli-sample/blob/main/Package.swift#L12)):

`linkerSettings: [.unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "@executable_path"])]`

If you use Xcode; navigate to project settings, select the target on the left and "All" on the top. Under "Linking", find "Other Linker Flags", and enter `-rpath @executable_path`.

Now you can verify the rpath is added by running `otool` again:

```bash
❯ otool -l .build/release/recorder
[...output shortened...]
Load command 45
          cmd LC_RPATH
      cmdsize 32
         path /usr/lib/swift (offset 12)
Load command 46
          cmd LC_RPATH
      cmdsize 40
         path @executable_path/../lib (offset 12)
Load command 47
          cmd LC_RPATH
      cmdsize 32
         path @executable_path (offset 12)
[...output shortened...]
```

The last rpath option is the path we added, so if the library is not at any of the default locations the linker will look next to the executable path.

## Notes on this solution

We also reached out to Apple Developer Technical Support (DTS) and asked if having to ship the library ourselves was expected. It turns out it is, it’s just not really documented anywhere. This is because it will be automatically packaged into the bundle of Mac/iOS apps. It’s only because commandline tools don’t have a bundle themselves that this becomes a problem.

Since we’re embedding the commandline tool into an Electron app shipping dynamic library alongside the binary was no issue. Also the file size hit (±1,1MB) wasn’t considered an issue in our case. Having to ship this library as a separate file might be more problematic in other situations of course.

## References

- Nonstrict. (2023, January 24). Concurrency CLI Sample. GitHub. [https://github.com/nonstrict-hq/concurrency-cli-sample](https://github.com/nonstrict-hq/concurrency-cli-sample)
- Groff, J. (2021, October 28). *Swift concurrency back deployment.* Swift Forums.  [https://forums.swift.org/t/swift-concurrency-back-deployment/51908/20](https://forums.swift.org/t/swift-concurrency-back-deployment/51908/20)
- Eidinger, M. (2022, January 18). *Develop a command-line tool using Swift Concurrency*. Swifty Tech by Marco Eidinger. [https://blog.eidinger.info/develop-a-command-line-tool-using-swift-concurrency#heading-bonus-tip](https://blog.eidinger.info/develop-a-command-line-tool-using-swift-concurrency#heading-bonus-tip)
