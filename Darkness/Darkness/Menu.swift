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
            title: "JOAN",
            action: nil,
            keyEquivalent: ""
        )

        menuItem.target = self

//        Appearance.shared.observe { mode in
//            menuItem.title = "Dark Mode: \(mode == .dark ? "Enabled" : "Disabled")"
//        }

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
            darkModeMenuItem,
            NSMenuItem.separator(),
            infoMenuItem,
            NSMenuItem.separator(),
            quitMenuItem
            ]
        )

        infoMenuItem.view = ScreenBrightnessSliderView.loadFromNib()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func toggleAppearance() {
        Appearance.shared.toggle()
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
