//
//  ExtensionForAnimation.swift
//  Craft
//
//  Created by castiel on 16/5/28.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension SignUp{

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.bloodBackGroundImage!.layer.removeAllAnimations()
    }

}