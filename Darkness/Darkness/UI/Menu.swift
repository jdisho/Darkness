//
//  Menu.swift
//  Darkness
//
//  Created by Joan Disho on 24.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Cocoa
import HotKey


class Menu: NSMenu {

    private lazy var infoMenuItem: NSMenuItem = {
        let menuItem = NSMenuItem(
            title: "",
            action: nil,
            keyEquivalent: ""
        )

        menuItem.target = self

        Appearance.shared.observe { mode in
            menuItem.title = "Dark Mode: \(mode == .dark ? "Enabled" : "Disabled")"
        }

        return menuItem
    }()

    private lazy var darkModeMenuItem: NSMenuItem = {
        let menuItem = NSMenuItem(
            title: "Toggle Dark Mode",
            action: #selector(toggleAppearance),
            keyEquivalent: "D"
        )

        menuItem.target = self
        menuItem.keyEquivalentModifierMask = [.shift, .option, .command]

        HotKey.toggleDarkModeKeyCombo.handleKeyDown { [weak self] in
            self?.toggleAppearance()
        }

        return menuItem
    }()

    private lazy var brightnessMenuItem: NSMenuItem = {
        let menuItem = NSMenuItem()
        menuItem.view = BrightnessSliderView.loadFromNib()
        return menuItem
    }()


    private lazy var aboutMenuItem: NSMenuItem = {
        let menuItem = NSMenuItem(
            title: "About",
            action: #selector(openAbout),
            keyEquivalent: ""
        )
        menuItem.target = self
        return menuItem
    }()

    private lazy var quitMenuItem: NSMenuItem = {
        let menuItem = NSMenuItem(
            title: "Quit",
            action: #selector(quitDarkness),
            keyEquivalent: ""
        )

        menuItem.target = self

        return menuItem
    }()

    init() {
        super.init(title: "")
 
        delegate = self

        items.append(contentsOf: [
            infoMenuItem,
            darkModeMenuItem,
            NSMenuItem.separator(),
            brightnessMenuItem,
            NSMenuItem.separator(),
            aboutMenuItem,
            NSMenuItem.separator(),
            quitMenuItem
            ]
        )
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func toggleAppearance() {
        Appearance.shared.toggle()
        (brightnessMenuItem.view as? BrightnessSliderView)?.disableAutomaticSwitch()
    }

    @objc private func openAbout() {
        let aboutViewController = AboutViewController.loadFromNib()
        let aboutWindow = NSWindow(contentViewController: aboutViewController)

        NSApp.activate(ignoringOtherApps: true)

        aboutWindow.titleVisibility = .hidden
        aboutWindow.titlebarAppearsTransparent = true
        aboutWindow.styleMask.remove(.fullScreen)
        aboutWindow.styleMask.remove(.miniaturizable)
        aboutWindow.styleMask.remove(.resizable)
        aboutWindow.makeKeyAndOrderFront(self)

        aboutWindow.standardWindowButton(.zoomButton)?.isHidden = true
        aboutWindow.standardWindowButton(.miniaturizeButton)?.isHidden = true

        NSWindowController(window: aboutWindow).showWindow(self)
    }

    @objc private func quitDarkness() {
        NSApplication.shared.terminate(self)
    }
}

// MARK: NSMenuDelegate
extension Menu: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        HotKey.toggleDarkModeKeyCombo.isPaused = true
    }

    func menuDidClose(_ menu: NSMenu) {
        HotKey.toggleDarkModeKeyCombo.isPaused = false
    }
}

private extension HotKey {
    static let toggleDarkModeKeyCombo = HotKey(key: .d, modifiers: [.shift, .option, .command])

    func handleKeyDown(_ handler: @escaping (() -> Void)) {
        keyDownHandler = {
            handler()
            self.handleKeyDown(handler)
        }
    }
}
