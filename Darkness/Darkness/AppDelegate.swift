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

    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = Appearance.current == .dark ? "☀" : "☾"
        statusItem.button?.action = #selector(toggle)

        Appearance.didChange = { appearance in
            self.statusItem.button?.title = appearance == .dark ? "☀" : "☾"
        }
    }

    @objc private func toggle() {
        Appearance.current.toggle()
    }
}

