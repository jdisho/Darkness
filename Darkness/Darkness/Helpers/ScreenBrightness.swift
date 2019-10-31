//
//  ScreenBrightness.swift
//  Darkness
//
//  Created by Joan Disho on 30.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

class ScreenBrightness {

    static let shared = ScreenBrightness()

    private let observableBrightnessLevel = Observable<Float>(NSScreen.currentBrightnessLevel)
    private var timer: Timer? = nil {
        willSet {
            timer?.invalidate()
        }
    }

    /// Observe the screen brightness every a 1 second.
    func observe(_ observer: @escaping ((Float) -> Void)) {
        startObserving()
        let observation = Observation(observer: observer)
        observableBrightnessLevel.observe(observation)
    }

    func startObserving() {
        stopObserving()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(self.updateBrightnessLevel),
                userInfo: nil,
                repeats: true
            )
        }
    }

    func stopObserving() {
        timer = nil
    }

    @objc private func updateBrightnessLevel(){
        observableBrightnessLevel.value = NSScreen.currentBrightnessLevel
    }
}
