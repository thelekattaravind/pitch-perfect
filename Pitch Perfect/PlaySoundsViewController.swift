//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Aravind on 5/27/15.
//  Copyright (c) 2015 Aravind. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {
    var audioplayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)

        audioplayer = AVAudioPlayer(contentsOfURL:receivedAudio.filePathURL, error: nil)
        audioplayer.enableRate = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func PlayAudio(rate:Float){
        audioplayer.stop()
        audioplayer.rate = rate
        audioplayer.currentTime = 0.0
        audioplayer.play()
        
    }

    @IBAction func SlowSound(sender: AnyObject) {
        PlayAudio(0.5)
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func FastSound(sender: UIButton) {
        PlayAudio(2)
        audioEngine.stop()
        audioEngine.reset()

    }
    
    
    @IBAction func StopAll(sender: UIButton) {
        audioplayer.stop()
        audioplayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func PlayVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func PlayChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
    audioplayer.stop()
    audioEngine.stop()
    audioEngine.reset()
    
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
    }
    
}
