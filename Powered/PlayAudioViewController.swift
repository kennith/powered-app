//
//  PlayAudioViewController.swift
//  Powered
//
//  Created by Kennith Leung on 11/23/14.
//  Copyright (c) 2014 Kennith Leung. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioViewController: UIViewController {
	var audioPlayer: AVAudioPlayer!
	var receivedAudio: RecordedAudio! // The audio file recorded from RecordAudioViewController
	var audioEngine: AVAudioEngine!
	
	var audioFile: AVAudioFile!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// This is using a audio file included with the app. (hard coded)
		//		if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
		//			var filePathURL = NSURL(fileURLWithPath: filePath)
		//		} else {
		//			println("File not found")
		//		}
		
		// Set the audioplayer using the recorded audio from another viewController
		audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
		audioPlayer.enableRate = true
		//		audioPlayer.play()
		
		audioEngine = AVAudioEngine()
		audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
		
	}
	
	// Unifed play audio function.
	func playAudio(rate: Float) {
		audioPlayer.stop()
		audioPlayer.currentTime = 0.0
		audioPlayer.rate = rate
		audioPlayer.play()
	}
	
	@IBAction func PlayChipmunkAction(sender: UIButton) {
		playPitchedAudio(1000)
	}
	
	@IBAction func PlayDarthVadarAction(sender: UIButton) {
		playPitchedAudio(-1000)
	}
	
	// This function wants to use the AVAudioUnitTimePitch
	// The challenge of using the AVAudioTimePicth cannot just convert the recorded audio
	// We have to do the following:
	// 1. Create a AVAudioEngine, a AVAudioPlayerNode, a AVAudioUnitTimePitch
	// 2. Attach the AVAudioPlayerNode to AVAudioEngine
	// 3. attach the AVAudioTimePitch to AVAudioEngine
	// 4. Using the AVAudioEngine to connect the AVAUdioPlayerNode to AVAudioUnitTimePitch
	// 5. Using the AVAudioEngine to connect the AVAudioUnitTimePitch to a AVAudioEngine output
	// 6. Add (schedule) the AVAudioFile to AVAudioPlayerNode
	// 7. Play the AVAudioPlayerNode
	// 
	// IMHO: It's a lot of steps. 
	func playPitchedAudio(pitch: Float) {
		audioPlayer.stop()
		audioEngine.stop()
		audioEngine.reset()
		
		var audioPlayerNode = AVAudioPlayerNode()
		audioEngine.attachNode(audioPlayerNode)
		
		var changePitch = AVAudioUnitTimePitch()
		changePitch.pitch = pitch
		audioEngine.attachNode(changePitch)
		audioEngine.connect(audioPlayerNode, to: changePitch, format: nil)
		audioEngine.connect(changePitch, to: audioEngine.outputNode, format: nil)
		audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
		audioEngine.startAndReturnError(nil)
		
		audioPlayerNode.play()
	}
	
	@IBAction func PlaySlowAction(sender: UIButton) {
		playAudio(0.5)
	}
	
	@IBAction func PlayFastAction(sender: UIButton) {
		playAudio(2.0)
	}
	
	@IBAction func StopAction(sender: UIButton) {
		audioPlayer.stop()
	}
}