//
//  RecordAudioViewController.swift
//  Powered
//
//  Created by Kennith Leung on 11/22/14.
//  Copyright (c) 2014 Kennith Leung. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {
	
	@IBOutlet weak var recordLabel: UILabel!
	@IBOutlet weak var stopButton: UIButton!
	@IBOutlet weak var microphoneButton: UIButton!
	
	var audioRecorder:AVAudioRecorder!
	var recordedAudio:RecordedAudio!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewWillAppear(animated: Bool) {
		stopButton.hidden = true
		recordLabel.hidden = true
		microphoneButton.enabled = true
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func recordAction(sender: UIButton) {
		// TODO:  Record user audio
		let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
		let currentDateTime = NSDate()
		let formatter = NSDateFormatter()
		formatter.dateFormat = "yyyyddMM-HHmmss"
		let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
		let pathArray = [dirPath, recordingName]
		let filePath = NSURL.fileURLWithPathComponents(pathArray)
		println(filePath)
		var session = AVAudioSession.sharedInstance()
		session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
		
		audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
		audioRecorder.delegate = self
		audioRecorder.meteringEnabled = true
		audioRecorder.record()
		
		
		recordLabel.hidden = false
		microphoneButton.enabled = false
		stopButton.hidden = false
		println("Button Click")
	}
	
	func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
		// TODO: 
		if(flag) {
			recordedAudio = RecordedAudio()
			recordedAudio.filePathUrl = recorder.url
			recordedAudio.title = recorder.url.lastPathComponent
			// TODO: Segue
			performSegueWithIdentifier("stopRecording", sender: recordedAudio)
		} else {
			println("segue did not complete")
			microphoneButton.enabled = true
			stopButton.hidden = true
		}
		
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		<#code#>
	}
	
	@IBAction func stopAction(sender: UIButton) {
		println("Stop Button clicked")
		recordLabel.hidden = true
		microphoneButton.enabled = true
		
		audioRecorder.stop()
		var audioSession = AVAudioSession.sharedInstance()
		audioSession.setActive(false, error: nil)
	}
}

