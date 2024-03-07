import Foundation
import Publish
import Plot

struct BlogSection: HTMLFileComponent {
    let searchPath = #filePath
    let replacements: [String : Component]

    init(blogItems: some Sequence<Item<NonstrictWebsite>>, site: NonstrictWebsite) {
        let items = blogItems.map { BlogItem(item: $0, site: site) }
        let group = ComponentGroup(members: items)
        
        self.replacements = [
            "blogItems": group
        ]
    }
}
