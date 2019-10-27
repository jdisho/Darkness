//
//  Appearance.swift
//  Darkness
//
//  Created by Joan Disho on 22.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

class Appearance: NSObject {
    enum Mode: String {
        case light = "Light"
        case dark = "Dark"

        var script: String {
            return "tell application \"System Events\" to tell appearance preferences to set dark mode to \(self == .some(.dark))"
        }
    }

    private let observableMode = Observable<Mode>(UserDefaults.standard.appleInterfaceStyle)

    static let shared = Appearance()
    
    var mode: Mode {
        get {
            UserDefaults.standard.appleInterfaceStyle
        }
        set {
            UserDefaults.standard.internalInterfaceStyleString = newValue.rawValue
            set(mode: newValue)
        }
    }

    override init() {
        super.init()

        UserDefaults.standard.addObserver(self, forKeyPath: "AppleInterfaceStyle", options: .new, context: nil)
    }

    func observe(_ observer: @escaping ((Mode) -> Void)) {
        let observation = Observation<Mode>(observer: observer)
        observableMode.observe(observation)
    }

    func toggle() {
        switch mode {
        case .light:
            mode = .dark
        case .dark:
            mode = .light
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else { return }
        guard let userDefaults = object as? UserDefaults else { return }
        let mode: Mode = userDefaults.value(forKey: keyPath) as? String == self.mode.rawValue ? .dark : .light

        if UserDefaults.standard.internalInterfaceStyleString != mode.rawValue {
            observableMode.value = mode
            UserDefaults.standard.internalInterfaceStyleString = ""
        }
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
    var appleInterfaceStyle: Appearance.Mode {
        return string(forKey: "AppleInterfaceStyle") == Appearance.Mode.dark.rawValue ? .dark : .light
    }

    var internalInterfaceStylekey: String {
        return "com.disho.Darkness.InternalInterfaceStyle"
    }

    var internalInterfaceStyleString: String? {
        get {
            string(forKey: internalInterfaceStylekey)
        }
        set {
            set(newValue, forKey: internalInterfaceStylekey)
        }
    }
}

