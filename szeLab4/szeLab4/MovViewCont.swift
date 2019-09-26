//
//  MovViewCont.swift
//  szeLab4
//
//  Created by arianna sze on 11/27/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import UIKit
import Foundation
class MovViewCont: UIViewController {
    
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var sum: UITextView!
    @IBOutlet weak var lang: UILabel!
    @IBOutlet weak var released: UILabel!
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var favButt: UIButton!
    @IBOutlet weak var sharebutt: UIButton!
    
    
    var myMovie = MovObj();
    
    override func viewDidLoad() {
        print("trying...")
        super.viewDidLoad()
        tittle.text = myMovie.getTitle()
        // Do any additional setup after loading the view, typically from a nib.
        released.text = "Release Date:   " + myMovie.getYear()
        //cell.imageView?.image = results[indexPath.row].getPoster()
        print(myMovie.getPoster())
        poster.image = myMovie.getPoster()
        sum.text = myMovie.getSummary()
        lang.text = "Language: " + myMovie.getLanguage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func favClick(_ sender: UIButton) {
        var favorites : [MovObj] = []
        print("clicked and adding")
        if let faves=UserDefaults.standard.object(forKey: "fav") as? [[String:String]]{
            print("iff works")
           // print(faves)
            favorites=faves.flatMap{MovObj(dictionary: $0 )}
           // print(favorites)
        }
        print(favorites.count)
        favorites.append(myMovie)
        //print(favorites.count)
        let faves=favorites.map{ $0.listrep}
       // print("favescount ")
        //print(faves.count)
        UserDefaults.standard.set(faves, forKey: "fav")
        //print("user defaults")
        //print("\(UserDefaults.standard.value(forKey: "fav")!)")
        
    }

    @IBAction func shareClick(_ sender: UIButton) {
        //referenced: https://stackoverflow.com/questions/35931946/basic-example-for-sharing-text-or-image-with-uiactivityviewcontroller-in-swift
     
            // image to share
            let image = myMovie.getPoster()
            
            // set up activity view controller
            let imageToShare = [ image ]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func tappedImage(_ sender: Any) {
        //reference https://stackoverflow.com/questions/34694377/swift-how-can-i-make-an-image-full-screen-when-clicked-and-then-original-size
        let fullScreenedImage = UIImageView(image: myMovie.getPoster())
        fullScreenedImage.frame = UIScreen.main.bounds
        fullScreenedImage.backgroundColor = UIColor.black
        fullScreenedImage.contentMode = .scaleAspectFit
        fullScreenedImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(MovViewCont.dismissFullscreenImage(_:)))
        fullScreenedImage.addGestureRecognizer(tap)
        self.view.addSubview(fullScreenedImage)
    }
    //referenced https://stackoverflow.com/questions/25477547/how-can-i-create-a-hyperlink-with-swift
    @IBAction func youtubeSearch(_ sender: UIButton) {
        var youtube="https://www.youtube.com/results?search_query="
        
        let title = myMovie.title.replacingOccurrences(of:" ",with:"%20", options: .literal,range:nil)
        youtube=youtube+title

        let url = URL(string:(youtube))
         UIApplication.shared.openURL(url!)
    }
    
    
    
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {sender.view?.removeFromSuperview()}
}

