# Logging and Error Handling

RecordKit provides structured logging and user-friendly errors to help you debug issues and inform your users.

## Logging

By default, RecordKit logs to the system console. You can forward logs to your own logging infrastructure (SwiftLog, electron-log, etc.) and control verbosity with log levels.

Set the log level using `setLogLevel()`. Available levels from most to least verbose: `trace`, `debug` (default), `info`, `warning`, `error`, `critical`.

::: code-group
```swift [Swift]
RKLogger.shared.setLogLevel(.info)
```

```ts [Electron]
// During initialization
await recordkit.initialize({
    rpcBinaryPath: path.join(process.resourcesPath, 'recordkit-rpc'),
    logLevel: 'info'
})

// Or after initialization
await recordkit.setLogLevel('info')
```
:::

### Forwarding Logs

Connect RecordKit's logs to your existing logging setup.

::: code-group
```swift [Swift]
import Logging
import RecordKit

private let logger = Logger(label: "RecordKit")

// Forward RecordKit logs to SwiftLog
func setupRecordKitLogging() {
    RKLogger.shared.setLogLevel(.debug)
    RKLogger.shared.setLogHandler(mode: .realtime) { message in
        let level: Logger.Level = switch message.level {
        case .trace:    .trace
        case .debug:    .debug
        case .info:     .info
        case .warning:  .warning
        case .error:    .error
        case .critical: .critical
        @unknown default: .info
        }
        logger.log(level: level, "[\(message.category)] \(message.message)")
    }
}
```

```ts [Electron]
recordkit.on('log', (event) => {
    // Forward to your logging system
    myLogger.log(event.formattedMessage)
})
```
:::

::: tip Handler Modes
In Swift, `.realtime` delivers logs inline, but your handler must be fast to avoid blocking RecordKit. `.nonblocking` (default) delivers logs on a background thread, so your handler won't block RecordKit even if it's slow. In Electron, logs are always delivered non-blocking.
:::

For per-category log levels and more, see the API reference: [Swift](https://nonstrict.eu/recordkit/api/swift/documentation/recordkit/rklogger) | [Electron](https://nonstrict.eu/recordkit/api/electron/classes/RecordKit.html)

## Error Handling

RecordKit errors are designed to be shown directly to users. Every error includes:

- A **user-friendly message** that explains what went wrong, safe to display in your UI
- A **technical description** with details useful for logging and troubleshooting

::: code-group
```swift [Swift]
do {
    try await recorder.start()
} catch {
    // User-friendly message, e.g. "Can't record 'Cinema Display' because it is not connected anymore."
    showAlert(message: error.localizedDescription)

    // Technical details, e.g. "displayUnavailable - RKDisplay 12345 has availability: notConnected"
    logger.error("Recording failed: \((error as NSError).debugDescription)")
}
```

```ts [Electron]
try {
    await recorder.start()
} catch (error) {
    // User-friendly message, e.g. "Can't record 'Cinema Display' because it is not connected anymore."
    dialog.showErrorBox('Recording Failed', error.message)

    // Technical details, e.g. "displayUnavailable - RKDisplay 12345 has availability: notConnected"
    console.error('Recording failed:', error.debugDescription)
}
```
:::

For all error codes, see the [API reference](https://nonstrict.eu/recordkit/api/swift/documentation/recordkit/rkerror/code-swift.enum).
