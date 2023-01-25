//
//  File.swift
//  
//
//  Created by Mathijs Kadijk on 25/01/2023.
//

import Foundation
import Publish
import Plot

@main
struct NonstrictWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case blog
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        let authors: [Author]
        let date: Date
    }
    
    let name = "Nonstrict"
    let description = "Experts on the Apple platform."
    let language = Language.english
    let imagePath: Publish.Path? = "images/logo.png"
    let url = URL(string: "https://nonstrict.eu")!
    
    public static func main() {
        
        try! NonstrictWebsite().publish(withTheme: .nonstrict)
    }
}
