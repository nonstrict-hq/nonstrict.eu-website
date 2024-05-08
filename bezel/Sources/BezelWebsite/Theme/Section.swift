import Foundation
import Publish
import Plot


// TODO: Design the HTML for this
struct Section: HTMLFileComponent {
    let searchPath = #filePath
    let replacements: [String : Component]

    init(sectionItems: some Sequence<Item<BezelWebsite>>, site: BezelWebsite) {
        let items = sectionItems.map { SectionItem(item: $0, site: site) }
        let group = ComponentGroup(members: items)

        self.replacements = [
            "sectionItems": group
        ]
    }
}


// TODO: Design the HTML for this
struct SectionItem: Component {
    var body: Component {
        Div {
            Div {
                Link(url: "/bezel/" + item.path.absoluteString) {
                    if let imagePath = item.imagePath {
                        Image("/bezel/" + imagePath.absoluteString)
                            .class("h-48 w-full object-cover")
                    } else {
                        Div()
                            .class("h-48 w-full object-cover")
                    }
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
                    .class("text-sm font-medium text-purple-600")

                    Link(url: "/bezel/" + item.path.absoluteString) {
                        Paragraph {
                            Text(item.title)
                        }
                        .class("text-xl font-semibold text-gray-900 group-hover:underline")
                        Paragraph {
                            Text(item.metadata.description)
                        }
                        .class("mt-3 text-base text-gray-500")
                    }
                    .class("mt-2 block group")
                }
                .class("flex-1")
            }
            .class("flex flex-1 flex-col justify-between bg-white p-6")
        }
        .class("flex flex-col overflow-hidden rounded-lg shadow-lg mb-8")
    }

    let item: Item<BezelWebsite>
    let site: BezelWebsite

    var primaryTag: Tag { item.tags.first! }

    var style: Date.FormatStyle {
        .dateTime
            .day(.defaultDigits)
            .month(.wide)
            .locale(site.locale)
    }
}
