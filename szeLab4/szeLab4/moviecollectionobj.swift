//
//  moviecollectionobj.swift
//  szeLab4
//
//  Created by arianna sze on 11/27/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import Foundation
import UIKit
class moviecollectionobj: UICollectionViewCell{
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var title:UILabel!

    func displayContent(Movie:MovObj){
        moviePoster.image=Movie.getPoster()
        title.text=Movie.getTitle()
    }
}
