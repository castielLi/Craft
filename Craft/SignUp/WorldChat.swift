//
//  WorldChat.swift
//  Craft
//
//  Created by castiel on 16/6/21.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class WorldChat: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var background : UIImageView?
    var chatView: UITableView?
    var enterText : UITextView?
    var sendButton : UIButton?
    var completeState : Bool = false
    var smallBackground : UIView?
    var initSize : CGRect?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSize = frame
        
        let beffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.smallBackground = UIVisualEffectView(effect: beffect)
        
        smallBackground!.frame = self.bounds
        self.addSubview(self.smallBackground!)
        
        self.background = UIImageView(frame: frame)
        
        let path = NSBundle.mainBundle().pathForResource("worldChatCompleteState", ofType: "png")
        self.background!.image = UIImage(contentsOfFile: path!)
        self.background!.hidden = true
        self.addSubview(self.background!)
    }
    
    func changeWorldChatState(completeFrame : CGRect?){
        if !completeState {
//           self.smallBackground?.removeFromSuperview()
           self.frame = completeFrame!
            self.smallBackground!.hidden = true;
            self.background!.hidden = false;
            self.background!.frame =  CGRect(x: 0, y: 0, width: completeFrame!.width , height: completeFrame!.height)

           
           
        }else{
//           self.background?.removeFromSuperview()
           self.frame = initSize!
            self.smallBackground!.hidden = false;
            self.background!.hidden = true;
            self.smallBackground!.frame = CGRect(x: 0, y: 0, width: initSize!.width , height: initSize!.height)

            
        }
        self.completeState = !self.completeState
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
