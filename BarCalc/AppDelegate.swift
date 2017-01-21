//
//  AppDelegate.swift
//  BarCalc
//
//  Created by Mookyung Kwak on 19/11/2016.
//  Copyright © 2016 Mookyung Kwak. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    
    @IBOutlet weak var window: NSWindow!

    let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // 바에 버튼을 올려준다
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = #selector(AppDelegate.toggleTextInput(_:))
        }
        
        // 버튼을 누르면 text input view controller를 띄워준다
        popover.contentViewController = TextInputViewController(nibName: "TextInputViewController", bundle: nil)
        
        // start up at login을 구현한다
        let launcherAppIdentifier = "com.passionproof.LauncherApplication"
        SMLoginItemSetEnabled(launcherAppIdentifier as CFString, true)
        var startedAtLogin = false
        for app in NSWorkspace.shared().runningApplications {
            if app.bundleIdentifier == launcherAppIdentifier {
                startedAtLogin = true
            }
        }
        if startedAtLogin {
            DistributedNotificationCenter.default().post(name: NSNotification.Name(rawValue: "killme"), object: Bundle.main.bundleIdentifier!)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func toggleTextInput(_ sender: AnyObject?) {
        print("start calculating")
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }
}

