//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Caswell, Phil on 11/13/16.
//  Copyright © 2016 Caswell, Phil. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    // Method to handle the states of the buttons for recording and playback
    func configureRecordingButtons(isRecording: Bool){
        recordingLabel.text = isRecording ? "Recording in progress" : "Tap to record"
        recordButton.isEnabled = isRecording ? false: true
        stopRecordingButton.isEnabled = isRecording ? true : false
    }
    
     //Load the view and disable the recording button & fix the squishy size issue
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRecordingButtons(isRecording: false)
        stopRecordingButton.imageView?.contentMode = .scaleAspectFit
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // After the recording button is pushed, set configureRecordingButtons = true (see method)
    @IBAction func recordAudio(_ sender: Any) {
        print("record button pressed")
        configureRecordingButtons(isRecording: true)
        
        //Store the audio asset
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    // After the recording button is pushed, set configureRecordingButtons = false (see method)
    @IBAction func stopRecording(_ sender: Any) {
     configureRecordingButtons(isRecording: false)
        
        
        //Stop Recording the voice
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)


    }
    
    // Make sure all went well, or log an error
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
    print ("recording not sucessful")
    }
}
    // If all was well, then load up the playback view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
        let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = (recordedAudioURL as NSURL!) as URL!
        }
    }
}
