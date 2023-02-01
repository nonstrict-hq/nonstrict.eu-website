//
//  Author.swift
//  
//
//  Created by Mathijs Kadijk on 25/01/2023.
//

import Foundation

enum Author: String, Decodable {
    case mathijs
    case tom
    
    var info: AuthorInformation {
        switch self {
        case .mathijs:
            return AuthorInformation(fullName: "Mathijs Kadijk", gravatarHash: "f2d6bffca5e5fe828bc9c55a521a55ec")
        case .tom:
            return AuthorInformation(fullName: "Tom Lokhorst", gravatarHash: "38b1c93cab46acd801e6e0cc99c39939")
        }
    }
}

struct AuthorInformation {
    let fullName: String
    let gravatarHash: String
    
    func gravatarUrl(size: Int) -> URL {
        URL(string: "https://www.gravatar.com/avatar/\(gravatarHash)?s=\(size)")!
    }
}
