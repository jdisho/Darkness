//
//  BrightnessSliderView.swift
//  Darkness
//
//  Created by Joan Disho on 31.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Cocoa
import AppKit

class BrightnessSliderView: NSView {

    @IBOutlet private var checkmarkButton: NSButton! {
        didSet {
            checkmarkButton.state = UserDefaults.standard.isAutomaticOnBrightnessSelected ? .on : .off
            checkmarkButton.isHighlighted = false
            ScreenBrightness.shared.observe { level in
                if UserDefaults.standard.isAutomaticOnBrightnessSelected {
                    Appearance.shared.mode = (level < UserDefaults.standard.brightnessThreshold) ? .dark : .light
                }
            }
        }
    }

    @IBOutlet private var slider: NSSlider! {
        didSet {
            slider.minValue = 0.0
            slider.maxValue = 1.0
            slider.floatValue = UserDefaults.standard.brightnessThreshold
            slider.isEnabled = UserDefaults.standard.isAutomaticOnBrightnessSelected
        }
    }

    @IBOutlet private var descriptionTextField: NSTextField! {
        didSet {
            descriptionTextField.stringValue = updatedDescription(threshold: Int(UserDefaults.standard.brightnessThreshold * 100))
            descriptionTextField.textColor = UserDefaults.standard.isAutomaticOnBrightnessSelected ? .labelColor : .secondaryLabelColor
        }
    }

    func disableAutomaticSwitch() {
        ScreenBrightness.shared.stopObserving()
        UserDefaults.standard.isAutomaticOnBrightnessSelected  = false
        checkmarkButton.state = .off
        slider.isEnabled = false
        descriptionTextField.textColor = .secondaryLabelColor
    }

    @IBAction private func selectCheckmarkButton(_ sender: NSButton) {
        UserDefaults.standard.isAutomaticOnBrightnessSelected = sender.state == .on
        slider.isEnabled = sender.state == .on
        descriptionTextField.textColor = sender.state == .on ? .labelColor : .secondaryLabelColor
        if sender.state == .on  {
            ScreenBrightness.shared.startObserving()
        } else {
            ScreenBrightness.shared.stopObserving()
        }
    }

    @IBAction private func changeSliderValue(_ sender: NSSlider) {
        Appearance.shared.mode = (NSScreen.brightness < sender.floatValue) ? .dark : .light
        UserDefaults.standard.brightnessThreshold = sender.floatValue
        descriptionTextField.stringValue = updatedDescription(threshold: Int(sender.floatValue * 100.0))
    }

    private func updatedDescription(threshold: Int) -> String {
        return """
        The knob represents the brightness threshold.
        Dark mode will be switched on \(threshold)% brightness or less.
        """
    }
}

private extension UserDefaults {
    private var isAutomaticOnBrightnessKey: String {
        return "com.disho.Darkness.isAutomaticOnBrightnessKey"
    }

    var isAutomaticOnBrightnessSelected: Bool {
        get {
            bool(forKey: isAutomaticOnBrightnessKey)
        }
        set {
            setValue(newValue, forKey: isAutomaticOnBrightnessKey)
        }
    }

    private var sliderFloatValueKey: String {
        return "com.disho.Darkness.sliderFloatValueKey"
    }

    var brightnessThreshold: Float {
        get {
            float(forKey: sliderFloatValueKey)
        }
        set {
            setValue(newValue, forKey: sliderFloatValueKey)
        }
    }
}
