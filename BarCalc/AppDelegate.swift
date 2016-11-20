//
//  AppDelegate.swift
//  BarCalc
//
//  Created by Mookyung Kwak on 19/11/2016.
//  Copyright © 2016 Mookyung Kwak. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    
    @IBOutlet weak var window: NSWindow!

    let popover = NSPopover()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = #selector(AppDelegate.toggleTextInput(_:))
        }
        
        popover.contentViewController = TextInputViewController(nibName: "TextInputViewController", bundle: nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func toggleTextInput(sender: AnyObject?) {
        print("start calculating")
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
}

