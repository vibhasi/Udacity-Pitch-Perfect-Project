//
//  PlaySoundsViewController.swift
//  PitchPerfectProject
//
//  Created by Abhishek Singh on 4/1/18.
//  Copyright © 2018 vibha. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    
   

    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    var currentlyPlayingButton: UIButton!
    
    //MARK: - ButtonType( raw values correspond to sender(button) tag)
    enum ButtonType: Int {case snail = 0, rabbit, chipmunk, vader, echo, reverb}
    
    
    //MARK: - IB Actions
    @IBAction func playSoundForButton(_ sender: UIButton){
        
        switch (ButtonType(rawValue: sender.tag)!) {
        case .snail:
            playSound(rate: 0.5)
            self.currentlyPlayingButton = snailButton
        case .rabbit:
            playSound(rate: 1.5)
            self.currentlyPlayingButton = rabbitButton
        case .chipmunk:
            playSound(pitch: 1000)
            self.currentlyPlayingButton = chipmunkButton
        case .vader:
            playSound(pitch: -1000)
            self.currentlyPlayingButton = vaderButton
        case .echo:
            playSound(echo: true)
            self.currentlyPlayingButton = echoButton
        case .reverb:
            playSound(reverb: true)
            self.currentlyPlayingButton = reverbButton
        
        }
        
        configureUI(.playing)
        
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        
       stopAudio()
        
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        
      self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.title = "Pitch Perfect"
        setupAudio()
    }

    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAudio()
    }

}


