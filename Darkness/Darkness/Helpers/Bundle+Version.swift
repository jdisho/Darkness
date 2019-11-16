//
//  Bundle+Version.swift
//  Darkness
//
//  Created by Joan Disho on 16.11.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

extension Bundle {
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildNumber: String? {
      return infoDictionary?["CFBundleVersion"] as? String
    }
}
