//
//  WindowController.swift
//  TrivialSlideshow1
//
//  Created by Chris Adamson on 5/24/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
		NSLog ("WindowController.windowDidLoad")
    }
	
	override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
		NSLog ("WindowController.prepareForSegue")
	}
	
	func openDocument(sender: AnyObject?) {
		NSLog ("WindowController.openDocument:")
		if let contentVC = self.contentViewController as? ViewController {
			NSLog ("found ViewController")
			let openPanel = NSOpenPanel()
			openPanel.allowedFileTypes = [kUTTypeJPEG as String]
			openPanel.allowsMultipleSelection = true
			openPanel.beginSheetModalForWindow(self.window!,
				completionHandler: { (result) -> Void in
					contentVC.imageURLs = openPanel.URLs
			})
			
		}
	}
	
}
