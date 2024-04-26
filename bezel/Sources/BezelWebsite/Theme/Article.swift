import Foundation
import Publish
import Plot

struct Article: Component {
    var body: Component {
        Div {
            Div {
                Div {
                    H1 {
                        Link(url: "/bezel/article/") {
                            Text(primaryTag.description)
                        }
                        .class("block text-center text-lg font-semibold text-purple-600 hover:underline")
                        Span(item.title)
                            .class("mt-2 block text-center text-3xl font-bold leading-8 tracking-tight text-gray-900 dark:text-white sm:text-4xl")
                    }
                }
                .class("mx-auto max-w-prose text-lg")
                Div {
                    item.content.body
                }
                .class("prose dark:prose-invert prose-lg prose-purple mx-auto mt-6 text-gray-600 dark:text-gray-300 prose-a:text-purple-600 hover:prose-a:text-purple-400 prose-figcaption:italic prose-figcaption:italic prose-figcaption:-mt-6 prose-figcaption:text-sm prose-figcaption:font-serif prose-img:drop-shadow-xl prose-h2:mt-8 prose-h2:mb-4")
            }
            .class("relative px-6 lg:px-8")
        }
        .class("relative overflow-hidden py-16")
    }

    let item: Item<BezelWebsite>
    let site: BezelWebsite

    var readingTime: Int { max(1, item.readingTime.minutes) }
    var primaryTag: Tag { item.tags.first! }
}
