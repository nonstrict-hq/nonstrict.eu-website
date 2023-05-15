import Foundation
import Publish
import Plot

struct Blog: Component {
    var body: Component {
        Div {
            Div {
                Div {
                    H1 {
                        Link(url: "/#blog" /*site.path(for: primaryTag).absoluteString*/) {
                            Text(primaryTag.description)
                        }
                        .class("block text-center text-lg font-semibold text-orange hover:underline hover:text-orange-500")
                        Span(item.title)
                            .class("mt-2 block text-center text-3xl font-bold leading-8 tracking-tight text-gray-900 sm:text-4xl")
                    }
                    Paragraph {
                        Text(item.metadata.description)
                    }
                    .class("mt-8 text-xl leading-8 text-gray-500")
                    Div {
                        Div {
                            for (index, author) in item.metadata.authors.enumerated() {
                                Image(author.info.gravatarUrl(size: 256))
                                    .class("relative z-\(50-index*10) inline-block h-10 w-10 rounded-full ring-2 ring-white")
                            }
                        }
                        .class("isolate flex -space-x-2 overflow-hidden")
                        Div {
                            Paragraph {
                                Text(authorNames)
                            }
                            .class("text-sm font-medium text-gray-900")
                            Div {
                                Element(name: "Time") {
                                    Text(item.date.formatted(style))
                                }
                                .attribute(named: "datetime", value: item.date.ISO8601Format(.iso8601Date(timeZone: .gmt)))
                                Span(html: "&middot;")
                                    .attribute(named: "aria-hidden", value: "true")
                                Span("\(readingTime) min read")
                            }
                            .class("flex space-x-1 text-sm text-gray-500")
                        }
                        .class("ml-3")
                    }
                    .class("mt-6 flex items-center")
                }
                .class("mx-auto max-w-prose text-lg")
                if let imagePath = item.imagePath {
                    Element(name: "Figure") {
                        Div {
                            Image(url: imagePath.absoluteString, description: item.metadata.imageAlt ?? "")
                                .class("mx-auto w-[1024px] aspect-video lg:rounded-lg object-cover")
                        }
                        .class("mt-12 -mx-6 lg:-mx-8")
                        if let imageCaption = item.metadata.imageCaption {
                            Div {
                                Element(name: "Figcaption") { Text(imageCaption) }
                            }
                            .class("prose prose-lg prose-orange mx-auto mt-3 text-gray-500 prose-a:text-orange hover:prose-a:text-orange-500 prose-figcaption:text-sm prose-figcaption:font-serif")
                        }
                    }
                }
                Div {
                    item.content.body
                }
                .class("prose prose-lg prose-orange mx-auto mt-12 text-gray-500 prose-a:text-orange hover:prose-a:text-orange-500 prose-figcaption:italic prose-figcaption:italic prose-figcaption:-mt-6 prose-figcaption:text-sm prose-figcaption:font-serif prose-img:drop-shadow-xl")
                // drop-shadow for image in /blog/2023/recording-to-disk-with-screencapturekit/
                // not sure if its a good general default
            }
            .class("relative px-6 lg:px-8")
        }
        .class("relative overflow-hidden py-16")
    }
    
    let item: Item<NonstrictWebsite>
    let site: NonstrictWebsite

    var readingTime: Int { max(1, item.readingTime.minutes) }
    var authorNames: String { item.metadata.authors.map(\.info.fullName).joined(separator: ", ") }
    var primaryTag: Tag { item.tags.first! }
    var style: Date.FormatStyle {
        .dateTime
            .day(.defaultDigits)
            .month(.wide)
            .year(.defaultDigits)
            .locale(site.locale)
    }
}
