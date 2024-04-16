import Foundation
import Plot

struct Header: HTMLFileComponent {
    private let rightSideButtons = Node<Any>.raw("""
            <a href="/bezel/#features" class="text-m font-semibold leading-6 text-gray-900 dark:text-white hover:underline">Features</a>
            <a href="/bezel/pricing" class="text-m font-semibold leading-6 text-gray-900 dark:text-white hover:underline">Pricing</a>
            <a href="/bezel/vision" class="text-m font-semibold leading-6 text-gray-900 dark:text-white hover:underline">Vision Pro</a>
            <a href="/bezel/thank-you-for-trying-bezel" class="hidden sm:inline rounded-md ring-1 ring-purple-600 hover:bg-purple-600 hover:ring-purple-600 px-6 py-2 text-m font-semibold text-purple-600 dark:text-white hover:text-white shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">                       <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="inline-block w-6 h-6 mr-1 -mt-1">
                                               <path fill-rule="evenodd" d="M12 2.25a.75.75 0 01.75.75v11.69l3.22-3.22a.75.75 0 111.06 1.06l-4.5 4.5a.75.75 0 01-1.06 0l-4.5-4.5a.75.75 0 111.06-1.06l3.22 3.22V3a.75.75 0 01.75-.75zm-9 13.5a.75.75 0 01.75.75v2.25a1.5 1.5 0 001.5 1.5h13.5a1.5 1.5 0 001.5-1.5V16.5a.75.75 0 011.5 0v2.25a3 3 0 01-3 3H5.25a3 3 0 01-3-3V16.5a.75.75 0 01.75-.75z" clip-rule="evenodd" />
                                               </svg> Download</a>
""")

    let searchPath = #filePath
    var replacements: [String : Component] = [:]

    init(showRightSideButtons: Bool = true) {
        replacements["rightSideButtons"] = showRightSideButtons ? rightSideButtons : Text("")
    }
}
