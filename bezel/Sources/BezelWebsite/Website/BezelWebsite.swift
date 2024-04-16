import Foundation
import Publish
import Plot

struct BezelWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case none
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        var description: String
        let authors: [String]
        let date: Date
        let image: Path
        let imageAlt: String?
        let imageCaption: String?
        let tags: [String]
    }

    var name = "Bezel • Show your iPhone on your Mac"
    var description = "Bezel mirrors your iPhone onto your Mac by just plugging it in. Beautifully designed for Mac, with ease of use in mind."
    let language = Language.english
    let imagePath: Publish.Path? = "images/og-main.png"
    let url = URL(string: "https://getbezel.app")!
    let locale = Locale(identifier: "en_US_POSIX")
}
