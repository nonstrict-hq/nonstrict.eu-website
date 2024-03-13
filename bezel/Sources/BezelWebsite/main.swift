import ReadingTimePublishPlugin
import SplashPublishPlugin

try! BezelWebsite()
    .publish(
        withTheme: .bezel,
        additionalSteps: [
            .installPlugin(.readingTime())
        ],
        plugins: [
            .splash(withClassPrefix: "splash-")
        ]
    )
