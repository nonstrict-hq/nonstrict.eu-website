import ReadingTimePublishPlugin
import SplashPublishPlugin

let foo = "bar"

try! NonstrictWebsite()
    .publish(
        withTheme: .nonstrict,
        additionalSteps: [
            .installPlugin(.readingTime())
        ],
        plugins: [
            .splash(withClassPrefix: "splash-")
        ]
    )
