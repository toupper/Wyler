//
//  ViewController.swift
//  SampleApp
//
//  Created by Cesar Vargas on 12.04.20.
//  Copyright © 2020 Cesar Vargas. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import Wyler
import AVFoundation

final class ViewController: UIViewController {
  @IBOutlet weak var bouncingBall: UIView!
  @IBOutlet weak var startRecordingButton: UIButton!
  @IBOutlet weak var startRecordingWithoutAudioButton: UIButton!
  @IBOutlet weak var stopRecordingButton: UIButton!
  @IBOutlet weak var cameraRollSwitch: UISwitch!
  @IBOutlet weak var cameraRollLabel: UILabel!

  private var player: AVAudioPlayer?
  private let screenRecorder = ScreenRecorder()

  override func viewDidLoad() {
    super.viewDidLoad()

    bouncingBall.layer.cornerRadius = bouncingBall.frame.width / 2
  }

  @IBAction func stopRecordingButtonWasPressed(_ sender: Any) {
    enableElements(isRecording: false)

    bouncingBall.layer.removeAllAnimations()
    self.bouncingBall.alpha = 1

    screenRecorder.stoprecording(errorHandler: { error in
      debugPrint("Error when stop recording \(error)")
    })
  }

    @IBAction func startRecordingButtonWasPressed(_ sender: Any) {
    enableElements(isRecording: true)

    playSound()
    animateBall()

        screenRecorder.startRecording(saveToCameraRoll: cameraRollSwitch.isOn,
                                  errorHandler: { error in
      debugPrint("Error when recording \(error)")
    })
  }
    
    @IBAction func startRecordingButtonWithoutAudioWasPressed(_ sender: Any) {
    enableElements(isRecording: true)

    playSound()
    animateBall()

        screenRecorder.startRecording(saveToCameraRoll: cameraRollSwitch.isOn,
                                      recordAudio: false,
                                  errorHandler: { error in
      debugPrint("Error when recording \(error)")
    })
  }

  private func playSound() {
      guard let url = Bundle.main.url(forResource: "MP3Sample", withExtension: "mp3") else { return }

      do {
          try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
          try AVAudioSession.sharedInstance().setActive(true)

          player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

          player?.play()

      } catch let error {
          print(error.localizedDescription)
      }
  }

  private func enableElements(isRecording: Bool) {
    startRecordingButton.isEnabled = !isRecording
    startRecordingWithoutAudioButton.isEnabled = !isRecording
    stopRecordingButton.isEnabled = isRecording
    cameraRollSwitch.isEnabled = !isRecording
    cameraRollLabel.isEnabled = !isRecording
  }

  private func animateBall() {
    UIView.animate(withDuration: 2,
                   delay: 1,
                   usingSpringWithDamping: 0.5,
                   initialSpringVelocity: 5,
                   options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
                    self.bouncingBall.alpha = 0.25
    }, completion: { _ in })
  }
}
