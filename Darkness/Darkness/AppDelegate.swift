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

        UserDefaults.standard.addObserver(self, forKeyPath: "AppleInterfaceStyle", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        statusItem.button?.image = (Appearance.shared.mode == .dark ? "moon.stars.fill" : "sun.max.fill").toImage()
    }

    private func configureStatusItem() {
        let menu = Menu()
        menu.delegate = self
        statusItem.menu = menu

        Appearance.shared.observe { appearance in
            self.statusItem.button?.image = (Appearance.shared.mode == .dark ? "moon.stars.fill" : "sun.max.fill").toImage()
        }
    }
}

// MARK: NSMenuDelegate
extension AppDelegate: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {}
}

private extension String {
    func toImage() -> NSImage? {
        return NSImage(named: NSImage.Name(self))
    }
}

