//
//  ViewController.swift
//  PitchPerfectProject
//
//  Created by Abhishek Singh on 3/29/18.
//  Copyright © 2018 vibha. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    var isRecording: Bool = false
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setNavigationBar()
        configureUI()
    }

    func setNavigationBar(){
        
       
        self.navigationItem.title = "Pitch Perfect"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.hidesBackButton = true
    }
    

    @IBAction func recordAudio(_ sender: UIButton) {
       
       
        isRecording = !isRecording
        configureUI()
        
        isRecording ? startRecording() : stopRecording()
        
    }
    // MARK: - configure UI
    
    func configureUI(){
        
        self.recordButton.isSelected = isRecording
        
        if isRecording {
            
            self.recordingLabel.text = "Tap to finish recording"
            
        
        }else{
        
            self.recordingLabel.text = "Tap to start recording"
        }
        
    }
    // MARK: - Audio Recording functions
    
    func startRecording(){
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopRecording(){
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }


    // MARK: - AudioRecorderDelegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag{
            
          performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            
        }else{
            
            let alert = UIAlertController(title: "Error", message: "The recording was not successful", preferredStyle: .alert)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "stopRecording"{
            
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL  = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            
        }
    }
    
}

