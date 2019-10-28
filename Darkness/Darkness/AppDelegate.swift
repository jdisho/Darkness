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
        configureStatusItem()
    }

    private func configureStatusItem() {
        statusItem.menu = Menu()

        Appearance.shared.observe { appearance in
            self.statusItem.button?.image = (Appearance.shared.mode == .dark ? "moon.stars.fill" : "sun.max.fill").toImage()
        }
    }
}

private extension String {
    func toImage() -> NSImage? {
        return NSImage(named: NSImage.Name(self))
    }
}

