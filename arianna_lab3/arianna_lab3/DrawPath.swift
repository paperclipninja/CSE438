//
//  DrawPath.swift
//  arianna_lab3
//
//  Created by arianna sze on 10/2/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import Foundation
import UIKit

class DrawPath:UIBezierPath {
    var path:UIBezierPath!
    var width:CGFloat!
    var color: UIColor!
    var points: [CGPoint]
    var funcs = Functions()
    var count = 0
    var previousView:CAShapeLayer!

    init(pointArr: [CGPoint], widt:CGFloat,col:UIColor) {
        previousView = CAShapeLayer()
        
        points = pointArr
        path = funcs.createQuadPath(points: points)
        width=widt
        color=col
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePoints(pointArr:[CGPoint])
    {
        points = pointArr
        path = funcs.createQuadPath(points: points)
    }



    func drawLine( inView view: UIView){
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = self.path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = self.color.cgColor
        shapeLayer.lineWidth = self.width
        
        previousView.removeFromSuperlayer()
        previousView=shapeLayer
        

        view.layer.addSublayer(shapeLayer)


    
}
}

 
