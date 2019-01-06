//
//  ViewController.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/2/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import UIKit
import CoreData

class ToDoVC: UITableViewController {

    //Declare Virabels
    //instide of using hard coded array we use this
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
    }

  
    //MARK: -TableView Source Methods(2)
    
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
        
       //--Delet a row
      //  context.delete(itemArray[indexPath.row])
      //  itemArray.remove(at: indexPath.row)
       
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
    
            let newItem = Item(context: self.context)
            newItem.title = textF.text!
            newItem.done = false
            
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
                    do{
                        try context.save()
                    }
                    catch
                    {
                      print("Error Saving context, \(error)")
                    }
        
                    //We have to reload data so that it can show in the cell
                    tableView.reloadData()

    }
    //= Item.fetchRequest is a defult value
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest()){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
            do{
itemArray = try context.fetch(request)
            }
            catch{
             print("Error fetching data from context \(error)")
            }
        self.tableView.reloadData()

        }
    }







//MARK: - SearchBar Methods

extension ToDoVC : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format:"title CONTAINS[cd] %@",searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
           
        }
    }
    
    
    }





