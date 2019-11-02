//
//  NSScreen+Brightness.swift
//  Darkness
//
//  Created by Joan Disho on 30.10.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation
import Cocoa

extension NSScreen {
    static var brightness: Float {
        var iterator: io_iterator_t = 0
        var level: Float = 0
        if IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"), &iterator) == kIOReturnSuccess {
            IODisplayGetFloatParameter(IOIteratorNext(iterator), 0, kIODisplayBrightnessKey as CFString, &level)
        }
        return level
    }
}
