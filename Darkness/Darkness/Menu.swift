//
//  Menu.swift
//  Darkness
//
//  Created by Joan Disho on 24.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Cocoa

class Menu: NSMenu {
    init() {
        super.init(title: "")

        removeAllItems()

        addItem(NSMenuItem(title: "Appearance", action: nil, keyEquivalent: ""))

        let lightMenuItem = NSMenuItem(
            title: "Light",
            action: #selector(activateLightMode),
            keyEquivalent: "L"
        )
        lightMenuItem.target = self
        lightMenuItem.keyEquivalentModifierMask = NSEvent.ModifierFlags(arrayLiteral: [.shift, .option])

        let darkMenuItem = NSMenuItem(
            title: "Dark",
            action: #selector(activateDarkMode),
            keyEquivalent: "D"
        )
        darkMenuItem.target = self
        darkMenuItem.keyEquivalentModifierMask = NSEvent.ModifierFlags(arrayLiteral: [.shift, .option])

        items.append(contentsOf: [lightMenuItem, darkMenuItem])
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func activateLightMode() {
        Appearance.current = .light
    }

    @objc private func activateDarkMode() {
        Appearance.current = .dark
    }
}
