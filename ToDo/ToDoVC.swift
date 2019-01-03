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
  //  var itemArray = ["Buy Egg","Get Milk","Call Police"]
    //instide of using hard coded array we use this
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newItem = Item()
        newItem.title = "FindeMike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Dragon"
           itemArray.append(newItem2)

        //we Have to call the array that we created in the defult in the startUp
        if let items = UserDefaults.standard.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
        
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
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    //To print what we have selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
       
        //add a cheak mark but if already have a chek mark it will go
    
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
    //The bellow if statment is like the one on top but longer
//       if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
//       {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        }
//        else
//       {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
       
        tableView.reloadData()
        //for the interface
        tableView.deselectRow(at:indexPath, animated: true)

    }
   
//MARK -- ADD new items
    
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        let alerti = UIAlertController(title: "Add New ToDo Item", message: " ", preferredStyle:.alert)
        var textF = UITextField()
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks on add on ur UIAlert
let newItem = Item()
            newItem.title = textF.text!
        //Add the new Item to the array
                self.itemArray.append(newItem)
            //
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
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

