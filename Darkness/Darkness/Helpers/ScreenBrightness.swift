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

    private lazy var oldBrightnessLevel = NSScreen.currentBrightnessLevel

    /// Observe the screen brightness every a given second.
    func observe(every timeInterval: TimeInterval, _ observer: @escaping ((Float) -> Void)) {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(
                timeInterval: timeInterval,
                target: self,
                selector: #selector(self.updateBrightnessLevel),
                userInfo: nil,
                repeats: true
            )
        }
        let observation = Observation(observer: observer)
        observableBrightnessLevel.observe(observation)
    }

    func stopObserving() {
        timer = nil
    }

    @objc private func updateBrightnessLevel(){
        if oldBrightnessLevel != NSScreen.currentBrightnessLevel {
            observableBrightnessLevel.value = NSScreen.currentBrightnessLevel
            oldBrightnessLevel = NSScreen.currentBrightnessLevel
        }
    }
}
