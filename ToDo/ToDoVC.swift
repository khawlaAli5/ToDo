//
//  ViewController.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/2/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import UIKit

class ToDoVC: UITableViewController {

    //Declare Virabels
    var itemArray = ["Buy Egg","Get Milk","Call Police"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //TableView Source Methods(2)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //TODO: Declare cellForRowAtIndexPath here:

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //the identifier is for the cell it self
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    //To print what we have selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        //for the interface
        tableView.deselectRow(at:indexPath, animated: true)
        //add a cheak mark but if already have a chek mark it will go
      
        
       if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
       {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
        }
        else
       {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
       


    }
   
//MARK -- ADD new items
    
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        let alerti = UIAlertController(title: "Add New ToDo Item", message: " ", preferredStyle:.alert)
        var textF = UITextField()
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks on add on ur UIAlert
            print("Sucsess")
           
        //Add the new Item to the array
                self.itemArray.append(textF.text!)
            
            //We have to reload data so that it can show in the cell
            self.tableView.reloadData()
            //print(self.itemArray)
          
        }
        
        alerti.addAction(action)
     //create a text felid inside the alter
        alerti.addTextField { (addTextF) in
            addTextF.placeholder = "Create New Item"
            textF = addTextF
        }
        
        //present the alert
        present(alerti, animated: true, completion: nil)
        
    }
    

}

