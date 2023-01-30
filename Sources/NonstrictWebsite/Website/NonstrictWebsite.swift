import Foundation
import Publish
import Plot

struct NonstrictWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case blog
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        let authors: [Author]
        let date: Date
        let intro: String
        let image: Path
    }
    
    let name = "Nonstrict"
    let description = "Experts on the Apple platform."
    let language = Language.english
    let imagePath: Publish.Path? = "images/logo.png"
    let url = URL(string: "https://nonstrict.eu")!
    let locale = Locale(identifier: "en_US_POSIX")
}
