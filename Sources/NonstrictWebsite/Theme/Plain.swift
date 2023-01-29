import Foundation
import Publish
import Plot

extension Theme where Site == NonstrictWebsite {
    static var nonstrictPlain: Self {
        Theme(
            htmlFactory: NonstrictPlainHTMLFactory(),
            resourcePaths: []
        )
    }

    private struct NonstrictPlainHTMLFactory: HTMLFactory {
        func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML {
            HTML(
                .lang(context.site.language),
                .head(
                    .encoding(.utf8),
                    .siteName(context.site.name),
                    .meta(.name("theme-color"), .content("#333"), .attribute(named: "media", value: "(prefers-color-scheme: dark)")),
                    .meta(.name("theme-color"), .content("#eee"), .attribute(named: "media", value: "(prefers-color-scheme: light)")),
                    .title(context.site.name),
                    .description(context.site.description),
                    .stylesheet("/styles/website.css"),
                    .viewport(.accordingToDevice),
                    .link(.rel(.shortcutIcon), .href("/images/favicon-32x32.png"), .type("image/png"), .sizes("32x32")),
                    .link(.rel(.shortcutIcon), .href("/images/favicon-16x16.png"), .type("image/png"))
                ),
                .body {
                    Node<Any>.raw(indexBody)
                }
            )
        }
        
        func makeSectionHTML(for section: Publish.Section<NonstrictWebsite>, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML {
            HTML()
        }
        
        func makeItemHTML(for item: Publish.Item<NonstrictWebsite>, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML {
            HTML()
        }
        
        func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML {
            HTML()
        }
        
        func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML? {
            HTML()
        }
        
        func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<NonstrictWebsite>) throws -> Plot.HTML? {
            HTML()
        }
    }
}

private let indexBody = """
<h1 id="logotype">Nonstrict</h1>

<p class="subtitle">We provide macOS/iOS development services</p>
<div class="contact">
<p>Contact Us via e-mail:</p>
<p><a href="mailto:hello@nonstrict.com">hello@nonstrict.com</a></p>
</div>
<footer>
<p class="external-links">
    <a rel="me" href="https://github.com/nonstrict-hq"><img src="/images/icon-github.png" alt="" width=16 height=16> Github</a>
    <a rel="me" href="https://mastodon.social/@nonstrict"><img src="/images/icon-mastodon.png" alt="" width=16 height=16> Mastodon</a>
</p>

<p>Nonstrict B.V.<br>
KvK 89067657<br>
The Netherlands</p>
</footer>
"""
