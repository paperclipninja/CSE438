//
//  searchCollectionV.swift
//  szeLab4
//
//  Created by arianna sze on 11/27/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import Foundation
import UIKit
class searchCollectionView: UICollectionViewController, UISearchBarDelegate{
  //  @IBOutlet var collectionView: UICollectionView!
   let cellIdentifier = "cell"
    @IBOutlet weak var searchbar: UISearchBar!
    
    typealias qr = ([MovObj]?,String) ->()
    var results:[MovObj]=[]
    var dataTask : URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate=self
      //  tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        title = "search bar"
        getData(search:"hi")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberofItems:Int)-> Int{
        return results.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:IndexPath)->UICollectionViewCell{
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! moviecollectionobj
        cell.displayContent(Movie: results[indexPath.row])
        return cell
        
    }
    func getData(search: String){
        //print("getting data")
        //sleep(5)
        let format = search.replacingOccurrences(of:" ",with:"%20", options: .literal,range:nil)
        let path = "https://api.themoviedb.org/3/search/movie?api_key=d04740d38f4dd6f1277cccef358aee61&language=en-US&query=\(format)"
        
        let url = URL(string:path)
        if url != nil {
            
            do{
                let data = try Data(contentsOf: url!)
                
                //  print(data)
                let obj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                
                // print(obj)
                if let dictionary = obj as? [String: AnyObject] {
                    let movieList = dictionary["results"] as? [[String:AnyObject]]
                    
                    // dispatchQueue.async(){
                    
                    for movie in movieList!{
                        //print("attempting...")
                        //print(movie)
                        //print("movie obj is:")
                        let mvo=MovObj(dictionary: movie)
                        // print(mvo?.getTitle())
                        self.results.append(mvo!)
                    }  //  }
                    //
                }
            }catch {self.searchbar.text = "Bad search"}}
       // self.activityIndcatorView.stopAnimating()
        //self.tableView.reloadData()
        // print(results)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            searchbar.text=""
            results.removeAll()
          //  self.tableView.reloadData()
        }
    }

    
}
/*
 func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
 
 if let searchText = searchBar.text {
 if (!(searchText.isEmpty)) {
 self.results.removeAll()
 self.tableView.reloadData()
 self.getData(search: searchText)
 } else {
 self.results.removeAll()
 }
 } else {
 self.results.removeAll()
 }
 
 self.tableView.reloadData()
 }
 
 
 
 
 
class SearchViewController: UITableViewController, UISearchBarDelegate {

 
 
 
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        

    }

    // override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieselected", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = results[indexPath.row].getTitle()
        cell.imageView?.image = results[indexPath.row].getPoster()
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  print("attempting segue")
        // print( segue.identifier!)
        if segue.identifier! == "movieselected" {
            //print("identified!")
            if let indexPath = tableView.indexPathForSelectedRow, let movie = results[indexPath.row] as? MovObj  {
                //print("inside iff")
                //print(movie)
                let destination = segue.destination as! MovViewCont
                destination.myMovie = movie
            }
        }
        
    }
    
    
    
}*/
