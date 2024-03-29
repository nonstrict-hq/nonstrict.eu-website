//
//  File.swift
//  
//
//  Created by Mathijs Kadijk on 25/01/2023.
//

import Foundation
import Publish
import Plot

extension Theme where Site == NonstrictWebsite {
    static var nonstrict: Self {
        Theme(
            htmlFactory: NonstrictWebsiteHTMLFactory(),
            resourcePaths: []
        )
    }

    private struct NonstrictWebsiteHTMLFactory: HTMLFactory {
        func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML {
            HTML(
                .head(for: index, on: context.site),
                .body(
                    .component(Hero()),
                    .component(BlogSection(blogItems: context.sections[.blog].items.filter { $0.metadata.featured == true }.prefix(3), site: context.site)),
                    .component(Footer())
                )
            )
        }
        
        
        func makeSectionHTML(for section: Publish.Section<NonstrictWebsite>, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML {
            HTML(
                .head(for: section, on: context.site),
                .body(
                    .component(Header(joinForces: true)),
                    .component(Section(sectionItems: section.items, site: context.site)),
                    .component(Footer())
                )
            )
        }
        
        func makeItemHTML(for item: Publish.Item<NonstrictWebsite>, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML {
            HTML(
                .head(for: item, on: context.site),
                .body(
                    .component(Header(joinForces: true)),
                    .component(BlogPost(item: item, site: context.site)),
                    .component(Footer())
                )
            )
        }
        
        func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML {
            HTML(
                .head(for: page, on: context.site),
                .body(
                    .component(Header(joinForces: false)),
                    .component(AppItem(item: page, site: context.site)),
                    .component(Footer())
                )
            )
        }
        
        func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML? {
            HTML(.body(.text("TODO taglistpage")))
        }
        
        func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML? {
            HTML(.body(.text("TODO tagdetailspage")))
        }
    }
}
