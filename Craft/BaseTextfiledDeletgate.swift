//
//  BaseTextfiledDeletgate.swift
//  MagicDoor
//
//  Created by castiel on 15/9/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation

class BaseTextfiledDeletgate : NSObject , UITextFieldDelegate  {
    
    
    var didEndEditing : (( UITextField )->Void)?
    var shouldEndEditing : (( UITextField )->Void)?
    var shouldRetuen : (( UITextField )->Void)?
    override init(){}
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        var currentTextfiledY = textField.frame.origin.y + textField.frame.height
        NSNotificationCenter.defaultCenter().postNotificationName(UIKeyboardWillShowNotification, object: currentTextfiledY)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        NSNotificationCenter.defaultCenter().postNotificationName(UIKeyboardWillShowNotification, object: nil)
        if didEndEditing != nil{
        self.didEndEditing!(textField)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if shouldRetuen != nil{
            self.shouldRetuen!(textField)
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if shouldEndEditing != nil{
        self.shouldEndEditing!(textField)
        }
        return true
    }
  
}