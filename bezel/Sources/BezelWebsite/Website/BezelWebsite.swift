import Foundation
import Publish
import Plot

struct BezelWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case article
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        var description: String
    }

    var name = "Bezel • Mirror any iPhone on your Mac"
    var description = "Bezel mirrors any iPhone onto your Mac by just plugging it in. Beautifully designed for Mac, with ease of use in mind."
    let language = Language.english
    let imagePath: Publish.Path? = "images/og-main.png"
    let url = URL(string: "https://nonstrict.eu/bezel")!
    let locale = Locale(identifier: "en_US_POSIX")
    let favicon: Favicon? = Favicon(path: "/bezel/images/favicon.png", type: "image/png")
}
