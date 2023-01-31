import Foundation
import Publish
import Plot

struct NonstrictWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case blog
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        var description: String
        let authors: [Author]
        let date: Date
        let image: Path
        let imageAlt: String?
        let imageCaption: String?
        let tags: [String]
    }
    
    let name = "Nonstrict"
    let description = "Experts on the Apple platform."
    let language = Language.english
    let imagePath: Publish.Path? = "images/logo.png"
    let url = URL(string: "https://nonstrict.eu")!
    let locale = Locale(identifier: "en_US_POSIX")
}
