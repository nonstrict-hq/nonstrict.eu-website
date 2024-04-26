import ReadingTimePublishPlugin
import SplashPublishPlugin

try! CleanPresenterWebsite()
    .publish(
        withTheme: .cleanPresenter,
        additionalSteps: [
            .installPlugin(.readingTime())
        ],
        plugins: [
            .splash(withClassPrefix: "splash-")
        ]
    )
