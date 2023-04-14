import Plot

private let joinForcesButton = Node<Any>.raw(#"<a href="mailto:hello@nonstrict.com" class="ml-8 inline-flex items-center justify-center whitespace-nowrap rounded-md border border-transparent bg-orange px-3 md:px-4 h-10 text-base font-medium text-white shadow-sm hover:bg-orange-600">Join forces</a>"#)

struct Header: HTMLFileComponent {
    let searchPath = #filePath
    var replacements: [String : Component] = [:]

    init(joinForces: Bool) {
        replacements["rightItem"] = joinForces ? joinForcesButton : Text("")
    }
}
