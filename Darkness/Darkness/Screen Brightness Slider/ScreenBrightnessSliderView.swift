//
//  ScreenBrightnessSliderView.swift
//  Darkness
//
//  Created by Joan Disho on 31.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Cocoa
import AppKit

class ScreenBrightnessSliderView: NSView {

    @IBOutlet private var checkmarkButton: NSButton! {
        didSet {
            checkmarkButton.state = UserDefaults.standard.isAutomaticOnBrightnessSelected ? .on : .off
        }
    }

    @IBOutlet private var slider: NSSlider! {
        didSet {
            slider.floatValue = UserDefaults.standard.brightnessThreshold
            slider.isEnabled = UserDefaults.standard.isAutomaticOnBrightnessSelected
        }
    }

    @IBOutlet private var descriptionTextField: NSTextField! {
        didSet {
            descriptionTextField.stringValue = updatedDescription(brightnessLevel: Int(UserDefaults.standard.brightnessThreshold))
            descriptionTextField.textColor = UserDefaults.standard.isAutomaticOnBrightnessSelected ? .labelColor : .secondaryLabelColor
        }
    }

    @IBAction func selectCheckmarkButton(_ sender: NSButton) {
        UserDefaults.standard.isAutomaticOnBrightnessSelected = sender.state == .on
        slider.isEnabled = sender.state == .on
        descriptionTextField.textColor = sender.state == .on ? .labelColor : .secondaryLabelColor
    }

    @IBAction func changeSliderValue(_ sender: NSSlider) {
        UserDefaults.standard.brightnessThreshold = sender.floatValue.rounded()
        descriptionTextField.stringValue = updatedDescription(brightnessLevel: Int(sender.intValue))
    }

    private func updatedDescription(brightnessLevel: Int) -> String {
        return """
        The knob represents the brightness threshold.
        Dark mode will be switched on \(brightnessLevel)% brightness or less.
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
