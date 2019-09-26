//
//  ViewController.swift
//  arianna_lab3
//overriding the touchesBegan, touchesMoved, and touchesEnded functions
//  Created by arianna sze on 9/28/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var shrButt: UIButton!
    @IBOutlet weak var widthSlider: UISlider!
    var drView: DrawingView!
    var numLines = 0;
    @IBOutlet weak var yellow: ColorButtons!
    @IBOutlet weak var blue: ColorButtons!
    @IBOutlet weak var orange: ColorButtons!
    @IBOutlet weak var green: ColorButtons!
    @IBOutlet weak var undoButt: UIButton!
    @IBOutlet weak var saveImg: UIButton!
    //add slider for line weight
    //add sharing function for extra thing
    @IBOutlet weak var clear: UIButton!
    var lineWeight:CGFloat!
    var color:UIColor!
    var functhing:Functions!
   // var lins:[DrawPath]!
    var currentPath:[CGPoint]!
    
    
    @IBOutlet weak var red: ColorButtons!
    override func viewDidLoad() {
        currentPath=[CGPoint]()
        widthSlider.maximumValue=20
        widthSlider.minimumValue=1
        widthSlider.value=10
        //lines=[DrawPath]()
        lineWeight = 10
        color = UIColor.red
        functhing = Functions()
        red.setColor(color: UIColor.red)
        green.setColor(color: UIColor.green)
        blue.setColor(color: UIColor.blue)
        yellow.setColor(color: UIColor.yellow)
        orange.setColor(color: UIColor.orange)
        drView = DrawingView(frame: self.view.frame)
        view.addSubview(drView)
        view.sendSubview(toBack: drView)

        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func widthChange(_ sender: UISlider) {
        lineWeight=CGFloat(widthSlider.value)
    }
   
 
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         numLines=numLines+1;
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        currentPath.append(touchPoint)
        drView.points.append(touchPoint)
       // drView.theLine = functhing.createQuadPath(points: currentPath)
      //  drView.theLine.updatePoints(pointArr:currentPath)
        print("point is \(touchPoint)")
        print("color is\(color)")
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //add real time drawing
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        //print(currentPath)
        currentPath.append(touchPoint)
        drView.points.append(touchPoint)
        drView.theLine?.updatePoints(pointArr: drView.points)
        let pat = DrawPath(pointArr: drView.points, widt: lineWeight, col: color)
        drView.theLine=pat
        /*guard let sublayers = drView.layer.sublayers else { return }
        //for layer in sublayers {
        if sublayers.count>0{
        for index in numLines...(sublayers.count){
        sublayers[index].removeFromSuperlayer()
        }
        }*/
        view.setNeedsDisplay()
       // drView.theLine.path = functhing.createQuadPath(points: currentPath)
        // let distance = Functions.distance(a: touchPoint, b: (currentCircle?.center)!)
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touchPoint = (touches.first)!.location(in: view) as CGPoint
       

        if functhing.distance(a: touchPoint, b: currentPath.last!)<1 {
            drView.drawCircle(xpoint: touchPoint)
            
            view.setNeedsDisplay()
            drView.theLine=nil
        }
       else{
            let pat = DrawPath(pointArr: drView.points, widt: lineWeight, col: color)
            currentPath.append(touchPoint)
            drView.points.append(touchPoint)
            drView.theLine?.updatePoints(pointArr: drView.points)
        drView.lines.append(pat)
        //print(drView.lines)

            guard var sublayers = drView.layer.sublayers else { return }
            print("Num sublayers is...",sublayers.count)
            //for layer in sublayers {
            for index in (numLines)...(sublayers.count-1){
                sublayers[numLines].removeFromSuperlayer()
                sublayers.remove(at: numLines)
                //print("removing")
            }
            print("num sublayers after is...",drView.layer.sublayers?.count)
        }
        currentPath.removeAll()
        drView.points.removeAll()
           // guard var sublayers = drView.layer.sublayers else { return }
            //for layer in sublayers {

    }
   /* func updateDisplay(){
        for pat in lines{
            print("drawingline")
              drawLine(path: pat.path, ofColor: pat.color, widthOfLine: 3, inView: view)
    }
    }*/
    /*
    @IBAction func undoDraw(_ sender: UIButton) {
        numLines = numLines-1
        print("undo draw, number of lines is ",numLines)
      /*  if !drView.lines.isEmpty{
            //print(lines)*/
            drView.lines.popLast()
        guard var sublayers = drView.layer.sublayers else { return }
        if numLines==0{
           // print("no lines")

            for layer in sublayers {
           //     print("removing...")
                layer.removeFromSuperlayer()
                drView.lines=[]
            }
            sublayers.removeAll()
            view.setNeedsDisplay()
        }
        
        else{
            print("removing lines")
            var layer=sublayers.popLast()
            layer?.removeFromSuperlayer()
           // sublayers.remove(at: numLines)
           // drView.lines.remove(at: numLines)
            print("num in lines",drView.lines.count)
            //drView.lines.remove(at:drView.lines.count-1)
          //  print("num 2in lines",drView.lines.count)
        }
      //  drView.theLine = nil

        
        drView.setNeedsDisplay()
    } */
    
    
    @IBAction func clearLines(_ sender: Any) {
        drView.theLine = nil
        drView.lines = []
       guard var sublayers = drView.layer.sublayers else { return }
        
        for layer in sublayers {
            layer.removeFromSuperlayer()
        }
        sublayers.removeAll()
        numLines=0
        drView.lines.removeAll()
        view.setNeedsDisplay()
    }

    
    @IBAction func yellowButt(_ sender: ColorButtons) {
        color = sender.backgroundColor
    }
    
    @IBAction func orangeButt(_ sender: ColorButtons) {
        color=sender.backgroundColor
    }

    @IBAction func blueButt(_ sender: ColorButtons) {
        color=sender.backgroundColor
    }
    @IBAction func greenButt(_ sender: ColorButtons) {
        color=sender.backgroundColor
    }
    @IBAction func redButt(_ sender: ColorButtons) {
        color=sender.backgroundColor
    }

    @IBAction func savepic(_ sender: UIButton) {
        //referenced https://stackoverflow.com/questions/27965224/taking-screenshot-from-part-of-screen-in-swift
        UIGraphicsBeginImageContext(view.frame.size)
        drView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageToBeSaved = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(imageToBeSaved!, nil, nil, nil);
    }


    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
         clearLines(motion)
        }
    }

    @IBAction func shareImg(_ sender: UIButton) {
        UIGraphicsBeginImageContext(view.frame.size)
        drView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let avc = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        /*avc.popoverPresentationController?.sourceView = self.view
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        */
        // present the view controller
        self.present(avc, animated: true, completion: nil)
    }
    

}

