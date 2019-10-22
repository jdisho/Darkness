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

    var script: String {
        return "tell application \"System Events\" to tell appearance preferences to set dark mode to \(self == .some(.dark) ? "true" : "not dark mode")"
    }

    static var mode: Appearance {
        get {
            UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == Appearance.dark.rawValue ? .dark : .light
        }
        set {
            set(mode: newValue)
        }
    }

    private static func set(mode: Appearance) {
        var error: NSDictionary?
        guard let appleScript = NSAppleScript(source: mode.script) else { return }
        if let output = appleScript.executeAndReturnError(&error).stringValue {
            print(output)
        } else if let error = error {
            print("Error: \(error)")
        }
    }
}

