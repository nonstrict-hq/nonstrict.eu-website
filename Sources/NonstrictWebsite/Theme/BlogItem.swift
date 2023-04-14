import Foundation
import Publish
import Plot

struct BlogItem: Component {
    var body: Component {
        Div {
            Div {
                Link(url: item.path.absoluteString) {
                Image(item.imagePath!.absoluteString)
                    .class("h-48 w-full object-cover")
                }
            }
            .class("flex-shrink-0")
            
            Div {
                Div {
                    Paragraph {
                        // Link(url: site.path(for: primaryTag).absoluteString) {
                            Text(primaryTag.description)
                        // }
                        // .class("hover:underline hover:text-orange-500")
                    }
                    .class("text-sm font-medium text-orange")
                    
                    Link(url: item.path.absoluteString) {
                        Paragraph {
                            Text(item.title)
                        }
                        .class("text-xl font-semibold text-gray-900")
                        Paragraph {
                            Text(item.metadata.description)
                        }
                        .class("mt-3 text-base text-gray-500")
                    }
                    .class("mt-2 block")
                }
                .class("flex-1")
                
                Div {
                    Div {
                        Span(primaryAuthor.fullName)
                            .class("sr-only")
                        Image(primaryAuthor.gravatarUrl(size: 256))
                            .class("h-10 w-10 rounded-full")
                    }
                    .class("flex-shrink-0")
                    Div {
                        Paragraph {
                            Text(primaryAuthor.fullName)
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
            .class("flex flex-1 flex-col justify-between bg-white p-6")
        }
        .class("flex flex-col overflow-hidden rounded-lg shadow-lg")
    }
    
    let item: Item<NonstrictWebsite>
    let site: NonstrictWebsite

    var readingTime: Int { max(1, item.readingTime.minutes) }
    var primaryAuthor: AuthorInformation { item.metadata.authors.first?.info ?? { fatalError("No authors") }() }
    var primaryTag: Tag { item.tags.first! }
    
    var style: Date.FormatStyle {
        .dateTime
            .day(.defaultDigits)
            .month(.wide)
            .locale(site.locale)
    }
}
