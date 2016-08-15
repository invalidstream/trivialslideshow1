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
	
	var imageURLs : [URL] = [] {
		didSet {
			NSLog ("VC got URLs: \(imageURLs)")
		}
	}
    var shuffledImageURLs : [URL] = []
    
	var timer : Timer?
	
	var currentImageView : NSView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateSubviewsWithDefaultTransition()
		
		timer = Timer.scheduledTimer(timeInterval: 10.0,
			target: self,
			selector: #selector(ViewController.chooseNextSlide(_:)),
			userInfo: nil,
			repeats: true)
		
	}
	
	func openDocument(_ sender: AnyObject?) {
		NSLog ("ViewController.openDocument:")
	}

	func open(_ sender: AnyObject?) {
		NSLog ("WindowController.open:")
	}

	func chooseNextSlide (_ timer: Timer) {
        if shuffledImageURLs.isEmpty {
            shuffleImageURLs()
        }
		guard !shuffledImageURLs.isEmpty else { return }
		
        let url = shuffledImageURLs.removeFirst()
        if let image = NSImage(contentsOf: url) {
            transitionToImage(image)
        }
	}
	
    private func shuffleImageURLs() {
        guard !imageURLs.isEmpty else { return }
        shuffledImageURLs = imageURLs.shuffled()
    }
    
	
	// MARK - from Apple ImageTransition example
	func updateSubviewsWithDefaultTransition() {
		let transition = CATransition()
		transition.type = kCATransitionFade
		transition.duration = 1.0
		self.view.animations = ["subviews" : transition]

	}
	
	func transitionToImage (_ newImage: NSImage?) {
	// create a new NSImageView and swap it into the view in place of our previous NSImageView.
	// this will trigger the transition animation we've wired up in -updateSubviewsTransition,
	// which fires on changes in the "subviews" property.
        // TODO: lose the force-unwraps
        var newImageView : NSImageView? = nil
		if let newImage = newImage {
			newImageView = NSImageView(frame: self.view.bounds)
            newImageView?.wantsLayer = true
//            newImageView?.layer?.borderColor = NSColor.pinkColor().CGColor
//            newImageView?.layer?.borderWidth = 6.0
            newImageView?.imageScaling = .scaleProportionallyUpOrDown
			newImageView!.image = newImage
			let mask : NSAutoresizingMaskOptions = [.viewWidthSizable, .viewHeightSizable]
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
