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
            slider.isEnabled = UserDefaults.standard.isAutomaticOnBrightnessSelected
        }
    }

    @IBOutlet private var descriptionTextField: NSTextField! {
        didSet {
            descriptionTextField.textColor = UserDefaults.standard.isAutomaticOnBrightnessSelected ? .labelColor : .secondaryLabelColor
        }
    }

    @IBAction func selectCheckmarkButton(_ sender: NSButton) {
        UserDefaults.standard.isAutomaticOnBrightnessSelected = sender.state == .on
        slider.isEnabled = sender.state == .on
        descriptionTextField.textColor = sender.state == .on ? .labelColor : .secondaryLabelColor
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
}
