//
//  ViewController.swift
//  Powered
//
//  Created by Kennith Leung on 11/22/14.
//  Copyright (c) 2014 Kennith Leung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var recordLabel: UILabel!
	@IBOutlet weak var stopButton: UIButton!
	@IBOutlet weak var microphoneButton: UIButton!
	
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
		recordLabel.hidden = false
		microphoneButton.enabled = false
		stopButton.hidden = false
		println("Button Click")
	}
	
	@IBAction func stopAction(sender: UIButton) {
		println("Stop Button clicked")
		recordLabel.hidden = true
		microphoneButton.enabled = true
	}
}

