//
//  ScreenRecorder.swift
//  Wyler
//
//  Created by Cesar Vargas on 10.04.20.
//  Copyright © 2020 Cesar Vargas. All rights reserved.
//

import Foundation
import ReplayKit
import Photos

public enum ScreenRecorderError: Error {
    case notAvailable
    case photoLibraryAccessNotGranted
}

final public class ScreenRecorder {
  private var videoOutputURL: URL?
  private var videoWriter: AVAssetWriter?
  private var videoWriterInput: AVAssetWriterInput?
  private var micAudioWriterInput: AVAssetWriterInput?
  private var appAudioWriterInput: AVAssetWriterInput?
  private var saveToCameraRoll = false
  let recorder = RPScreenRecorder.shared()

  /**
   Starts recording the content of the application screen. It works together with stopRecording

  - Parameter outputURL: The output where the video will be saved. If nil, it saves it in the documents directory.
  - Parameter size: The size of the video. If nil, it will use the app screen size.
  - Parameter saveToCameraRoll: Whether to save it to camera roll. False by default.
  - Parameter errorHandler: Called when an error is found
  */
  public func startRecording(to outputURL: URL? = nil,
                             size: CGSize? = nil,
                             saveToCameraRoll: Bool = false,
                             handler: @escaping (Error?) -> Void) {
    recorder.isMicrophoneEnabled = true
    do {
        try createVideoWriter(in: outputURL)
        addVideoWriterInput(size: size)
        self.micAudioWriterInput = createAndAddAudioInput()
        self.appAudioWriterInput = createAndAddAudioInput()
        startCapture(handler: handler)
    } catch let err {
        handler(err)
    }
  }

  private func checkPhotoLibraryAuthorizationStatus() {
    let status = PHPhotoLibrary.authorizationStatus()
    if status == .notDetermined {
      PHPhotoLibrary.requestAuthorization({ _ in })
    }
  }

  private func createVideoWriter(in outputURL: URL? = nil) throws {
    let newVideoOutputURL: URL

    if let passedVideoOutput = outputURL {
      self.videoOutputURL = passedVideoOutput
      newVideoOutputURL = passedVideoOutput
    } else {
      let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
      newVideoOutputURL = URL(fileURLWithPath: documentsPath.appendingPathComponent("WylerNewVideo.mp4"))
      self.videoOutputURL = newVideoOutputURL
    }

    do {
      try FileManager.default.removeItem(at: newVideoOutputURL)
    } catch {}

    do {
      try videoWriter = AVAssetWriter(outputURL: newVideoOutputURL, fileType: AVFileType.mp4)
    } catch let writerError as NSError {
      videoWriter = nil
      throw writerError
    }
  }

  private func addVideoWriterInput(size: CGSize?) {
    let passingSize: CGSize = size ?? UIScreen.main.bounds.size

    let videoSettings: [String: Any] = [AVVideoCodecKey: AVVideoCodecType.h264,
                                        AVVideoWidthKey: passingSize.width,
                                        AVVideoHeightKey: passingSize.height]

    let newVideoWriterInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: videoSettings)
    self.videoWriterInput = newVideoWriterInput
    newVideoWriterInput.expectsMediaDataInRealTime = true
    videoWriter?.add(newVideoWriterInput)
  }
  
  private func createAndAddAudioInput() -> AVAssetWriterInput {
    let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]

    let audioInput = AVAssetWriterInput(mediaType: .audio, outputSettings: settings)

    audioInput.expectsMediaDataInRealTime = true
    videoWriter?.add(audioInput)
    
    return audioInput
  }

  private func startCapture(handler: @escaping (Error?) -> Void) {
    guard recorder.isAvailable else {
        return handler(ScreenRecorderError.notAvailable)
    }
    recorder.startCapture(handler: { (sampleBuffer, sampleType, passedError) in
      if let passedError = passedError {
        handler(passedError)
      }

      switch sampleType {
      case .video:
        self.handleSampleBuffer(sampleBuffer: sampleBuffer)
      case .audioApp:
        self.add(sample: sampleBuffer, to: self.appAudioWriterInput)
      case .audioMic:
        self.add(sample: sampleBuffer, to: self.micAudioWriterInput)
      default:
        break
      }
      handler(nil)
    })
  }

  private func handleSampleBuffer(sampleBuffer: CMSampleBuffer) {
    if self.videoWriter?.status == AVAssetWriter.Status.unknown {
      self.videoWriter?.startWriting()
      self.videoWriter?.startSession(atSourceTime: CMSampleBufferGetPresentationTimeStamp(sampleBuffer))
    } else if self.videoWriter?.status == AVAssetWriter.Status.writing &&
      self.videoWriterInput?.isReadyForMoreMediaData == true {
      self.videoWriterInput?.append(sampleBuffer)
    }
  }
  
  private func add(sample: CMSampleBuffer, to writerInput: AVAssetWriterInput?) {
    if writerInput?.isReadyForMoreMediaData ?? false {
      writerInput?.append(sample)
    }
  }

  /**
   Stops recording the content of the application screen, after calling startRecording

  - Parameter errorHandler: Called when an error is found
  */
  public func stoprecording(handler: @escaping (Error?) -> Void) {
    recorder.stopCapture( handler: { error in
      if let error = error {
        handler(error)
      } else {
        self.videoWriterInput?.markAsFinished()
        self.micAudioWriterInput?.markAsFinished()
        self.appAudioWriterInput?.markAsFinished()
        self.videoWriter?.finishWriting {
          self.saveVideoToCameraRollAfterAuthorized(handler: handler)
        }
      }
    })
  }

  private func saveVideoToCameraRollAfterAuthorized(handler: @escaping (Error?) -> Void) {
    if PHPhotoLibrary.authorizationStatus() == .authorized {
        self.saveVideoToCameraRoll(handler: handler)
    } else {
        PHPhotoLibrary.requestAuthorization({ (status) in
            if status == .authorized {
                self.saveVideoToCameraRoll(handler: handler)
            } else {
              handler(ScreenRecorderError.photoLibraryAccessNotGranted)
          }
        })
    }
  }

  private func saveVideoToCameraRoll(handler: @escaping (Error?) -> Void) {
    guard let videoOutputURL = self.videoOutputURL else {
      return handler(nil)
    }

    PHPhotoLibrary.shared().performChanges({
      PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoOutputURL)
    }, completionHandler: { _, error in
      if let error = error {
          handler(error)
      } else {
          handler(nil)
      }
    })
  }
}
