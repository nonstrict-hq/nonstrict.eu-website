---
date: 2023-09-25 12:00
authors: mathijs, tom
tags: Talks
title: A Mac-tastic indie adventure
description: Mathijs gave a talk at CocoaHeadsNL about our journey as a company so far. What have we done in the last year, and what are our dreams for the future.
path: 2023/a-mac-tastic-indie-adventure
image: images/blog/2023-09-cocoaheadsnl-mathijs.jpg
featured: true
hideImageHero: false
---

Last week at [CocoaHeadsNL](https://cocoaheads.nl), a monthly meetup for iOS/macOS developers in The Netherlands, Mathijs gave a talk about our company. We started Nonstrict at beginning of 2023 with the dream of launching our own indie apps. So far, we have done client work, worked on some apps, and now we are on the cusp of lauching our biggest app yet: [Bezel](https://getbezel.app).

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=a-mac-tastic-indie-adventure" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror any iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone or wirelessly mirror it to your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div> 

The recording of the talk is included here. Below is a transcript of the talk, if you prefer to read.

<iframe width="707" height="398" src="https://www.youtube-nocookie.com/embed/ewT_f4-34nc?si=-Z7MHVAMEwcZ4bsX" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen style="max-width: 100%; vertical-align: middle"></iframe>
_Recorded September 20th, 2023 at Q42 in The Hague_

---

## Transcript

### Introduction

![Introduction slide: A Mac-tastic indie adventure](/images/blog/2023-09-cocoaheadsnl-intro.jpg)

I'm Matthijs. Fall last year, I was at a startup. I was CTO, and that startup didn't make it. We had been working on a meeting platform, where you met as little robots on a tropical island. And it was going wild during the pandemic. But after the pandemic, everybody was sick of meeting online. The situation was going down. We were at an all-time low. And in the end, the whole team got laid off, including myself.

I was out of a job, and it brought me to a point where I was wondering, "What do I want to do now? What's my next gig?" And I was thinking, I can join another startup, maybe a VC-backed startup. Could be nice. I could try my luck at a bigger corporate. I've never been at a bigger corporate. Could also be interesting.

Or maybe go back to the agency world. I've worked at Q42, where we are right now, for quite some years. I could go back to that. I wasn't really sure, so I decided to take a little time to think about it, chat with friends about what I was going to do. And one of those friends was Tom. He's standing over there. He was also at the point where he was deciding what was next for him. We were drinking a beer or two.

We started to chat about things that we really admired, like great iOS and Mac apps. We were talking about companies like Panic, you might know from Transmit. It's a really great app. A little team working on that. And that was something that really resonated with me. I was feeling that it would be really cool to create your own apps with your own company. You work on what you want to build, and really put that craft back into the apps, the craft that you can see in the greatest iOS and Mac apps. That was really something that I wanted to do.

I also really liked to do something that was not VC-backed, where you have to grow, grow, grow all the time, but do something sustainable. When you work at an agency, it's pretty nice, but you're always working for a client, working at the whims of what they want to do and what their company needs. Being independent was something that I really liked.

Basically from drinking that beer together with Tom, that got my indie adventure started. And now we're here, about a year later. Tom and I are running an indie company together. This moment especially is quite monumental for us, and it's quite exciting and also a little bit scary, because we're at a point where the dream of living from an app that we created could become a reality. That's pretty exciting and an interesting moment to tell a little bit about the journey.

### Starting Nonstrict

![Nonstrict logo](/images/blog/2023-09-cocoaheadsnl-nonstrict.jpg)

It was quite fun, and I hope I can share a little bit of the highlights. We founded our company, and it's called Nonstrict. One of the first things that happened right after we decided on a name was that a lot of questions popped up: What apps are we going to make? How is that going to make money? How do we avoid getting bankrupt in the first month? That was also a very important thing.

And also, how do we make sure that we actually work on the same goal? We're two different persons. We have different interests. We like to develop in Swift, that's a common thing. But we could have very different opinions about how to run an indie dev shop. All those questions were popping up. We decided to sit down and first talk through it and create a plan.

How are we going to do this thing? What I really liked about sitting down and creating the plan—and at the time I didn't realize this—is that it really helps us to go super fast and not talk day to day about what are we going to do, what is next. We just sit down and write code or do whatever we think is important that day, and we don't need a lot of communication.


### The Plan

![Illustration of a flowchart: Our Dream → Year → Quarter → Week → Day](/images/blog/2023-09-cocoaheadsnl-plan.jpg)

When creating this talk I realized this was something that I should have done earlier in my career, also at other places, and not only now at my own company. A big part of that is how our planning is structured.

We have our dream. Our dream is to be that indie company having maybe four apps that are making the money that we need to be self-sufficient. But that's a really big goal. I can't work on that day to day. I have no idea what I should do when I sit down behind my desk and go work on that.

We started to break it down. If we take the first year, what's the goal for the first year? The goal for the first year is to not go bankrupt. That's a very important part of the goal. And the other thing is that we wanted to prove to ourselves that we can build an app that is really interesting to other people, that people are actually using—not some app that we find fun and is super polished, and then we release it and nobody's using it, nobody's paying money for it. We don't have to be self-sufficient based on our app in the first year, but we do want to see proof points that people are using it.

That really helped to break it down again into the first quarter. In the first three months, what do we want to do? Are we working on not going bankrupt and getting a client immediately, or doing some freelance work? Because that was what we decided: being self-sufficient from our own apps is too risky. Let's do a little bit of client work, make some money, keep ourselves alive, and then also create time to work on our own apps.

The decision was: in the first quarter, let's first focus at least the first month and a half on building an app. Because we were very afraid that we would turn into an agency. We were both coming from an agency. Taking the money from a freelance job was very quick and easy compared to building your own app. We were really afraid that we would not get into building our own app. We decided, first things first, build our own app, build momentum in doing things for yourself, and then find a freelance or consultancy gig to make money from.

That gave us a clear goal for the quarter. We basically already got started by then doing day-to-day things. And then we realized, wait, we need to plan just the week. Every Friday, we sit down for about an hour and say, what are the important things for next week? What are we going to work on? Are there clients we have to call back? Are there important bugs that we absolutely need to fix? We list that, and that's all the planning that we do.

Day to day, there's no standup or anything. We just sit down, and we know this is the goal for the week. This is the goal for the quarter. This is what we're going to work on this year. And this is the dream that we want to get to. Whatever needs to be done to get there, that's what we do.

That gives us a lot of speed, a lot more than I've seen in teams that I've worked in. It's always a lot of "Am I doing the right thing?" If you know what the goal is for every size of time increment, then you can decide for yourself, especially if you're capable, intelligent people like all of you here. That worked really well. Q1 was for our own app, working on that. Next to founding the company, by the way—that's also a lot of work. That was also something we did in the first quarter.

### The Tweet

![Screenshot of tweet by Adam Pietrasiak, transcribed below](/images/blog/2023-09-cocoaheadsnl-tweet.jpg)

With all the planning in place, we started. And then [this tweet](https://twitter.com/pie6k/status/1605511466957697025) came along from Adam. He makes ScreenStudio. He tweeted: "I'm looking for a bad-ass Swift developer to write a binary CLI for screen recording on steroids. The spec is over here" (Notion link). "If you're not a super experienced developer, please, please do not DM me. It will 100% not end well and we'll waste each other's time. No agencies as well. DM me."

Now, that was obviously Tom and me, right? I was actually very nervous to contact him based on all those superlatives. And "don't contact me when you're an agency"—we're two people, so he's probably going to think we're an agency when he sees the company name.

But I did text Tom: this is a very interesting thing because it's a macOS thing to work on and not iOS, which we did a lot. It's a command line tool, which is very different from a lot of UI apps that you make where you pull something from the server. Screen recording was very interesting to me.

The Screen Studio app is also a really great, polished app, and it was already getting traction. We DMed him. There was a lot of back and forth in the first month of our company. And then we got the job—plan failed.

We already had our first gig before we even started on our own app. We were only busy founding the company, getting this client in, and then there was no work done on any of our own ideas.

If you're going to do planning and going for a goal, that's something you have to keep in the back of your mind: if your plan comes in contact with the real world, it immediately fails. You have to adjust. And that's OK. We still do that a lot. The third quarter that we're in now, three weeks in, we totally changed our quarter goals because it was super clear that we had to do something else that was way more effective to reach our dream in the end.

That's good, but the plan really helps us day to day. And this job we did for Adam was really interesting because it had a lot of impact on everything we did after.


### Screen Studio

![](/images/blog/2023-09-cocoaheadsnl-screen-studio.jpg)

What is [Screen Studio](https://screenstudio.lemonsqueezy.com?aff=nXV1B)? Screen Studio is a screen recorder. You just record your screen as you would always do. And then after you did the recording, Screen Studio applies effects on it automatically. It zooms in when you click somewhere. It moves with your mouse cursor automatically. Once it's zoomed in, it makes the mouse cursor bigger. It has all kinds of special curves for zooming and panning that feel really movie-like.

You can also edit it yourself. But the real magic is that once you have done the recording, this is just clicking those things, hitting export, and then you get the video. This has become quite popular.

Companies like Stripe and Figma have used it to do product videos that are in their help pages or in their marketing materials. That's a pretty cool product that he created. He's just all on his own. He has now two good friends who are helping with support, but he's the sole developer of the app.

The app is in Electron. That was one of the parts why he wasn't able to—he was also a front-ender from his previous job. The front-end is awesome, and he did a lot of awesome back-end work to do the movie stuff. But a command line binary in Swift, calling native APIs on macOS was a bridge too far for him.

That's what we created for him, really a binary. His Electron app calls out to the binary and gives us a set of configuration options, what we need to record for him. Then we just kick off the recording until we get a signal from him to stop the recording. And then we wrap it all up.

We don't record one source. It's not only screen recording. We also record system audio, microphone, webcam. Mouse movements are recorded. Keyboard input is recorded if you want that. And you can even choose to record multiple of those sources at the same time.

The main job of the recorder that we created is to keep all those things in sync and make sure the recording is perfectly aligned, so you don't have time shifts in everything, and also be performant enough to do this. Because Adam wanted it to be compatible with macOS 10.15, we needed to be backwards compatible a little bit. That was doable, but also quite a challenge, because it also opened up a lot of different Mac hardware that we had to support.

One of the things that made it really interesting, as I said, is that the command line thing has no UI at all. We can also not pop up any UI. The only thing that we can do is report errors back to Adam's Electron app, and then he can handle it. But that's also the end of the recording then.

It's really confined, and we just need to handle everything. If it is an error that we can recover from, we just have to do it. You also can't interrupt the user during a screen recording, because that's also the end of the screen recording then. The user is then totally confused.

That also made it really hard to troubleshoot issues for us, because we don't have direct contact to the users. Users will contact Adam. We don't have any UI that we can pop up to tell the user exactly what's happening. There is no UI you can click through or see to debug things if the user sends a video or something.


### Logging

![Slide about Logging, described in text below](/images/blog/2023-09-cocoaheadsnl-logging.jpg)

That's why we decided very early on to invest a lot in logging in this scenario. Logging is pretty obvious. You can just start logging. But I think there are a few things that really helped us with Screen Studio. Here are some practical tips.

The first tip is: write logs and put them somewhere where you can actually recover them. I've done that a lot, and I realized in iOS apps I was just adding a log, and that's handy for development. Sure, but if a user is going to call you and say their app is not working, how do you pull those logs? How do you get those logs from the user to you so you can actually inspect them?

What we do is write them to a file next to all the movie recordings. That's wrapped up in a Screen Studio package. Adam often asks, can you send me the Screen Studio package of the failed recording? And then the log is also in there. They automatically send the log over. Adam then forwards us the log, and we can inspect what was happening.

Also, log all context you would want to ask a user about. We didn't do this perfectly in the beginning. What happened was I got a log, and then I replied to Adam: I need to know what Mac this user had, what macOS version was he on, what devices was he using.

At the start of a recording, we first log: we are running on a device of this model. This is the OS version. This is the app version of Screen Studio. This is the app version of the binary. These are all the devices that we're going to record. These are all the configuration parameters that we've got, so that all the context is clear.

As we start recording, we also log: this is the webcam that we're using, it's in this configuration mode. We know a lot about what's going on and basically never want to go back to the user to ask what's happening.

One neat trick that I got somewhere from the internet—I forgot where—is to wrap every action you do.

For example, we need to configure the webcam. If we start configuring, we do a debug log and say we're now going to configure the webcam, and this is the configuration we're going to apply. Then once we've done that, do an info log statement where we say we have now configured the webcam, it is now in this state, and log the state of the webcam that it actually is in now.

That really helps. The debug info works nicely with OS log, for example, because debug logs are kept in memory, and after there are too many they are dropped. It depends a little bit on the framework you're using.

The point is that if you do that before and after the action, if something goes wrong in between, or you think you have applied a certain configuration, you can see that you tried to set the webcam at a certain resolution, but it just refused to do that. And that's where the bug is.

Only logging it before or after often fails. If it just throws an error in between, an exception is raised, then you don't know that you've started to configure the webcam, and that's where the error is. That's one of the things that was really helpful when looking for issues and troubleshooting users.

I can really recommend doing this. It will add clutter to your code base, because everything will get two lines around it, especially in short functions. But it really helps. And of course, warn and error about issues that you encounter. I think that's quite a logical one.

If you want to get started with this in Swift, OSLog is great, especially in the new Xcode version, where you have the new console. You have great filters on categories or other fields that you add in your logging. OSLog is great if you're doing an iOS app. For the console app that we did, we used the Apple Swift Log package. That was really convenient to just write it out. We couldn't access the console anyway as a child process. For us, that was easier. Those are quite great choices if you want to look into logging.


### ScreenCaptureKit

![](/images/blog/2023-09-cocoaheadsnl-screencapturekit.jpg)

All the logging aside, one of the most important things Adam wanted to improve was screen capturing. In recent macOS versions, ScreenCaptureKit was introduced—in macOS 12.3. We rely on ScreenCaptureKit to do a lot of the screen capturing in the recorder.

The neat thing is that it can also capture audio. Before ScreenCaptureKit, you always needed to install some kind of kernel extension thing to hijack the audio. That was very inconvenient. Apple also makes it harder and harder with every macOS version to protect the system.

With ScreenCaptureKit, you can just access it. That's perfectly allowed. As long as the user allows the recording, everything is good.

What's really cool is that you can not only record the whole screen. You can also choose to record one window. But you can also choose to record the whole screen and exclude a window. For example, when you do a recording and you have a little webcam in the corner as a preview to the user, you probably don't want to have that in the recording, because you can just record the webcam feed separately. Then you can, with ScreenCaptureKit, create a filter. You exclude the webcam preview from the recording, and it's just not there. That's really neat. You can also disable the cursor.

A really neat feature is that it only sends you frames when something changed. If the screen is perfectly still, like it is now, then you will receive one frame of this image, and then nothing else until something changes on the screen, and then it will deliver the new frame to you. That really helps in being efficient if you do a streaming thing, or just doing less work if you do image manipulation on the stream.


### ScreenCaptureKit - Recording to disk

![](/images/blog/2023-09-cocoaheadsnl-screencapturekit-record.jpg)

One of the things ScreenCaptureKit doesn't do by itself is recording to disk. ScreenCaptureKit is really created and pitched all the time as something to stream video over the network. But I think a pretty great use case is to just record to disk. We had to figure it out ourselves. We do have a [blog post](/blog/2023/recording-to-disk-with-screencapturekit/) about this if you want to try it yourself.

What's really interesting is that what ScreenCaptureKit needs to record to disk is very much the same as recording a webcam to disk. These are all really the same concepts over and over.

What you need if you want to do screen capturing with ScreenCaptureKit is create a ScreenCaptureKit stream. You can create an object and set filters on it. Then you tell the ScreenCaptureKit stream to start capturing. It will call a delegate method. And the delegate method will get a CMSampleBuffer.

A CMSampleBuffer is an object that's as old as macOS is, I think. It contains data, so the video itself is in there, so it can be really big. And timestamps and metadata about that certain frame, the time the frame is, the duration of the frame. It can also contain audio. It's the same structure. A neat thing is webcams will also deliver CMSampleBuffer.

A microphone will also deliver CMSampleBuffers. As soon as you have configured something that does capturing or recording, you get that sample buffer. From there, you can put it in the same code path you use for all this stuff. You can then pass it on to an AVAssetWriter. AVFoundation has this class, and it's optimized to write video files and audio files to disk. It also does all the encoding stuff for you.

The sample buffers often are uncompressed data when you work with capture devices. The webcam just gives you the raw image that it captures. A screen capture stream just gives you whatever is on the screen, uncompressed. The AVAssetWriter knows how to compress it, and it's all hardware accelerated.

That's pretty neat. Then you can output it to a file. You can also fiddle with settings and do other compressions. That can become quite complex, but the basics are pretty neat.

The bottom side here of the AVAssetWriter is also something that you can customize. If you don't want to write out to a file, but want to do a live preview window, for example, with a webcam, or have a live preview of what you're streaming to people on a Zoom meeting, you can also put the same sample buffer into a view that supports that. Apple has a special layer that supports displaying sample buffers. Then you have a live preview. That also works for all those sources.

You can switch out the top thing or the bottom thing, and they all work with CMSampleBuffers all the time. If you're going into capturing, learn about CMSampleBuffer, because that's a very valuable thing to know about. If you want to play around with ScreenCaptureKit and recording, look at our blog, because there's a ready-to-go sample to fiddle around with.



### Other apps & clients

![](/images/blog/2023-09-cocoaheadsnl-screencapturekit-other-apps.jpg)

With all this recording experience, we started to work on some of our own ideas. This icon is from [CleanPresenter](https://cleanpresenter.com). That's one of the first apps that we released. With CleanPresenter, you can take over an external screen and only show one app. It also uses ScreenCaptureKit to capture that one app and then display it on another place. It's basically streaming, but on your local Mac.

What's also interesting is that we got more and more clients who knew, hey, you know stuff about macOS capturing, so maybe you can help us out with our app, with the streaming app or another kind of recording app. That was pretty fun. We dig deeper and deeper into weird issues and APIs.

How did they find us? Through our blog. Every time we encountered an issue that wasn't easy to solve, we basically wrote a blog about it, like "how do you write a file to disk with ScreenCaptureKit"—that wasn't obvious.

People started to find those blogs and that was really fun and nice, not only because it got us clients, that's nice too of course, but we also every now and then get an email from a random person on the internet working on a random app that's saying, whoa, you've solved my problem. I was looking for this, and I couldn't find it on Stack Overflow, but I stumbled upon your blog.

I found that was really nice, and we had some fun conversations over email about, did you solve this weird issue? Or did you get a workaround from Apple because you're at a big company? We were asking them, you're at a big company, so maybe Apple is helping you—do you have more info? That's a really fun thing to do, and it really helps to have a little bit of exposure and interesting conversations with people.

### Feedback, DTS & WWDC Labs

![](/images/blog/2023-09-cocoaheadsnl-feedback-assistant.jpg)

We don't only blog about issues. We also report them to Apple in the Feedback Assistant. You might know the Feedback Assistant. In more than 10 years of Apple development, I think I created three radars or feedbacks. Now, nine months into working at our company, I created more, together with Tom, than fit on the screen.

What really changed, I think, is that our mindset is now: if we encounter a bug in Apple's system, once we've figured out what it is and have a workaround, we just stop working for a moment and put in feedback with Apple.

If you do it at that moment, you know all the context you need. It's fresh in your mind, and it's pretty easy to type it in. You can at least shoot in feedback and tell them, please fix this, because it's a weird bug.

Since we also now try to blog about it once we encounter a thing, it's also like 50% of the work that needs to go into the blog. If we need to do a sample project, that's a little bit more work. But then it's shared between the blog and the feedback, and it's a lot more fun to create a sample project instead of only submitting it to Apple and not knowing if they are going to do anything about it. That's a pretty interesting thing.

I think it's also something we all can do. If you encounter something and you figure it out, submit that feedback to Apple. They're always asking about it. Please do this.

I've tried it myself before. If you say, no, I've figured out how to work around this, but I'm first continuing on this project—then the next day, you try to submit the feedback. And there's already so much more work that you're just not going to do it. My advice: just stop working there, take 30 minutes, write out the feedback and submit it to them. At least that's then a vote for "please fix this bug."

If we have filed feedback for an issue that we think should be better, or we have a very awkward workaround for something, or sometimes we don't even have a workaround and we're just stuck—we contact Apple developer support. You have two free tickets on every paid Apple account to contact Apple and ask them a question on the code level.

I think I've never used that while I was working here at Q42, maybe twice in my whole career here. But it's really a steal. You can even purchase extra tickets for about $50. That's nothing compared to your hourly rate.

I would really encourage you to do this, because what we do is submit the issue and say, we have this issue. Here's the feedback. We already filed the feedback, so don't ask us to file feedback—it's already done. You can look into this. Can you find us a workaround for this? Can you confirm it is an issue, and can you find us a workaround?

Sometimes we just get a confirmation: it's an issue, we don't have a workaround, we're very sorry. But at least then you know you can stop looking for a workaround, because it isn't there.

Sometimes you get someone in DTS that's really dedicated and actually contacts a team, asks a developer, what can we do here? And they come back with a workaround that you couldn't think of yourself. Or they can confirm, if you call it the other way around, I can't officially confirm that it will work, but it probably will work—just try it. You have an interesting workaround to get around things. That really helped us.

If you already have a feedback submitted, it's really easy to also submit a DTS. It's the same thing copied over. Then just ask, can you confirm this is an issue? Do you have a workaround? That's also a really interesting thing to do. I think it's really valuable to see what you get there.

One thing they also can do is walk over to the team that's responsible for fixing that bug. I have a DTS engineer that told me, I've asked the team to look into that issue to see if they can resolve it. Then you never hear anything again from Apple. But at a future release, suddenly it's fixed. This might have contributed a little bit to getting that fixed.

The last thing that's really fun and valuable is: if you have all those feedbacks, it's basically an archive of everything you bumped into through the year.

Once WWDC hit, we attended a lot of labs that are relevant for all the feedback tickets that we submitted. Sometimes you get a DTS engineer that's responsible for that. I had the case where I just got the DTS engineer that actually answered my ticket already and told me, I already have looked into it, I don't have anything else to say about the ticket.

But Tom actually got in touch with the ScreenCaptureKit team, the actual engineers that work on ScreenCaptureKit. That's super valuable. Then you just have a chat about the issues that you bumped into, maybe the feature requests that you sent in. It really can give a little bit of insight that you otherwise can't get. That's really fun to do, and really valuable.

I've attended a few labs with a few random questions that I could come up with during WWDC before, but now we had this long list that we could just submit and get super valuable information from them. That's also something I really can advise to do. It's a really easy way to maintain that list.

There was a lot of fun working on capturing stuff and, well, encountering a lot of bugs, reporting them. Working on so much capturing things also gave us a lot of capturing ideas to work on. We already worked on CleanPresenter. But at some moment, Tom said, what we really should do is finally create this app that mirrors your iPhone. Because that's always something we were struggling with, with QuickTime. Our new app idea was Bezel.


### Bezel

![](/images/blog/2023-09-cocoaheadsnl-bezel.jpg)

Over here, this is the app icon. And [Bezel](https://getbezel.app) is an app where you can plug in your iPhone to your Mac with a cable, and it just appears on your Mac.

It was something that we thought, well, we have all the knowledge here. We know how stuff works. We already did screen capturing of the devices for other work. Why not create the best and simplest mirroring app that we can? It was pretty fun to do because we did the smallest prototype.

Maybe you have heard of Jordi Bruin. He has a 2-2-2 method where he takes two hours to prototype something really quickly, and then two days to make it a little bit better and share it with some friends. Basically, we took a day to gather a prototype, put a tweet out, and immediately there was a reaction.

People were asking, whoa, what app is this? I want to try this app. Where can I get it? There's nothing more than a video and a few ugly hacks in Xcode. We put a Google form below the tweet and said, give your email address if you want to be kept up to date. That was pretty cool.

Now we've developed the app further. I can give a little demo of what we've created. Let me switch the screen mirroring mode. If I take out my iPhone, plug it in, then it shows up. And now you see my home screen with my kid and my wife on there. That's basically it. That's the app. You just plug in your iPhone, and then it's mirrored. It's perfect for demo.

It was really something we wanted to create. Because every time I gave a demo at Q42, I was always fiddling around with QuickTime. It was this square thing. I had clients ask me, am I looking at the iPad or at the iPhone app? I'm not sure. It's just a square, so I'm not sure what I'm looking at. If you rotate the phone, it looks awkward. Those are things we fixed.

I think that's one of the things that's really nice about building your own software, and especially for a use case that you know really well: you know what you want to fix and what to make great.

One of the things we also invested in is this little wizard. It's really awkward when you plug in a phone for the first time. I don't know if you've done that. Try to mirror a new iPhone with QuickTime during a demo where you're under stress. It has to work now, and then it doesn't work. That's because you need to do a lot of steps correctly. We really tried to help the user.

We say, connect and unlock an iPhone. I pulled this iPhone from the device wall over here at Q42. It has never been connected to my Mac. Once I attach the phone, first, my Mac is an Apple Silicon Mac, so it's not allowing me to connect to any USB device without confirming that it's OK. That's also what Bezel is telling me now: click that Allow button. And it's confirming that it's working. Great.

Now I have to tap Trust on my iPhone. There is a Trust button now on the iPhone. I'll tap that, put in the passcode, and it confirms you've done that. Now I have to reconnect the iPhone. This is the most awkward part, and QuickTime is not helping you with that. It's like, I've trusted, so why isn't it working? We also try to help you there. Pull the cable out, put it back in, and there you go. This is also an extra pop-up that we should help you with. And now it's here. Now it's mirroring. Let me see if I can enlarge the thing. Now it's working. That's also something we invested in.

It was pretty fun to work on because it's a lot of different APIs working together. It's AVFoundation that's basically doing webcams all the time. That's telling us what the state of the camera is, combined with some private APIs from Apple to know more about the device and what state it's in. That was really fun to create.

One of the features of Bezel is that it detected that this is a white iPhone, so it's showing the white bezel around it. But you can also switch that. If I want the space gray version, I can just switch over to the other bezel.

This is one of the apps we're working on right now. We had quite a beta group that was giving us feedback on what to improve. That was really fun. Really enthusiastic users already. Next week is the moment that we go live with Bezel. I'm really curious what it will do, what kind of traction it will get, and whether it will help us reach our dream of becoming sustainable from our own apps instead of client work. I can't tell you right now.

Next week I will know more. And I hope to give an update in, let's say, about a year or so on where we're then with what apps we're developing at that moment. Thank you. Thank you for your time.


### Q&A

![](/images/blog/2023-09-cocoaheadsnl-audience.jpg)

**Q: In order to be a sustainable business, you need to make some money. How is this app gonna bring in the money?**

A: We're going to charge money for it. You can download the app for free and there will be a little watermark on the phone. It's a one-time purchase that you can do on our website. Then you unlock the phone and remove the watermark.

**Q: Are there any plans to get Bezel working with the Apple TV? Because that's wireless data streams.**

A: We have a lot of ideas and things we want to implement. I do think wireless will be something that we will implement at some point, because a lot of people are asking for that just when using it with a Mac. Once we go wireless, it is really interesting to also be on the Apple TV. Yes, absolutely a dream. I really want to be there. But I think we first have to prove that this concept is working at all and people are actually using it.

**Q: A follow-up question. What I actually meant is connecting or like displaying the Apple TV within Bezel.**

A: Ah, that would also be an awesome thing to do. I really would love to support other devices like Apple TV, but also Apple Watch. If you work on an Apple TV or an Apple Watch app, it would be really neat to be able to display the actual thing and share that. That's something I really want to do. But first things first: completing this iPhone version, wired on the Mac, making that really good and adding some features there.

**Q: So for supporting other devices, do you already have clues that it is possible or is this and you haven't actually investigated yet?**

A: I think for a lot of devices, it's possible to create something like that. Especially to show that device on your Mac. For Apple Watch, we have some ideas and directions that work—I've fiddled around a little bit with what we can do. On other platforms, we also have some ideas. I'm pretty certain that we can do that.

**Q: Thank you very much for your great presentation. I was just wondering how long have you been busy, the two of you on this, because maybe you said in the beginning. When did you start with Nonstrict, and then this whole journey, how long has it been?**

A: The company started in January. December was when we got Adam as a client. That's the point where we started. Nine, ten months now.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=a-mac-tastic-indie-adventure" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror any iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone or wirelessly mirror it to your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div> 

_Transcript created with [MacWhisper](https://goodsnooze.gumroad.com/l/macwhisper)._
