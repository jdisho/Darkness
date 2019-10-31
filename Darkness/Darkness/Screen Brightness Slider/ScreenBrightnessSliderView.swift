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
            checkmarkButton.state = .off
        }
    }

    @IBOutlet private var slider: NSSlider! {
        didSet {
            slider.isEnabled = checkmarkButton.state == .on
        }
    }

    @IBOutlet private var descriptionTextField: NSTextField! {
        didSet {
            descriptionTextField.textColor = checkmarkButton.state == .on ? .labelColor : .secondaryLabelColor
        }
    }

    @IBAction func selectCheckmarkButton(_ sender: NSButton) {
        slider.isEnabled = sender.state == .on
        descriptionTextField.textColor = sender.state == .on ? .labelColor : .secondaryLabelColor
    }
}
