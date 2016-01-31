//
//  ViewController.swift
//  TrivialSlideshow1
//
//  Created by Chris Adamson on 5/24/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import Cocoa
import Quartz

class ViewController: NSViewController {
	
//	let image1 = NSImage(named: "preroll-nozaki-kun-03.jpg")
//	let image2 = NSImage(named: "preroll-ef-melodies-01.jpg")
	
	var imageURLs : [AnyObject] = [] {
		didSet {
			NSLog ("VC got URLs: \(imageURLs)")
		}
	}
	
	var timer : NSTimer?
	
	var currentImageView : NSView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateSubviewsWithDefaultTransition()
		
		timer = NSTimer.scheduledTimerWithTimeInterval(10.0,
			target: self,
			selector: "chooseNextSlide:",
			userInfo: nil,
			repeats: true)
		
	}
	
	func openDocument(sender: AnyObject?) {
		NSLog ("ViewController.openDocument:")
	}

	func open(sender: AnyObject?) {
		NSLog ("WindowController.open:")
	}

	func chooseNextSlide (timer: NSTimer) {
		if imageURLs.count == 0 {
			return
		}
		
		let index = Int(arc4random()) % imageURLs.count
		NSLog ("choose index \(index)")
		if let URL = imageURLs[index] as? NSURL {
			if let image = NSImage (contentsOfURL: URL) {
				transitionToImage(image)
			}
		}
	}
	
	
	// MARK - from Apple ImageTransition example
	func updateSubviewsWithDefaultTransition() {
		let transition = CATransition()
		transition.type = kCATransitionFade
		transition.duration = 1.0
		self.view.animations = ["subviews" : transition]

	}
	
	func transitionToImage (newImage: NSImage?) {
	// create a new NSImageView and swap it into the view in place of our previous NSImageView.
	// this will trigger the transition animation we've wired up in -updateSubviewsTransition,
	// which fires on changes in the "subviews" property.
        // TODO: fix up with a nice if-let instead of unwraps
        var newImageView : NSImageView? = nil
		if let newImage = newImage {
			newImageView = NSImageView(frame: self.view.bounds)
            newImageView?.wantsLayer = true
//            newImageView?.layer?.borderColor = NSColor.pinkColor().CGColor
//            newImageView?.layer?.borderWidth = 6.0
            newImageView?.imageScaling = .ScaleProportionallyUpOrDown
			newImageView!.image = newImage
			let mask : NSAutoresizingMaskOptions = [.ViewWidthSizable, .ViewHeightSizable]
			newImageView!.autoresizingMask = mask
		}
	
		if currentImageView != nil && newImageView != nil {
			self.view.animator().replaceSubview(currentImageView!, with: newImageView!)
		} else {
			if currentImageView != nil {
				currentImageView?.animator().removeFromSuperview()
			}
			if newImageView != nil {
				view.animator().addSubview(newImageView!)
			}
		}
		currentImageView = newImageView
	}
}