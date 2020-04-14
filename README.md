<p align="center">
    <img src="wyler.png" width="650 max-width="90%" alt="Wyler" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.2-orange.svg" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage" />
    </a>
    <a href="https://cocoapods.org">
        <img src="https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg" alt="CocoaPods" />
    </a>
    <a href="http://makeapullrequest.com">
        <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square" alt="PRs Welcome" />
    </a>
    <a href="https://medium.com/@toupper">
        <img src="https://img.shields.io/badge/medium-@toupper-blue.svg" alt="Medium: @toupper" />
    </a>
</p>

Welcome to **Wyler** — A light library written in Swift that makes easy the process of Screen Recording for IOS. You can record your app video screen, access to the recorded video, and save it to the Photo Library.

## Features

- [x] App Screen Recording
- [x] Set Video Size
- [x] Access to the Video
- [x] Save the video to the Photo Library

## Requirements

- iOS 11.0+
- Xcode 11.0+

## Installation
Since Codextended is implemented within a single file, the easiest way to use it is to simply drag and drop it into your Xcode project. If anyways you want to use a dependency manager:

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `Wyler` by adding it to your `Podfile`:

```ruby
platform :ios, '11.0'
use_frameworks!
pod 'Wyler'
```

To get the full benefits import `Wyler` wherever you use it

``` swift
import Wyler
```
### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "toupper/Wyler"
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but Alamofire does support its use on supported platforms.

Once you have your Swift package set up, adding Wyler as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/toupper/Wyler.git", .upToNextMajor(from: "0.1.2"))
]
```
## Manually

You can also integrate Wyler into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add Wyler as a git [submodule](https://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/toupper/Wyler.git
  ```

- Open the new `Wyler` folder, and drag the `Wyler.xcodeproj` into the Project Navigator of your application's Xcode project.

- And that's it!

## Usage example

###  Recording

Import Wyler in the file you are going to use it. Create an instance of ```ScreenRecorder```, and call it to start recording whenever you want:

```swift
import Wyler

screenRecorder.startRecording(saveToCameraRoll: true, errorHandler: { error in
  debugPrint("Error when recording \(error)")
})
```
If you want to access the video or set a different size than the App screen, you can pass these parameters:

```swift
import Wyler

screenRecorder.startRecording(to: yourInternalURL,
                              size: yourSize,
                              saveToCameraRoll: true, 
                              errorHandler: { error in
                                debugPrint("Error when recording \(error)")
                              })
```


When you want to stop recording, you just have to call the recorder with stop recording:

```swift
import Wyler

screenRecorder.stoprecording(errorHandler: { error in
  debugPrint("Error when stop recording \(error)")
})
```
If you want to save the video to the camera, do not forget to add the Privacy - Photo Library Usage Description to the Info.plist
## Contribute

We would love you for the contribution to **Wyler**, check the ``LICENSE`` file for more info.

## Credits

Created and maintained with love by [César Vargas Casaseca](https://github.com/toupper). You can follow me on Medium [@toupper](https://medium.com/@toupper) for project updates, releases and more stories.

## License

Wyler is released under the MIT license. [See LICENSE](https://github.com/toupper/Wyler/blob/master/LICENSE) for details.
