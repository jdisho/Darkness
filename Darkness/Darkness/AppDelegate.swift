//
//  AppDelegate.swift
//  Darkness
//
//  Created by Joan Disho on 17.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
          button.image = NSImage(named: NSImage.Name("moon.fill"))
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

