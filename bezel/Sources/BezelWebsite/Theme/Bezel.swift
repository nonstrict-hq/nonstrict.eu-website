//
//  File.swift
//  
//
//  Created by Mathijs Kadijk on 25/01/2023.
//

import Foundation
import Publish
import Plot

extension Theme where Site == BezelWebsite {
    static var bezel: Self {
        Theme(
            htmlFactory: BezelWebsiteHTMLFactory(),
            resourcePaths: []
        )
    }

    private struct BezelWebsiteHTMLFactory: HTMLFactory {
        func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<BezelWebsite>) throws -> Plot.HTML {
            var indexWithImage = index
            indexWithImage.imagePath = context.site.imagePath
            return HTML(
                .head(
                    for: indexWithImage,
                    on: context.site,
                    stylesheetPaths: ["/bezel/styles.css"],
                    rssFeedPath: nil,
                    rssFeedTitle: nil
                ),
                .body(
                    .attribute(named: "class", value: "bg-gray-100 dark:bg-gray-900"),
                    .component(Header()),
                    .component(HeroAlt()),
                    .component(Testimonials()),
                    .component(Footer())
                )
            )
        }

        func makeSectionHTML(for section: Publish.Section<BezelWebsite>, context: Publish.PublishingContext<BezelWebsite>) throws -> Plot.HTML {
            return HTML(
                .head(
                    for: section,
                    on: context.site,
                    stylesheetPaths: ["/bezel/styles.css"],
                    rssFeedPath: nil,
                    rssFeedTitle: nil
                ),
                .body(
                    .attribute(named: "class", value: "bg-gray-100 dark:bg-gray-900"),
                    .component(Header()),
                    .component(Section(sectionItems: section.items, site: context.site)),
                    .component(Footer())
                )
            )
        }
        
        func makeItemHTML(for item: Publish.Item<BezelWebsite>, context: Publish.PublishingContext<BezelWebsite>) throws -> Plot.HTML {
            return HTML(
                .head(
                    for: item,
                    on: context.site,
                    stylesheetPaths: ["/bezel/styles.css"],
                    rssFeedPath: nil,
                    rssFeedTitle: nil
                ),
                .body(
                    .attribute(named: "class", value: "bg-gray-100 dark:bg-gray-900"),
                    .component(Header()),
                    .component(Article(item: item, site: context.site)),
                    .component(Footer())
                )
            )
        }
        
        func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<BezelWebsite>) throws -> Plot.HTML {
            var pageWithImage = page
            pageWithImage.imagePath = context.site.imagePath

            switch page.path {
            case "pricing":
                return HTML(
                    .head(
                        for: pageWithImage,
                        on: context.site,
                        stylesheetPaths: ["/bezel/styles.css"],
                        rssFeedPath: nil,
                        rssFeedTitle: nil
                    ),
                    .body(
                        .attribute(named: "class", value: "bg-gray-100 dark:bg-gray-900"),
                        .component(Header()),
                        .component(Pricing()),
                        .component(Footer())
                    )
                )
            case "thank-you-for-trying-bezel":
                return HTML(
                    .head(
                        for: pageWithImage,
                        on: context.site,
                        stylesheetPaths: ["/bezel/styles.css"],
                        rssFeedPath: nil,
                        rssFeedTitle: nil,
                        nodes: [
                            .meta(.attribute(named: "name", value: "robots"), .attribute(named: "content", value: "noindex"))
                        ]
                    ),
                    .body(
                        .attribute(named: "class", value: "bg-gray-100 dark:bg-gray-900"),
                        .component(Header()),
                        .component(ThankYouTrying()),
                        .component(Footer())
                    )
                )
            case "subscribed":
                return HTML(
                    .head(
                        for: pageWithImage,
                        on: context.site,
                        stylesheetPaths: ["/bezel/styles.css"],
                        rssFeedPath: nil,
                        rssFeedTitle: nil,
                        nodes: [
                        .meta(.attribute(named: "name", value: "robots"), .attribute(named: "content", value: "noindex"))
                        ]
                    ),
                    .body(
                        .attribute(named: "class", value: "bg-gray-100 dark:bg-gray-900"),
                        .component(Header()),
                        .component(Subscribed()),
                        .component(Footer())
                    )
                )
            case "vision":
                pageWithImage.title = ""
                pageWithImage.imagePath = "images/vision/og-main.png"

                var s = context.site
                s.name = "Bezel • iPhone mirroring for Vision Pro"
                s.description = "Bezel shows your iPhone inside Vision Pro."

                return HTML(
                    .head(
                        for: pageWithImage,
                        on: s,
                        titleSeparator: "",
                        stylesheetPaths: ["/bezel/styles.css"],
                        rssFeedPath: nil,
                        rssFeedTitle: nil
                    ),
                    .body(
                        .attribute(named: "class", value: "bg-gray-100 dark:bg-gray-900"),
                        .component(VisionHeader()),
                        .component(Vision()),
                        .component(VisionFooter())
                    )
                )
            case "helper":
                return HTML(
                    .head(
                        for: pageWithImage,
                        on: context.site,
                        stylesheetPaths: ["/bezel/styles.css"],
                        rssFeedPath: nil,
                        rssFeedTitle: nil
                    ),
                    .body(
                        .attribute(named: "class", value: "bg-gray-100 dark:bg-gray-900"),
                        .component(Header(showRightSideButtons: false)),
                        .component(Helper()),
                        .component(Footer())
                    )
                )
            default:
                return HTML(.body(.text("Not found: \(page.path)")))
            }
        }
        
        func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<BezelWebsite>) throws -> Plot.HTML? {
            HTML(.body(.text("Not found")))
        }
        
        func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<BezelWebsite>) throws -> Plot.HTML? {
            HTML(.body(.text("Not found")))
        }
    }
}


public extension Node where Context == HTML.DocumentContext {

    // Copy of head function from Plot, with extra node parameter
    static func head<T: Website>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        stylesheetPaths: [Path] = ["/styles.css"],
        rssFeedPath: Path? = .defaultForRSSFeed,
        rssFeedTitle: String? = nil,
        nodes: [Node<HTML.HeadContext>] = []
    ) -> Node {
        var title = location.title

        if title.isEmpty {
            title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(rssFeedPath, { path in
                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            }),
            .forEach(nodes, { $0 })
        )
    }
}
