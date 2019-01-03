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
    //instide of using hard coded array we use this
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
  print(dataFilePath)
        
        loadItems()
        
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
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    //To print what we have selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
       
        //--add a cheak mark but if already have a chek mark it will go
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItem()
        //--for the interface
        tableView.deselectRow(at:indexPath, animated: true)

    }
   
    //MARK:ADD new items
    
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        let alerti = UIAlertController(title: "Add New ToDo Item", message: " ", preferredStyle:.alert)
        var textF = UITextField()
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks on add on ur UIAlert
let newItem = Item()
            newItem.title = textF.text!
            
        //Add the new Item to the array
                self.itemArray.append(newItem)
            //call the save function
                  self.saveItem()
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
    
    
    
    
    
    
    
    
    
    //MARK:FUNCTIONS
    
    
    func saveItem() {
        
        let encoder = PropertyListEncoder()
                    do{
                        let data = try encoder.encode(itemArray)
                        try  data.write(to: dataFilePath!)
                    }
                    catch
                    {
                      print("Error encoding item array, \(error)")
                    }
        
                    //We have to reload data so that it can show in the cell
                    tableView.reloadData()
        print(dataFilePath!)

    }
    
    func loadItems(){
        //decode to save the data so that it is never lost
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("Error decoding item array, \(error)")
            }
            
        }
    }
    

}

