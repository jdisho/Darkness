//
//  NSView+LoadFromNib.swift
//  Darkness
//
//  Created by Joan Disho on 31.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import AppKit

extension NSView {
    static func loadFromNib() -> NSView {
        var topLevelObjects: NSArray?
        let nib = NSNib(nibNamed: String(describing: self), bundle: Bundle(for: self))
        guard
            nib?.instantiate(withOwner: nil, topLevelObjects: &topLevelObjects) == true,
            let view = topLevelObjects?.first(where: { $0 is NSView }) as? NSView
        else {
            fatalError("Couldn't find nib file for \(self)")
        }
        return view
    }
}
