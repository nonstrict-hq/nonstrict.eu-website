//
//  File.swift
//  
//
//  Created by Mathijs Kadijk on 25/01/2023.
//

import Foundation
import System
import Plot

struct Footer: Component {
    var body: Component {
        Node<Any>.raw(try! String(contentsOf: URL(string: "file://" + #filePath.replacingOccurrences(of: ".swift", with: ".html"))!))
    }
}
