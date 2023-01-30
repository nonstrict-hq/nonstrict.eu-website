import Foundation
import Publish
import Plot

struct Blog: Component {
    var body: Component {
        Div {
            Div {
                Div {
                    H1 {
                        Link(url: site.path(for: primaryTag).absoluteString) {
                            Text(primaryTag.description)
                        }
                        .class("block text-center text-lg font-semibold text-orange-600 hover:underline")
                        Span(item.title)
                            .class("mt-2 block text-center text-3xl font-bold leading-8 tracking-tight text-gray-900 sm:text-4xl")
                    }
                    Paragraph {
                        Text(item.metadata.intro)
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
                Div {
                    item.content.body
                }
                .class("prose prose-lg prose-orange mx-auto mt-12 text-gray-500")
            }
            .class("relative px-6 lg:px-8")
        }
        .class("relative overflow-hidden bg-white py-16")
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
