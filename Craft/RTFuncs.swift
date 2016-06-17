//
//  RTFuncs.swift
//  Craft
//
//  Created by Rex Tsao on 13/6/2016.
//  Copyright © 2016 castiel. All rights reserved.
//

import Foundation

/// Convert width for current device via UIAdapter.
func uiat(num: CGFloat) -> CGFloat {
    return UIAdapter.shared.transferWidth(num)
}


/// Convert height for current device via UIAdapter.
func uiah(num: CGFloat) -> CGFloat {
    return UIAdapter.shared.transferHeight(num)
}