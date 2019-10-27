//
//  Appearance.swift
//  Darkness
//
//  Created by Joan Disho on 22.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

class Appearance {
    enum Mode: String {
        case light = "Light"
        case dark = "Dark"

        var script: String {
            return "tell application \"System Events\" to tell appearance preferences to set dark mode to \(self == .some(.dark))"
        }
    }

    private let observableMode = Observable<Mode>(UserDefaults.appleInterfaceStyle)

    static let shared = Appearance()

    var mode: Mode {
        get {
            UserDefaults.appleInterfaceStyle
        }
        set {
            set(mode: newValue)
        }
    }

    func observe(_ observer: @escaping ((Mode) -> Void)) {
        let observation = Observation<Mode>(observer: observer)
        observableMode.observe(observation)
    }

    private func set(mode: Mode) {
        guard let appleScript = NSAppleScript(source: mode.script) else { return }

        var error: NSDictionary?

        appleScript.executeAndReturnError(&error)

        if let error = error {
            print("Error: \(error)")
        }

        observableMode.value = mode
    }
}

private extension UserDefaults {
    static var appleInterfaceStyle: Appearance.Mode {
        return standard.string(forKey: "AppleInterfaceStyle") == Appearance.Mode.dark.rawValue ? .dark : .light
    }
}

