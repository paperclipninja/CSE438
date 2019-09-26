//
//  MovObj.swift
//  szeLab4
//
//  Created by arianna sze on 11/27/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import Foundation
import UIKit

struct MovObj{
    var id:Int
    var poster:UIImage
    var title:String
    var year:String
    var rating:String
    var language:String
    var summary:String
    
    init(i:Int,img:UIImage,t:String,yr:String,rate:String,lang:String,summ:String){
        id=i
        poster=img
        title=t
        year=yr
        rating=rate
        language=lang
        summary=summ
    }
    init(){
        self.poster=UIImage();
        self.id=25
        self.title = "nothing here"
        self.year="2017"
        self.rating="too high for you"
        self.language="high elvish"
        self.summary="fart"
    }
    
    init?(dictionary : [String:AnyObject]) {
        //print("attempting init1")
       //print(dictionary["id"] ?? String())
        //print(dictionary)
        guard let i=dictionary["id"] as? Int,  let t=dictionary["title"] as? String else {return nil }
         let y=dictionary["release_date"] as? String
       // print(dictionary["vote_average"])
        let r=dictionary["vote_average"] as? Int
        let k=dictionary["original_language"]
        let s=dictionary["overview"]
        var pic=UIImage()
        if(dictionary["poster_path"] != nil){
        var path=String(describing:dictionary["poster_path"]!)
       // print("path is" + path)
        if path.characters.count>7{
            let imagepath=String("https://image.tmdb.org/t/p/w500"+path)
            //print("imagePath "+imagepath!)
            //code taken from:https://stackoverflow.com/questions/39813497/swift-3-display-image-from-url
            
            let url = URL(string: imagepath!)
            //print("url is "+String(describing:url))
            let data = try? Data(contentsOf: url!)
           // print("Data is "+String(describing:data))
             pic = UIImage(data:data!)!
        }
        }
        self.poster=pic
        self.id=i
        self.title = t
        self.year=y!
        self.rating = String(describing: r!)
        self.language=k as! String
        self.summary=s as! String
    }
    init?(dictionary:[String:String]){
       // print("attempting init2")
        guard let mi = dictionary["id"],let img  = dictionary["poster"], let t = dictionary["title"], let yr = dictionary["year"], let rat=dictionary["rating"], let sum = dictionary["summary"], let langu = dictionary["language"] else { return nil }
        var pic : UIImage
        
        if UIImage.init(data: Data.init(base64Encoded: img, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!) != nil {
            pic = UIImage.init(data: Data.init(base64Encoded: img, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)!
        } else {
            pic = UIImage()
        }
        self.poster=pic
        self.id=Int(mi)!
        self.title = t
        self.year=yr
        self.rating = rat
        self.language=langu
        self.summary=sum

    }
    
    
    func getImage(path : String) -> UIImage{
        //code taken from:https://stackoverflow.com/questions/39813497/swift-3-display-image-from-url
        let url = URL(string: path)
        let data = try? Data(contentsOf: url!)
        return UIImage(data:data!)!
    }
    
    func getId() -> Int {
        return self.id
    }
    func getPoster() -> UIImage {
        return self.poster
    }
    func getTitle() -> String {
        return self.title
    }
    
    func getYear() -> String {
        return self.year
    }
    func getRating() -> String{
        return self.rating
    }
    func getSummary() -> String {
        return self.summary
    }
    func getLanguage() -> String{
        return self.language
    }
    
    var listrep : [String:String] {
        var pic : String
        if let pic2 = (UIImagePNGRepresentation(poster))?.base64EncodedString() {
            pic = pic2
        } else {pic = ""}
        return ["id" : String(describing:Int(id)) , "poster" : pic, "title" : title, "year" : year, "rating" : rating, "language" : language,"summary" : summary]
    }
   }
