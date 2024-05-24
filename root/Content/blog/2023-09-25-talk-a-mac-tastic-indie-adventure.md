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
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror your iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone and it automatically shows up on your Mac.</p>
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

So I'm Matthijs. And fall last year, I was at a startup. I was CTO, and that startup didn't make it. We had been working on a meeting platform, where you met as little robots on a tropical island. And it was going wild during the pandemic. But after the pandemic, everybody was sick of meeting online, etc. The situation was going down. We were at an all-time low. And in the end, the whole team got laid off, including myself.

So, yeah, I was out of a job, and it brought me at a point where I was wondering, "What do I want to do now? What's my next gig?" And I was thinking, "OK, I can join another startup, maybe VC-backed startup, something like that. Could be nice. I could try my luck at the bigger corporate maybe. I've never been at the bigger corporate. Could also be interesting.

Or maybe go back to the agency world. I've worked at Q42, where we are right now, for quite some years. So I could go back to that. And I wasn't really sure. So I decided to take a little time to think about it, chat with friends about what I was going to do. And one of those friends was Tom. He's standing over there. And he was also at the point where he was deciding what was next for him. So we were drinking a beer or two.

We started to chat about things that we really admired, like great iOS and Mac apps. We were talking about companies like Panic, you might know from Transmit. It's really a great app. A little team that's working on that. And that was something that really resonated with me. I was feeling like, OK, that would be really cool if you create with your own company, your own apps. You work on what you want to build, and really put back that craft in the apps that you really can see in the greatest iOS and Mac apps. So yeah, that was really something that I wanted to do.

And I also really liked to do something that was not VC backed, where you have to grow, grow, grow all the time, but do something sustainable. And also, when you work at an agency, it's pretty nice, but you're always working for a client, so you're working at the whims of what they want to do and what their company needs or what they find important. So being independent also was something that I really liked.

So yeah, basically from drinking that beer together with Tom, that got my indie adventure started. And now we're here, we're now like a year later. Tom and I are running an indie company together. And this moment especially, yeah, is quite monumental for us, and it's quite exciting and also a little bit scary, scary, because we're at a point that that dream of becoming and living from an app that we created could become a reality. So that's pretty exciting and an interesting moment to tell a little bit about the journey.

### Starting Nonstrict

![Nonstrict logo](/images/blog/2023-09-cocoaheadsnl-nonstrict.jpg)

So it was quite fun, and I hope I can share a little bit of the highlights. So we founded our company, and it's called Nonstrict. And one of the first things that happened right after we decided on a name was that a lot of questions basically popped up, like, OK, what apps are we going to make? How is that going to make money? How do we avoid getting bankrupt in the first month? That was also a very important thing. And also, how do we make sure that we actually work on the same goal? Like, we're two different persons. We have also other interests. We like to develop in Swift. That's a common thing. But we could have very different opinions about how to run an indie dev shop. So all those questions were popping up. And we decided to sit down and basically first talk through it and create a plan.

Like, OK, how are we going to do this thing? And so what I really liked about that we sat down and created the plan, and at the time I didn't realize this, but it really helps us to go super fast and not talk day to day, talk a lot about what are we going to do, what is next. We just sit down and write code or do whatever we think is important that day and we don't need a lot of communication.


### The Plan

![Illustration of a flowchart: Our Dream → Year → Quarter → Week → Day](/images/blog/2023-09-cocoaheadsnl-plan.jpg)

And when creating this talk I realized this was something that I should have done earlier in my career also at other places, and not only now, it's my own company. And a big part of that is how our planning is structured basically. So we have our dream. Our dream is to be that indie company having maybe four apps that are making the money that we need to be self-sufficient. But that's a really big goal. I can't work on that day to day. I have no idea what I should do when I sit down behind my desk and go work on that.

So we started to break it down, and we were thinking, OK, but if we take the first year, so what's the goal for the first year? The goal for the first year is to not go bankrupt. That's a very important part of the goal. And the other thing is that we wanted to prove to ourselves that we can build an app that is really interesting to other people, that people are actually using, so not some app that we find fun and is super polished, and then we release it and nobody's using it, nobody's paying money for. So we don't have to be self-sufficient based on our app in the first year, but we do want to see that there are proof points that people are using it.

So that really helped to break it down again into the first quarter. OK, in the first three months, what do we want to do? Are we working on not going bankrupt and getting a client immediately or doing some freelance work? Because that was what we decided, like being self-sufficient of our own apps is too risky. So let's do a little bit of client work, make some money, keep ourselves alive, and then also create time to work on our own apps.

So the decision was, no, in the first quarter, let's first focus at least the first 1 and 1/2 month or so on building an app. Because we were very afraid that we would turn into an agency. We were both coming from an agency. And taking the money from a freelance job was very quick and easy compared to building your own app. So we were really afraid that we would not get into building our own app. So we decided, first things first, build our own app, build momentum in doing things for yourself, and then find a freelance or consultancy gig to make money from.

So that gave us a clear goal for the quarter. And we basically already got started by then doing day-to-day things. And then we realized, oh wait, we need to plan just the week. So every Friday, we sit down for like an hour. And we say, OK, what are the important things for next week? What are we going to work on? Are there clients we have to call back? Are there important stuff or bugs that we absolutely need to fix? We list that, and that's all the planning that we do.

So day to day, there's no stand up or anything. We just sit down, and we know this is the goal for the week. This is the goal for the quarter. This is what we're going to work on this year. And this is the dream that we want to get to. And whatever needs to be done to get there, that's what we do. And that gives us a lot of speed, a lot more than I've seen in teams that I've worked in. It's always a lot of, oh, am I doing the right thing? If you know what the goal is for every size of time increment, then you can decide for yourself, basically, especially if you're capable, intelligent people like basically all of you here. So that worked really well. So yeah, that was great. So Q1 was for our own app, work on that. Next to founding the company, by the way, that's also a lot of work. That was also something we did in the first quarter.

### The Tweet

![Screenshot of tweet by Adam Pietrasiak, transcribed below](/images/blog/2023-09-cocoaheadsnl-tweet.jpg)

So with all the planning in place, we started. And then [this tweet](https://twitter.com/pie6k/status/1605511466957697025) came along from Adam. He makes ScreenStudio. He tweeted this. "I'm looking for a bad-ass Swift developer to write a binary CLI for screen recording on steroids. The spec is over here" (Notion link). "If you're not a super experienced developer, Please, please do not DM me. It will 100% not end well and we'll waste each other's time. No agencies as well. DM me".

Now, that was obvious Tom and me, right? I was actually very nervous to contact him based on all those superlatives. And don't contact me when you're an agency. I was like, we're two people, so he's probably going to think we're an agency when he sees the company name, et cetera. But I did text Tom, OK, this is a very interesting thing because it's a macOS thing to work on and not iOS, which we did a lot. It's a command line tool, which is very different from a lot of UI apps that you make where you pull something from the server, et cetera. Screen recording was very interesting to me.

And the Screen Studio app is also a really great, polished app, so it's really cool. And it was already getting traction. So that was super cool. So we DMed him. There was a lot of back and forth in the first month of our company. And then we got the job, so plan failed.

We already had our first gig before we even started on our own app. We were only busy founding the company, getting this client in, and then there was no work done on any of our own ideas. And I think if you're going to do planning and going for a goal, that's something you also have to keep in the back of your mind. Well, if your plan comes in contact with the real world, it immediately fails. So you have to adjust. And that's also OK. We do that still a lot. The third quarter now that we're in, three weeks in, we totally changed our quarter goals because it was super clear that we had to do something else that was way more effective to reach our dream in the end. So that's good, but the plan really helps us with day to day. And I think this job we did for Adam was really interesting because it had a lot of impact on everything we did after.


### Screen Studio

![](/images/blog/2023-09-cocoaheadsnl-screen-studio.jpg)

So what is [Screen Studio](https://screenstudio.lemonsqueezy.com?aff=nXV1B)? Screen Studio is a screen recorder. So you just record your screen as you would always do. And then after you did the recording, Screen Studio applies effects on it automatically. So it zooms in when you click somewhere. It moves with your mouse cursor automatically. Once it's zoomed in, it makes the mouse cursor bigger. It has all kinds of special curves for zooming and panning that feel really movie-like. You can also edit it yourself. But the real magic is that once you have done the recording, This is just really clicking those things, hitting export, and then you get the video like this. And this has become quite popular.

Companies like Stripe and Figma have used it to do product videos that are in their help pages or in their marketing materials. So that's a pretty cool product that he created. And he's just all by his own. He has now two good friends who are helping with support, et cetera. But he's the sole developer of the app. And the app is in Electron. So that was one of the parts why he wasn't able to-- he was also a front-ender from his previous job. So the front-end is awesome, and he did a lot of awesome back-end work to do the movie stuff. But a command line binary in Swift, calling native APIs on macOS was a bridge too far for him.

So that's what we created for him, really a binary. His Electron app calls out to the binary and gives us a set of configuration options, what we need to record for him. Then we just kick off the recording until we get a signal from him like, OK, now stop the recording. And then we wrap it all up. And we don't record one source. So it's not only screen recording. We also record system audio, microphone, webcam. Mouse movements are recorded. Keyboard input is recorded if you want that. And you can even choose to record multiple of those sources at the same time.

So the main job of the recorder that we created is to keep all those things in sync and make sure the recording is perfectly aligned, so you don't have time shifts in everything, and also be performant enough to do this. Because Adam wanted it to be compatible with macOS 10.15, So we needed to be backwards compatible a little bit. And that was doable, but also quite a challenge, because it also opened up a lot of different Mac hardware that we had to support.

One of the things that made it really interesting, as I said, is that the command line thing has no UI at all. We can also not pop up any UI. The only thing that we can do is report errors back to Adam's Electron app, and then he can handle it. But that's also the end of the recording then. So that's it. So it's really confined, and we just need to handle everything, basically. If it is an error that we can recover from, we just have to do it. You also can't interrupt the user during a screen recording, because that's also the end of the screen recording then. The user's then totally confused.

And that also made it really hard to troubleshoot issues for us, because we don't have direct contact to the users. Users will contact Adam. We don't have any UI that we can pop up, so we can tell the user exactly things that are happening. There is no UI. You can click through or see to debug things if the user sent a video or something.


### Logging

![Slide about Logging, described in text below](/images/blog/2023-09-cocoaheadsnl-logging.jpg)

So that's why we decided very early on to invest a lot in logging in this scenario. And logging is pretty obvious. You can just start logging. But I think there are a few things that really help us with Screen Studio. So there's some practical tips here. And the first tip is write logs and put them somewhere where you actually can recover them. Because I've done that a lot, and I realized in iOS apps, I was just like, oh, let's add a log, and that's handy for development. Sure, but if a user is going to call you and say, yeah, my app is not working, how do you pull those logs? How do you get those logs from the user to you so you can actually inspect them?

So what we do is we write them to a file next to all the movie recordings, for example. And that's wrapped up in a Screen Studio package. So Adam often asks, can you send me the Screen Studio package of the failed recording? And then the log is also in there. So they automatically send the log over. And Adam then forwards us the log, and we can inspect what was happening. Also, log all context you would want to ask a user about. So we didn't do this perfectly in the beginning. And what happened was I got a log, and then I replied to Adam like, OK, yeah, I need to know what Mac this user had, what macOS version was he on, what devices was he using, stuff like that.

So at the start of a recording, we first log, OK, we are running on a device of this model. This is the OS version. This is the app version of Screen Studio. This is the app version of the binary. These are all the devices that we're going to record. These are all the configuration parameters that we've got so that all the context is clear. And also, as we start recording, we also log like, OK, this is the webcam that we're using. It's in this configuration mode. So we know a lot about what's going on and basically never want to go back to the user to ask what's happening. And one neat trick that I got somewhere from the internet, and I forgot where, is to wrap every action you do.

So for example, we need to configure the webcam. And if we start configuring, we do a debug log. And we say, OK, we're now going to configure the webcam. And this is the configuration we're going to apply. And then once we've done that, do an info log statement where we say we have now configured the webcam, and it is now in this state, and log the state of the webcam that it actually is in now. And that really helps. And the debug info works nice with OS log, for example, because debug logs are kept in memory, and after there are too many logs are dropped. But it depends a little bit on the framework you're using.

But the point is really that if you do that before after the action, if something goes wrong in between, or you think you have applied a certain configuration, you can see that you tried to set the webcam at a certain resolution, but it just refused to do that. And that's where the bug is. Because only logging it before or after often fails. Also, if it just throws an error in between, an exception is raised, then you don't know that you've started to configure the webcam, and that's where the error is. So that's one of the things that was really helpful when looking for issues and troubleshooting users.

So I can really recommend to do this. It will add clutter to your code base, because everything will get two lines around it, especially in short functions. But it really helps. And of course, warn and error about issues that you encounter. I think that's quite a logical one. And if you want to get started with this in Swift, OSLog is great, especially in the new Xcode version, where you have the new console. You have great filters on categories or other fields that you add in your logging. So OSLog is great if you're doing an iOS app. For a console app that we did, we used the Apple Swift Log package. That was really convenient to just write it out. And we couldn't access the console anyway as a child process, et cetera. So for us, that was easier. Those are quite great choices if you want to look into logging.


### ScreenCaptureKit

![](/images/blog/2023-09-cocoaheadsnl-screencapturekit.jpg)

So all the logging aside, one of the most important things Adam wanted to improve was screen capturing. And in recent macOS versions, ScreenCaptureKit is introduced. That's introduced in macOS 12.3. And we rely on ScreenCaptureKit to do a lot of the screen capturing in the recorder. And the neat thing is that it can also capture audio. And before ScreenCaptureKit, you always needed to install some kind of kernel extension thing and to hijack the audio, et cetera. That was very inconvenient. Apple also makes it harder and harder with every macOS version to protect the system.

But with ScreenCaptureKit, you can just access it. That's perfectly allowed. And as long as the user allows the recording, then everything is good. And what's really cool is that you cannot only record the whole screen. You can also choose to record one window. But you can also choose to record the whole screen and exclude a window. So for example, when you do a recording and you have a little webcam in the corner as a preview to the user, you probably don't want to have that in the recording, because you can just record the webcam feed separately. Then you can, with ScreenCaptureKit, create a filter. And you exclude the webcam preview from the recording, and it's just not there. So that's really neat. You can also disable the cursor. That's also something that works.

And a really neat feature is also that it only sends you frames when something changed. So if the screen is perfectly still, like it is now, then you will receive one frame of this image, and then nothing else until something changes on the screen, and then it will deliver the new frame to you. So that really helps in being efficient if you do a streaming thing, or just doing less work if you do image manipulation, for example, on the stream.


### ScreenCaptureKit - Recording to disk

![](/images/blog/2023-09-cocoaheadsnl-screencapturekit-record.jpg)

So one of the things ScreenCaptureKit doesn't do by itself is recording to disk. ScreenCaptureKit is really created and pitched all the time as something to stream video over the network. But I think a pretty great use case is to just record to disk. We had to figure it out ourselves. So we do have a [blog post](/blog/2023/recording-to-disk-with-screencapturekit/) about this if you want to try it yourself. But I think what's really interesting is that what ScreenCaptureKit needs to record to disk is very much the same as recording a webcam to disk, for example. that are all really the same concepts over and over.

So what you need if you want to do screen capturing with ScreenCaptureKit is create a ScreenCaptureKit stream. You can create an object and set filters on it. And then you tell the ScreenCaptureKit stream to start capturing. And it will call a delegate method. And the delegate method will get a CMSampleBuffer. And a CMSampleBuffer is an object that's as old as macOS is, I think. And it contains data, so the video itself is in there, so it can be really big. And timestamps and metadata about that certain frame, so the time the frame is, the duration of the frame, stuff like that. It can also contain audio. It's the same structure. And a neat thing is webcams will also deliver CMSampleBuffer, for example.

And a microphone will also deliver CMSampleBuffers. So as soon as you have configured something that does capturing or recording, you get that sample buffer. And from there, you can put it in the same code bot you use for all this stuff also. And you can then pass it on to an AVAssetWriter. So AVFoundation has this class. And it's optimized to write video files and audio files to disk. And this also does all the encoding stuff for you.

So the sample buffers often are uncompressed data when you work with capture devices. So the webcam just gives you the raw image that it captures. A screen capture gets streamed, just gives you whatever is on the screen, uncompressed. And the AVAssetWriter knows how to compress it, and it's all hardware accelerated.

So that's pretty neat. And then I can output it to a file. You can also fiddle with settings and do other compressions, et cetera. That can become quite complex, but the basic is pretty neat. And so the bottom side here of the AVAssetWriter is also something that you can customize. If you don't want to write out to a file, but want to do a live preview window, for example, like with a webcam, or have a live preview of what you're streaming to people on the Zoom meeting, they can also put the same sample buffer into a view that supports that. Apple has a special layer that supports displaying sample buffers. And then you have a live preview. And that also works for all those sources.

You can switch out the top thing or the bottom thing, and they all work with CMSampleBuffers all the time. So if you're going into capturing, learn about CMSampleBuffer, because that's a very valuable thing to know about. And if you want to play around with ScreenCaptureKit and recording, look at our blog, because there's a ready-to-go sample to fiddle around with.



### Other apps & clients

![](/images/blog/2023-09-cocoaheadsnl-screencapturekit-other-apps.jpg)

So with all this recording experience, we started to work on some of our own ideas. This icon, for example, is from [CleanPresenter](https://cleanpresenter.com). That's one of the first apps that we released. With CleanPresenter, you can take over an external screen and only show one app. And it also uses ScreenCaptureKit to capture that one app and then display it on another place. It's basically streaming, but then on your local Mac.

And what's also interesting is that we got more and more clients who then knew, hey, you know stuff about macOS capturing, so maybe you can help us out with our app, with the streaming app or another kind of recording app. So that was pretty fun. So we dig deeper and deeper in weird issues and APIs. And how did they find us? Through our blog. So every time we encountered an issue that wasn't easy to solve, we basically wrote a blog about it, just like the how do you write a file to disk with ScreenCaptureKit that wasn't obvious.

People started to find those blogs and that was really fun and nice, not only because it got us clients, that's nice too of course, but we also every now and then get an email from a random person on the internet working on a random app that's saying, whoa, you've solved my problem. I was looking for this, and I couldn't find it on Stack Overflow, but I stumbled upon your blog. And I found it was really nice, and we had some fun conversations over the email about, oh, did you solve this weird issue? Or did you get a workaround from Apple because you're at the big company? We were asking them, like, you're at the big company, so maybe Apple is helping you. and do you have more info? So that's a really fun thing to do. And it really helps to have a little bit of exposure and interesting conversations with people.

### Feedback, DTS & WWDC Labs

![](/images/blog/2023-09-cocoaheadsnl-feedback-assistant.jpg)

But we don't only blog about issues. We also report them to Apple in the Feedback Assistant. You might know the Feedback Assistant. So when I, in like more than 10 years I do Apple development, I think I created three radars of feedbacks or so. Now, well, what are we? Nine months in working at our company, I created more, together with Tom, than fit on the screen. And what really changed, I think, is that our mindset is now, if we encounter a bug that is a bug in Apple's system, once we figured out what it is and have a workaround to something, we just stop working for a moment and put in feedback with Apple.

Because if you do it at that moment, right then, you know all the context you need. It's fresh in your mind, and it's pretty easy to type it in. So you can at least shoot in feedback and tell them, please fix this, because it's a weird bug. And since we also now try to blog about it once we encounter a thing, it's also like 50% of the work that needs to go into the blog. And if we need to do a sample project, that's a little bit more work. But then it's also shared between the blog and the feedback, and it's a lot more fun to then create a sample project instead of only submitting it to Apple and not knowing if they are going to do anything about it. So that's a pretty interesting thing.

And I think it's also something we all can do. Like, OK, if you encounter something and you figured it out, submit that feedback to Apple. They're always asking about it. Please do this. And I've tried it myself before. If you do it, like, no, no, I've figured out how to work this. But I'm first now continuing on this project. And then the next day, you try to submit the feedback. And there's already so much more work that you're just not going to do it. So that's my advice. Just stop working there. take like 30 minutes and write out the feedback and submit it to him. At least that's then a vote for like, please fix this bug. So there's another thing that we do.

If we have a file of feedback for an issue that we think should be better, or we have a very awkward workaround for something, or sometimes we don't even have a workaround, we're just stuck. We contact Apple developer support. You have two free tickets on every paid Apple account to contact Apple and ask them a question on the code level. And I think I've never, ever used that while I was working here at Q42, maybe twice or something in my whole career here. But it's really a steal. And you can even purchase extra tickets for like $50 or so. That's nothing compared to your hourly rate all year.

So I also would really encourage you to do this, because what we do is submit the issue, basically, and say, OK, we have this issue. Here's the feedback. We already filed the feedback, so don't ask us to file a feedback. It's already done. You can look into this. And can you find us a workaround for this? Can you confirm it is an issue, and can you find us a workaround? And that often-- sometimes we just get a confirm like, yeah, it's an issue. We don't have a workaround. We're very sorry. But at least then you know you can stop looking for a workaround, because it isn't there. And sometimes you get some person in DTS that's really dedicated and actually contacts a team, asks a developer, OK, what can we do here? And they come back with a workaround that you couldn't think of yourself. Or they can confirm, yeah, if you call it in the other way around, then I can't officially confirm that it will work. But it probably will work. So just try it. you have an interesting workaround to get around things. So that really helped us. And it's also something, if you already have a DTS or a feedback submitted, it's really easy to also submit a DTS. Like, OK, it's the same thing copied over. And then just ask, can you confirm this is an issue? And do you have a workaround? So that's also a really interesting thing to do. And I think it's really valuable to see what you get there.

And one thing they also can do is walk over to the team that's responsible for fixing that bug. So I have a DTS engineer that told me, OK, yeah, I've asked the team to look into that issue to see if they can resolve it. And then you never hear anything again from Apple. But at a future release, then suddenly it's fixed. It's like, OK, this might have contributed a little bit to getting that fixed there. And the last thing that's really fun to do and really valuable also is if you have all those feedbacks, it's basically an archive of everything you bumped into through the year.

So once WWDC hit, we attended a lot of labs that are relevant for all the feedback tickets that we submitted. And then sometimes you get a DTS engineer that's responsible for that. So I had the case where I just got the DTS engineer that actually answered my ticket already and told me, I already have looked into it. I don't have anything else to say about the ticket. But Tom actually got in touch with the ScreenCaptureKit team, for example, the actual engineers that work on ScreenCaptureKit. And that's super valuable. Then you just have a chat about the issues that you bumped into, maybe the feature requests that you sent in. And it really can give a little bit of insight that you else can't get. So yeah, that's really fun to do, and it's really valuable. And I don't think, yeah, I think I've attended a few labs with a few random questions that I could come up with during the WWDC before, but now it was like, we had this long list that we could just submit and get like super valuable information from them. So that's also something I really can advise to do. It's a really easy way to maintain that list.

So, there was a lot of fun working on a lot of capturing stuff and, well, encountering a lot of bugs, reporting them, et cetera. But working on so much capturing things also gave us a lot of capturing ideas to work on. We already worked on a CleanPresenter. But at some moment, Tom said, OK, what we really should do is finally create this app that mirrors your iPhone. Because that's always something we were struggling with, with QuickTime, et cetera. So our new app idea was Bezel.


### Bezel

![](/images/blog/2023-09-cocoaheadsnl-bezel.jpg)

Over here, this is the app icon. And [Bezel](https://getbezel.app) is an app where you can plug in your iPhone to your Mac with a cable, and it just appears on your Mac. And it was something that we thought, well, we have all the knowledge here. We know how stuff works. We already did screen capturing of the devices for other work. So why not create the best and simplest mirroring app that we can? And it was pretty fun to do because we did the smallest prototype.

So maybe you have heard of Jordi Bruin. He has a 2-2-2 method where he takes two hours to prototype something really quickly, and then two days to make it a little bit better and share it with some friends. So basically, we took a day to gather a prototype, put a tweet out, and immediately it was like a reaction. People were asking, whoa, what app is this? I want to try this app. Where can I get it? It's like, there's nothing more than a video and a few ugly hacks in Xcode. So we put a Google form below the tweet and said, OK, give your email address if you want to be kept up to date. So that was pretty cool.

And now we've developed the app further. So I can give a little demo of what we've created. Let me switch the screen mirroring mode. So if I take out my iPhone, plug it in, then it shows up. And now you see my home screen with my kid and my wife on there. So that's basically it. That's the app. You just plug in your iPhone, and then it's mirrored. So it's perfect for demo.

And it was really something we like to create. Because every time I gave a demo at Q42, I was always fiddling around with QuickTime. And it was this square thing. I had clients ask me, am I looking at the iPad or at the iPhone app? I'm not sure. It's just a square, so I'm not sure what I'm looking at. If you rotate the phone, it looks awkward. So those are things we all fixed.

And I think that's one of the things that's really nice about building your own software, and especially also for a use case that you really know really well, is that you know what you want to fix and what to make great. So one of the things we also invested in is this little wizard. So it's really awkward when you plug in a phone for the first time. I don't know if you've done that. Try to mirror a new iPhone with QuickTime during a demo where you're under stress. Like, OK, it has to work now, and then it doesn't work. That's because you need to do a lot of steps them correctly. So we really tried to help the user.

So we say, OK, connect and unlock an iPhone. So I pulled this iPhone from the device wall over here at Q42. And it has never been connected to my Mac. So once I attach the phone, first, my Mac is an Apple Silicon Mac. So it's not allowing me to connect to any USB device without confirming that it's OK. So that's also what Bezel is telling me now. like, OK, click that Allow button. And it's confirming that it's working. So that's great.

Now I have to tap Trust on my iPhone. So there is a Trust button now on the iPhone. So I'll tap that, put in the passcode, and it confirms, OK, you've did that. And now I have to reconnect the iPhone. This is the most awkward part, and QuickTime is not helping you with that. So it was also like, OK, I've trusted, so why isn't it working? So we also try to help you there. So pull the cable out, put it back in, and say, OK, there you go. And this is also an extra pop-up that we should help you with. And now it's here. So now it's mirroring. Let me see if I can enlarge the thing. So now it's working. So that's also something we invested in.

And it was pretty fun to work on because it's a lot of different APIs that are working together. So it's AVFoundation that's basically doing webcams all the time. That's telling us what the state of the camera is, combined with some private APIs from Apple to know more about the device and what state it's in. So that was really fun to create. And one of the features of Bezel is also that it detected that this is a white iPhone. So it's also showing the white bezel around it. But you can also switch that. So if I want the space gray version, I can just switch over to the other bezel.

So this is one of the apps we're working on right now. And we had quite a better group that was giving us feedback on what to improve. So that was really fun. Really enthusiastic users already. And next week is the moment that we go live with bezel. So I'm really curious what it will do, what kind of traction it will get, and whether it will help us to reach our dream of becoming sustainable from our own apps instead of client work. So I can't tell you right now.

Next week I will know more. And I hope to give an update in, let's say, about a year or so on where we're then with what apps we're developing at that moment. Thank you. Thank you for your time.


### Q&A

![](/images/blog/2023-09-cocoaheadsnl-audience.jpg)

**Q: In order to be a sustainable business, you need to make some money. How is this app gonna bring in the money?**

A: Yeah, so we're going to charge money for it. And what we're going to do is you can download the app for free and there will be a little watermark on the phone. And it's a one-time purchase that you can do. So on our website, you can buy it for one-time purchase. And then you unlock the phone or remove the watermark.

**Q: Are there any plans to get Bezel working with the Apple TV? Because that's wireless data streams.**

A: So we have a lot of ideas and things we want to implement. I do think wireless will be something that we will implement at some point at time, because also a lot of people are asking for that just when using it with a Mac. And once we go wireless, it is really interesting to also be on the Apple TV, et cetera. So yes, absolutely a dream. I really want to be there. But I think we first have to prove that this concept is working at all and is like-- is like working and people are actually using it.

**Q: A follow-up question. What I actually meant is connecting or like displaying the Apple TV within Bezel.**

A: Ah, all right, yeah. So that would also be an awesome thing to do. So I really would love to support other devices like Apple TV, but also Apple Watch, for example. So if you work on an Apple TV or an Apple Watch app, then it would also be really neat to be able to display the actual thing and share that. So yeah, that's something that I really would want to do. But first things first, and that's just completing this iPhone version, wired on the Mac, making that really good and adding some features there.

**Q: So for supporting other devices, do you already have clues that it is possible or is this and you haven't actually investigated yet?**

A: No, I think for a lot of devices, it's possible to create something like that. So especially to show that device on your Mac. So for Apple Watch, we have some ideas and directions that work where I've filled around a little bit with what we can do. And on other platforms, we also have some ideas how we can do that. So I'm pretty certain that we can do that, yeah.

**Q: Thank you very much for your great presentation. I was just wondering how long have you been busy, the two of you on this, because maybe you said in the beginning. When did you start with Nonstrict, and then this whole journey, how long has it been?**

A: So the company started in January. And December was when we got Adam as a client. So that's the point where we started. Yeah, so nine, 10 months now.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=a-mac-tastic-indie-adventure" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror your iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone and it automatically shows up on your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div> 

_Transcript created with [MacWhisper](https://goodsnooze.gumroad.com/l/macwhisper)._
