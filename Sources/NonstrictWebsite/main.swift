import ReadingTimePublishPlugin

try! NonstrictWebsite()
    .publish(
        withTheme: .nonstrict,
        additionalSteps: [
            .installPlugin(.readingTime())
        ]
    )
