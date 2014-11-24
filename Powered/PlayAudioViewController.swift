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
	var receivedAudio: RecordedAudio!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
//		if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//			var filePathURL = NSURL(fileURLWithPath: filePath)
//		} else {
//			println("File not found")
//		}
		audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
		audioPlayer.enableRate = true
//		audioPlayer.play()
	}
	
	func playAudio(rate:float_t) {
		audioPlayer.stop()
		audioPlayer.currentTime = 0.0
		audioPlayer.rate = rate
		audioPlayer.play()
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