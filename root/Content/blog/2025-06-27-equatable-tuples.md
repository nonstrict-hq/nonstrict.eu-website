---
date: 2025-06-27 12:00
authors: mathijs, tom
tags: Engineering
title: Creating Equatable Tuples in Swift using Parameter Packs
description: Swift tuples don't conform to Equatable. We use parameter packs to create a tuple-like struct with Equatable conformance.
image: images/blog/michele-wales-ziOcPTkUDQY-unsplash.jpg
path: 2025/creating-equatable-tuples-swift-parameter-packs
featured: true
---

**tldr; Parameter packs are great to create an `Equatables` struct that wraps multiple values and conforms to Equatable, perfect for SwiftUI's onChange and similar APIs.**

When building SwiftUI views, every now and then you might need to observe changes to multiple values simultaneously. My instinct is to use a tuple like `(foo, bar)` in an `onChange` modifier for this. 

However Swift has a limitation where tuples don't automatically conform to Equatable, even when all their elements do. There is an [accepted proposal from 2020](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0283-tuples-are-equatable-comparable-hashable.md) that still isn't implemented yet, so sadly this approach won't work.

Writing a specific wrapper struct is a bit annoying when you just have two equatable values and simply want to trigger an action when either changes. You could observe them separately with multiple `onChange` calls, but that's also not ideal leads to duplicated code paths and might lead to potential synchronization issues.

## A Parameter Pack Solution

If you support iOS 17+ only you can use the Swift parameter packs feature! This allows us to create a struct that accepts a variable number of parameters. We can declare we only accept `Equatable` parameters and therefore are ourselves also `Equatable`. This is a perfect way of building a tuple-like type that we can use instead of a regular tuple.

Here's the `Equatables` struct we use throughout our apps:

```swift
@available(iOS 17.0, *)
@available(tvOS 17.0, *)
@available(macOS 14.0, *)
@available(watchOS 10.0, *)
@available(visionOS 1.0, *)
struct Equatables<each T: Equatable>: Equatable {
    let values: (repeat each T)

    init(_ values: repeat each T) {
        self.values = (repeat each values)
    }

    static func == (lhs: Equatables, rhs: Equatables) -> Bool {
        for isEqual in repeat each lhs.values == each rhs.values {
            guard isEqual else { return false }
        }
        return true
    }
}
```

The struct uses parameter packs (indicated by `each T`) to accept any number of `Equatable` types. The `repeat each` syntax expands the pack to create a tuple of values internally. The equality operator in turn iterates through each pair of corresponding values, comparing them one by one—if any pair differs, the entire struct is considered unequal.

## Usage Example

Here's how you'd use it in a SwiftUI view:

```swift
struct ContentView: View {
    @State private var searchText = "Dog"
    @State private var selectedCategory = .animals
    
    var body: some View {
        List {
            // Your view content
        }
        .onChange(of: Equatables(searchText, selectedCategory)) { oldValues, newValues in
            // This fires when either searchText OR selectedCategory changes
            performSearch()
        }
    }
}
```

Instead of writing separate `onChange` modifiers or creating a custom struct for each combination of values you want to observe, you can simply wrap them in `Equatables` and pass them as a single unit.

## Wrap Up

This simple pattern eliminates a common pain point in SwiftUI development. By leveraging parameter packs, we get tuple-like convenience with proper Equatable conformance. However it would still be great if Swift would get automatic conformance to things like `Equatable` and `Hashable`. Let's hope that proposal will be implemented and we'll get this feature in a future version of the language!

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=creating-equatable-tuples-swift-parameter-packs" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=creating-equatable-tuples-swift-parameter-packs" target="_blank">Bezel · Mirror any iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone and it automatically shows up on your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=creating-equatable-tuples-swift-parameter-packs" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=creating-equatable-tuples-swift-parameter-packs" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div>

## References

- Alejandro Alonso. (2020). SE-0283: [Tuples Conform to Equatable, Comparable, and Hashable](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0283-tuples-are-equatable-comparable-hashable.md) Swift Evolution.
- Holly Borla, John McCall, Slava Pestov. (2023). SE-0393: [Value and Type Parameter Packs](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0393-parameter-packs.md?ref=fline.dev) Swift Evolution.
- Apple. (2023). Session 10168: [Generalize APIs with parameter packs](https://developer.apple.com/videos/play/wwdc2023/10168/)

