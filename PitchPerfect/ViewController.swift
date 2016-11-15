//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Caswell, Phil on 11/13/16.
//  Copyright © 2016 Caswell, Phil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("record button pressed")
        recordingLabel.text = "Recording in progress"
    }
    @IBAction func stopRecording(_ sender: Any) {
        print("stop recording button pressed")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear called")
    }
    
    @IBOutlet weak var recordButton: UIButton!
   
    @IBOutlet weak var stopRecordingButton: UIButton!
}

