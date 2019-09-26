//
//  DrawingView.swift
//  arianna_lab3
//
//  Created by arianna sze on 10/4/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import Foundation


import UIKit

class DrawingView: UIView {
    
    var functhing = Functions();
    var theLine:DrawPath? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lines:[DrawPath] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var arcCenter = CGPoint.zero
    var arcRadius = CGFloat()
    var points = [CGPoint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code

        for line in lines {
            if(line.points.count>1){
            drawLine(line)
           // line.
            line.drawLine(inView: self)
            }
        }
        if(theLine != nil){
            drawLine(theLine!)
            theLine?.drawLine(inView: self)
            //drawCircle(theLine!)
        }
    }
    
    func drawLine(_ path: DrawPath) {
        //NOT WORKING FOR SOME REASON
        UIColor.clear.setFill();

        path.fill()
        path.color.setStroke()
        path.stroke()
        
        
        
    }
    
    func updateLine(currentPath:DrawPath, nextPt:CGPoint){
        //arcCenter = center
        //arcRadius = radius
        points.append(nextPt)
        currentPath.updatePoints(pointArr: points)
        //currentPath.append(newPath)
        //rint("update center: \(center) and radius \(radius)")
        
        setNeedsDisplay()
        
    }
    
    func drawCircle(xpoint:CGPoint) {
        
        theLine?.color.setFill()
        let path = UIBezierPath()
        
        path.addArc(withCenter: xpoint, radius: (theLine?.width)!/2    , startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        
        path.fill()
        path.stroke()
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = path.cgPath
        let col=theLine?.color.cgColor
        shapeLayer.fillColor = col
        //shapeLayer.strokeColor = theLine?.color as! CGColor
        shapeLayer.lineWidth = 0.1
        
        lines.append(DrawPath(pointArr: [xpoint], widt: (theLine?.width)!, col: (theLine?.color)!))
        
        self.layer.addSublayer(shapeLayer)

        
        
    }

    
    
}
