//
//  NSView+LoadFromNib.swift
//  Darkness
//
//  Created by Joan Disho on 31.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import AppKit

extension NSView {
    static func loadFromNib() -> Self {
        var topLevelObjects: NSArray?
        let nib = NSNib(nibNamed: String(describing: self), bundle: Bundle(for: self))
        guard
            nib?.instantiate(withOwner: nil, topLevelObjects: &topLevelObjects) == true,
            let view = topLevelObjects?.first(where: { $0 is Self }) as? Self
        else {
            fatalError("Couldn't find nib file for \(self)")
        }
        return view
    }
}

extension NSViewController {
    static func loadFromNib() -> Self {
         return Self(nibName: String(describing: self), bundle: nil)
    }
}
