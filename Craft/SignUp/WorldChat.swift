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
        self.background!.alpha = 0.5
        self.addSubview(self.background!)
    }
    
    func changeWorldChatState(completeFrame : CGRect?){
        if !completeState {

            self.background!.hidden = false;
            
            self.background!.frame =  CGRect(x: 0, y: UIAdapter.shared.transferWidth(-60), width: completeFrame!.width , height: completeFrame!.height)
            UIView.animateWithDuration(0.5, animations: {
                    self.frame = completeFrame!
                    self.smallBackground!.alpha = 0.5
                    self.background!.alpha = 1
                
                } ,completion: { (success) in
                    self.smallBackground!.hidden = true;
                })

            
        }else{

            self.smallBackground!.hidden = false;
            
            self.smallBackground!.frame = CGRect(x: 0, y: 0 , width: self.initSize!.width , height: self.initSize!.height)
            UIView.animateWithDuration(0.5, animations: {
                     self.frame = self.initSize!
                     self.background!.alpha = 0.5
                     self.smallBackground!.alpha = 1
                },completion: { (success) in
                     self.background!.hidden = true;
                })
           

            
        }
        self.completeState = !self.completeState
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
