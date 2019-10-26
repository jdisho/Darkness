//
//  Appearance.swift
//  Darkness
//
//  Created by Joan Disho on 22.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

enum Appearance: String {
    case light = "Light"
    case dark = "Dark"

    private var script: String {
        return "tell application \"System Events\" to tell appearance preferences to set dark mode to \(self == .some(.dark))"
    }

    static var current: Appearance {
        get {
            UserDefaults.appleInterfaceStyle == Appearance.dark.rawValue ? .dark : .light
        }
        set {
            set(mode: newValue)
        }
    }

    static var didChange: ((Appearance) -> Void)?

    func toggle() {
        switch Appearance.current {
        case .dark:
            Appearance.current = .light
        case .light:
            Appearance.current = .dark
        }
        Appearance.didChange?(.current)
    }

    private static func set(mode: Appearance) {
        guard let appleScript = NSAppleScript(source: mode.script) else { return }

        var error: NSDictionary?

        appleScript.executeAndReturnError(&error)

        if let error = error {
            print("Error: \(error)")
        }
    }
}

private extension UserDefaults {
    static var appleInterfaceStyle: String? {
        return standard.string(forKey: "AppleInterfaceStyle")
    }
}

