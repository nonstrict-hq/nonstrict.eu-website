# Changelog

### 0.8.0

- Fix: Other windows are no longer being recorded in WindowBasedCrop recorder

### 0.7.0

- Add support keyboard input recording

### 0.6.0

- The cursor type is now recorded when mouse events are being captured
- Correctly close connection to iPhone/iPad when recording is stopped

### 0.5.1

- Minor documentation improvements

### 0.5.0

- Add support for recording iPads (without support for rotation during the recording)

### 0.4.0

- Electron: Live camera preview is supported

### 0.3.4

- Reduced the amount of calls to ScreenCaptureKit, improving performance
- Improved error reporting when external devices fail to initialize

### 0.3.3

- Cleaned up log messages
- Fix timeout errors not immediatly being thrown
- Cancel internal tasks correctly when they time out

### 0.3.2

- Electron: Fix issue where RecordKit stopped responding when a 3rd party webcam wrote to the error output
- Swift: RecordKit is now available as SPM package

### 0.3.1

- Electron: Group types logically in API documentation
- Electron: Remove internal types from API documentation

### 0.3.0

- First publicly available release
