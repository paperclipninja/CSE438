//
//  Functions.swift
//  arianna_lab3
//
//  Created by arianna sze on 9/28/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import Foundation
import UIKit

class Functions {
    
    func distance(a: CGPoint, b: CGPoint) -> CGFloat {
        return sqrt(pow(a.x - b.x,2) + pow(a.y - b.y,2))
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        let xval=(first.x+second.x)/2
        let yval=(first.y+second.y)/2
        let midpt=CGPoint(x:xval, y:yval)
        return midpt
        
        
    }
    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }

    
}
