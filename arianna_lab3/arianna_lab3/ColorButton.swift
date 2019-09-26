//
//  ColorButton.swift
//  arianna_lab3
//
//  Created by arianna sze on 9/28/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import Foundation
import UIKit
class ColorButtons:UIButton {
    required init(color:UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = color
       // self.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpButton()
    }
    

    func setColor(color:UIColor){
       self.backgroundColor=color
    }
    private func setUpButton(){
    //self.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
    self.layer.cornerRadius = 0.5 * self.bounds.size.width
    self.clipsToBounds = true
    //self.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
  //  view.addSubview(button)
    }
}
