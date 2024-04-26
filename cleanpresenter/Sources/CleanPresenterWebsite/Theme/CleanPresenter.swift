//
//  File.swift
//  
//
//  Created by Mathijs Kadijk on 25/01/2023.
//

import Foundation
import Publish
import Plot

extension Theme where Site == CleanPresenterWebsite {
    static var cleanPresenter: Self {
        Theme(
            htmlFactory: CleanPresenterWebsiteHTMLFactory(),
            resourcePaths: []
        )
    }

    private struct CleanPresenterWebsiteHTMLFactory: HTMLFactory {
        func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<CleanPresenterWebsite>) throws -> Plot.HTML {
            var indexWithImage = index
            indexWithImage.imagePath = context.site.imagePath
            return HTML(
                .head(for: indexWithImage, on: context.site, stylesheetPaths: ["/cleanpresenter/styles.css"], rssFeedPath: nil, rssFeedTitle: nil),
                .body(
                    .component(Menu()),
                    .component(HeroAlt()),
                    .component(Testimonials()),
                    .component(FeatureSectionB()),
                    .component(PerfectFor()),
                    .component(Pricing()),
                    .component(MadeForMac()),
                    .component(FAQ()),
                    .component(CTA()),
                    .component(Footer()),
                    .component(InlineJavaScript())
                )
            )
        }

        func makeSectionHTML(for section: Publish.Section<CleanPresenterWebsite>, context: Publish.PublishingContext<CleanPresenterWebsite>) throws -> Plot.HTML {
            HTML(.body(.text("TODO")))
        }
        
        func makeItemHTML(for item: Publish.Item<CleanPresenterWebsite>, context: Publish.PublishingContext<CleanPresenterWebsite>) throws -> Plot.HTML {
            HTML(.body(.text("TODO")))
        }
        
        func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<CleanPresenterWebsite>) throws -> Plot.HTML {
            HTML(.body(.text("TODO")))
        }
        
        func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<CleanPresenterWebsite>) throws -> Plot.HTML? {
            HTML(.body(.text("TODO")))
        }
        
        func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<CleanPresenterWebsite>) throws -> Plot.HTML? {
            HTML(.body(.text("TODO")))
        }
    }
}
