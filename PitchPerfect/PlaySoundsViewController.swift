//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Caswell, Phil on 11/20/16.
//  Copyright © 2016 Caswell, Phil. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //Map the buttons
    enum ButtonType: Int { case slow = 1, fast = 2, chipmunk = 3, vader = 4 , echo = 5, reverb = 6 }

    // Log the action, and play funny audio back
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Button Pressed")
            switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            }
            
            configureUI(.playing)
    
    }
    // Stop the audio
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Change each button's content mode to .scaleAspectFit
        snailButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        rabbitButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        chipmunkButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        vaderButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        echoButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        reverbButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        stopButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        
        setupAudio()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
}
