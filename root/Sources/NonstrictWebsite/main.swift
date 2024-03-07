import ReadingTimePublishPlugin
import SplashPublishPlugin

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
