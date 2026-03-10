<p align="center">
    <img src="wyler.png" width="650" alt="Wyler" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9%2B-orange.svg" alt="Swift 5.9+" />
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage" />
    </a>
    <a href="https://cocoapods.org/pods/Wyler">
        <img src="https://img.shields.io/cocoapods/v/Wyler.svg" alt="CocoaPods" />
    </a>
    <a href="https://swift.org/package-manager/">
        <img src="https://img.shields.io/badge/SPM-supported-brightgreen.svg" alt="Swift Package Manager" />
    </a>
</p>

Wyler is a lightweight Swift library that simplifies screen recording on iOS. You can record your app screen, access the recorded video file, and optionally save it to the Photo Library.

## Features

- App screen recording with ReplayKit
- Optional microphone and app audio capture
- Configurable output URL and video size
- Optional save to the Photo Library
- CocoaPods, Carthage, Swift Package Manager, or manual integration

## Requirements

- iOS 11.0+
- Swift 5.9+

## Installation

Since Wyler is implemented in a single source file, the simplest setup is to drag `ScreenRecorder.swift` into your Xcode project. If you prefer a package manager:

### Swift Package Manager

Add Wyler to your package dependencies:

```swift
.package(url: "https://github.com/toupper/Wyler.git", from: "1.0.1")
```

### CocoaPods

```ruby
platform :ios, '11.0'
use_frameworks!

target 'MyApp' do
  pod 'Wyler', '~> 1.0'
end
```

### Carthage

```ogdl
github "toupper/Wyler" ~> 1.0
```

## Usage

Import Wyler where you want to start recording:

```swift
import Wyler

let screenRecorder = ScreenRecorder()
```

Start a recording with the default output URL:

```swift
screenRecorder.startRecording(saveToCameraRoll: true) { error in
    debugPrint("Error when recording: \(error)")
}
```

Customize the output URL, size, and audio capture:

```swift
screenRecorder.startRecording(
    to: yourInternalURL,
    size: yourSize,
    saveToCameraRoll: true,
    recordAudio: shouldRecordAudio
) { error in
    debugPrint("Error when recording: \(error)")
}
```

Stop recording:

```swift
screenRecorder.stopRecording { error in
    debugPrint("Error when stopping recording: \(String(describing: error))")
}
```

If you save to the Photo Library, add `NSPhotoLibraryAddUsageDescription` to your app's `Info.plist`.

## Notes

- Wyler uses `ReplayKit`, so recording availability depends on Apple platform restrictions.
- Saving to the Photo Library is skipped unless `saveToCameraRoll` is `true`.

## License

Wyler is released under the MIT license. See [LICENSE](LICENSE) for details.
