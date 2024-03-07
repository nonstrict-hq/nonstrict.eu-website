import Foundation
import Plot

protocol HTMLFileComponent: Component {
    var searchPath: String { get }
    var replacements: [String: Component] { get }
}

extension HTMLFileComponent {
    var body: Component {
        let htmlPath = searchPath.replacingOccurrences(of: ".swift", with: ".html")
        let url = URL(string: "file://" + htmlPath)!
        let htmlTemplateString = try! String(contentsOf: url)
        
        let htmlString = replacements.reduce(htmlTemplateString) { partialResult, replacement in
            partialResult.replacingOccurrences(of: "{{\(replacement.key)}}", with: replacement.value.render())
        }
        
        return Node<Any>.raw(htmlString)
    }

    var replacements: [String: Component] { [:] }
}
