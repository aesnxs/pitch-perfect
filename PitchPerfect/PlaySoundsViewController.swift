//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Justin Wong on 06/06/2015.
//  Copyright (c) 2015 Justin Wong. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var defaultRate: Float!
    var defaultPitch: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil )
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        defaultRate = 1.00
        defaultPitch = 1.00
    }
    
    @IBAction func playFast(sender: UIButton) {
        playAudio(2.0, pitch: defaultPitch)
        
    }
    @IBAction func playSlow(sender: UIButton) {
        playAudio(0.5,pitch: defaultPitch)
        
    }
    @IBAction func playChipmunk(sender: UIButton) {
        playAudio(defaultRate,pitch: 1000)
        
    }
    @IBAction func playDarth(sender: UIButton) {
        playAudio(defaultRate,pitch: -1000)
    }
    
    func playAudio(rate: Float, pitch: Float){
        stopAudio()
        if ( pitch != defaultPitch ){
            var audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attachNode(audioPlayerNode)
            
            var changePitchEffect = AVAudioUnitTimePitch()
            changePitchEffect.pitch = pitch
            audioEngine.attachNode(changePitchEffect)
            
            audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
            audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
            
            audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            audioEngine.startAndReturnError(nil)
            
            audioPlayerNode.play()
            
        } else {
            audioPlayer.rate = rate
            audioPlayer.play()
        }
    }
    func stopAudio(){
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
        audioPlayer.stop()
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        stopAudio()
    }

}
