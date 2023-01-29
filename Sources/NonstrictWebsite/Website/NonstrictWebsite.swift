import Foundation
import Publish
import Plot

struct NonstrictWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case home
    }

    struct ItemMetadata: WebsiteItemMetadata {}
    
    let url = URL(string: "https://nonstrict.eu")!
    let name = "Nonstrict"
    let description = "We provide macOS/iOS development services."
    let language = Language.english
    let imagePath: Publish.Path? = "images/favicon-32x32.png"
}
