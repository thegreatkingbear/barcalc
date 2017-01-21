//
//  AppDelegate.swift
//  LauncherApplication
//
//  Created by Mookyung Kwak on 2017-01-20.
//  Copyright © 2017 Mookyung Kwak. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let mainAppIdentifier = "com.passionproof.BarCalc"
        let running = NSWorkspace.shared().runningApplications
        var alreadyRunning = false
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(AppDelegate.terminate), name: NSNotification.Name(rawValue: "killme"), object: mainAppIdentifier)
            
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("BarCalc")
            
            let newPath = NSString.path(withComponents: components)
            
            NSWorkspace.shared().launchApplication(newPath)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func terminate() {
        NSApp.terminate(nil)
    }
}

