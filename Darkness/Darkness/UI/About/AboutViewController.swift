//
//  AboutViewController.swift
//  Darkness
//
//  Created by Joan Disho on 05.11.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Cocoa

class AboutViewController: NSViewController {

    @IBOutlet private var imageView: NSImageView!
    @IBOutlet private var versionNumberTextField: NSTextField!
    @IBOutlet private var copyrightTextField: NSTextField!

    private var copyright: String {
        let year = Calendar.current.component(.year, from: Date())
        if year == 2019 {
             return "© 2019 Joan Disho"
        }
        return "© 2019 - \(year) Joan Disho"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = NSImage.darknessLogo

        if let versionNumber = Bundle.main.versionNumber {
             versionNumberTextField.stringValue = "Version \(versionNumber)"
        }

        copyrightTextField.stringValue = copyright
    }
}

private extension NSImage {
    static var darknessLogo: Self? {
        return Self(named: "darkness.logo")
    }
}
