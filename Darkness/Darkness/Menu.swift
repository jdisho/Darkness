//
//  Menu.swift
//  Darkness
//
//  Created by Joan Disho on 24.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Cocoa

class Menu: NSMenu {

    private lazy var lightMenuItem: NSMenuItem = {
        let menuItem = NSMenuItem(
            title: "Light",
            action: #selector(activateLightMode),
            keyEquivalent: "L"
        )

        menuItem.state = Appearance.current == .light ? .on : .off
        menuItem.target = self
        menuItem.keyEquivalentModifierMask = NSEvent.ModifierFlags(arrayLiteral: [.shift, .option])

        return menuItem
    }()

    private lazy var darkMenuItem: NSMenuItem = {
        let menuItem = NSMenuItem(
            title: "Dark",
            action: #selector(activateDarkMode),
            keyEquivalent: "D"
        )

        menuItem.state = Appearance.current == .dark ? .on : .off
        menuItem.target = self
        menuItem.keyEquivalentModifierMask = NSEvent.ModifierFlags(arrayLiteral: [.shift, .option])

        return menuItem
    }()

    init() {
        super.init(title: "")

        addItem(NSMenuItem(title: "Appearance", action: nil, keyEquivalent: ""))

        items.append(contentsOf: [lightMenuItem, darkMenuItem])
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func activateLightMode() {
        Appearance.current = .light
        lightMenuItem.state = .on
        darkMenuItem.state = .off
    }

    @objc private func activateDarkMode() {
        Appearance.current = .dark
        lightMenuItem.state = .off
        darkMenuItem.state = .on
    }
}
