//
//  AppItem.swift
//  nonstrict
//
//  Created by Nonstrict on 2023-04-14.
//

import Foundation
import Publish
import Plot

struct AppItem: Component {
    let appLink = "https://testflight.apple.com/join/671PBiQu"
    var body: Component {
        Div {
            Div {
                Div {
                    Link(url: appLink) {
                        Image(url: item.imagePath!.absoluteString, description: item.imagePath?.description ?? "")
                            .class("mx-auto w-[180px]")
                    }
                }
                Div {
                    item.content.body
                }
                .class("prose prose-md prose-orange mx-auto mt-12 text-gray-500 prose-a:text-orange hover:prose-a:text-orange-500 prose-figcaption:italic prose-figcaption:italic prose-figcaption:-mt-6 prose-figcaption:text-sm prose-figcaption:font-serif prose-img:drop-shadow-xl")
                Div {
                    Link(url: appLink) {
                        Text("Download via TestFlight")
                    }.class("inline-flex items-center justify-center whitespace-nowrap rounded-md border border-transparent bg-orange px-3 md:px-4 h-10 text-base font-medium text-white shadow-sm hover:bg-orange-600")
                }
                .class("mx-auto mt-12 text-gray-500 text-center")
            }
            .class("relative px-6 lg:px-8")
        }
        .class("relative overflow-hidden py-16")
    }

    let item: Page
    let site: NonstrictWebsite

//    var readingTime: Int { max(1, item.readingTime.minutes) }
//    var authorNames: String { item.metadata.authors.map(\.info.fullName).joined(separator: ", ") }
//    var primaryTag: Tag { item.tags.first! }
//    var style: Date.FormatStyle {
//        .dateTime
//            .day(.defaultDigits)
//            .month(.wide)
//            .year(.defaultDigits)
//            .locale(site.locale)
//    }
}
