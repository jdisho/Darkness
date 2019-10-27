//
//  Menu.swift
//  Darkness
//
//  Created by Joan Disho on 24.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Cocoa

class Menu: NSMenu {

    private lazy var infoMenuItem: NSMenuItem = {
        let menuItem = NSMenuItem(
            title: "",
            action: nil,
            keyEquivalent: ""
        )

        Appearance.shared.observe { mode in
            menuItem.title = "Dark Mode: \(mode == .dark ? "Enabled" : "Disabled")"
        }

        return menuItem
    }()


    private lazy var darkModeMenuItem: NSMenuItem = {
        let menuItem = NSMenuItem(
            title: "Toggle Dark Mode",
            action: #selector(toggleAppearance),
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

        items.append(contentsOf: [
            infoMenuItem,
            darkModeMenuItem,
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
    }

    @objc private func quitDarkness() {
        NSApplication.shared.terminate(self)
    }
}
