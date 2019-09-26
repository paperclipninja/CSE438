//
//  SecondViewController.swift
//  szeLab4
//
//  Created by arianna sze on 11/27/17.
//  Copyright © 2017 Sze. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {
    var favlist : [MovObj]=[MovObj()]

    @IBOutlet weak var edit: UIButton!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.delegate = self
       // tableView.dataSource = self
        
      
        //print("view loaded")
        title="fav"
        if let favorites = UserDefaults.standard.object(forKey: "fav") as? [[String:String]]{
            favlist=favorites.flatMap{MovObj(dictionary: $0)}
            print("iff")
        }
       // print("favlist has: ")
        //print(favlist.count)
        //print(favlist[0].title)
       // print(favlist)
        //print("list is ")
        //print("\(UserDefaults.standard.value(forKey: "fav")!)")
        updateTable()
        let favorites = favlist.map{ $0.listrep}
        //print(favorites)
        UserDefaults.standard.setValue(favorites, forKey: "fav")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cellM")
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    func updateTable() {
        print("updating..")
        if let favorites=UserDefaults.standard.object(forKey: "fav") as? [[String:String]] {
            favlist=favorites.flatMap{ MovObj(dictionary: $0) }
        }
        
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        print("view appeared")
        updateTable()
        //tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete){
            favlist.remove(at: indexPath.row)
            let f=favlist.map{ $0.listrep }
            UserDefaults.standard.setValue(f, forKey: "fav")
            tableView.reloadData()
        }
        tableView.setEditing(false, animated:true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favlist.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favselected" {
            
            if let indexPath = tableView.indexPathForSelectedRow, let movie = favlist[indexPath.row] as? MovObj  {
                let destination = segue.destination as! MovViewCont
                destination.myMovie = movie
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favselected", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //ref https://stackoverflow.com/questions/32628114/swift-tableview-in-a-uiview-not-displaying-data
    
/*func tableView(_tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellM", for:indexPath as IndexPath)
        
        cell.textLabel?.text = favlist[indexPath.row].getTitle()
        cell.imageView?.image = favlist[indexPath.row].getPoster()
        
        return cell
    }*/
    @IBAction func editPress(_ sender: UIButton) {
        if(tableView.isEditing){
            tableView.setEditing(false,animated:true)
        }
        else{
            tableView.setEditing(true, animated:true)}
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellM")!
        //let object = favlist[indexPath.row]
        cell.textLabel!.text = favlist[indexPath.row].getTitle()
        cell.imageView?.image = favlist[indexPath.row].getPoster()
        return cell
    }

    

}

