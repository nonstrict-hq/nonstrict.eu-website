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
                s.description = "Bezel mirrors any iPhone inside Vision Pro."

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
            case "ios":
                pageWithImage.title = ""
                pageWithImage.imagePath = "images/ios/og-main.png"

                var s = context.site
                s.name = "Bezel iOS • Frame iPhone Screenshots"
                s.description = "Instant beautiful screenshots."

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
                        .component(iOSHeader()),
                        .component(iOS()),
                        .component(iOSFooter())
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
            case "terms":
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
                        .component(Terms()),
                        .component(Footer())
                    )
                )
            case "privacy":
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
                        .component(Privacy()),
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
