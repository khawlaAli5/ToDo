//
//  ViewController.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/2/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToDoVC: SwipeTableViewController {

    //Declare Virabels
    //instide of using hard coded array we use this
    var todoItems:Results<Item>?
    // var CategoryArray : Results<Category>!
    //WE have to use this for Realm
    let realm = try! Realm()
    
    @IBOutlet weak var SearchBB: UISearchBar!
    
    var selectedCategory : Category?{
        didSet{
          //if we have a catogery we do load items
          loadItems()
            
        }
    }
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
     tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
             title = "\(self.selectedCategory!.name)"
       //WE USE guard instide of If statment because we have no else return and ite better
        guard let colourHex = selectedCategory?.color else { fatalError()}
        UpdtaeNavBar(withHexCode: colourHex)
            }
    
    override func viewWillDisappear(_ animated: Bool) {
      UpdtaeNavBar(withHexCode: FlatWhite().hexValue())
    }
    
    //MARK: -Nav Bar Setup Methods
    func UpdtaeNavBar(withHexCode colourHexCode :String){
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navagtion controller dose not exist")}
        
        
        guard let navBarColour = UIColor(hexString: colourHexCode) else {fatalError()}
        
        navBar.barTintColor = navBarColour
        
        navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
        
        SearchBB.barTintColor = navBarColour
        
        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:ContrastColorOf(navBarColour, returnFlat: true)]
    }
            
    


  
    //MARK: -TableView Source Methods(2)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ??  1
    }
    
    
    
    //TODO: Declare cellForRowAtIndexPath here:

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //the identifier is for the cell it self
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let Categorycolor = self.selectedCategory?.color
        
       if let item = todoItems?[indexPath.row]
       {
        cell.textLabel?.text = item.title
        if let color = UIColor(hexString: Categorycolor!)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            
        }
        
       
        //print(Categorycolor)
        cell.accessoryType = item.done ? .checkmark : .none
        
        }else
       {
        cell.textLabel?.text = "No Items Added"
        }
                 return cell
       
    }
    //To print what we have selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            do {
            try realm.write {
                
               // realm.delete(item)
               item.done = !item.done
            }
            }catch{
                print("Error saving done status \(error)")
            }
            
        }
        self.tableView.reloadData()

        
        //--for the interface
        tableView.deselectRow(at:indexPath, animated: true)

    }
    
    
    //MARK:
    //Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        if let ItemForDelection = self.todoItems?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(ItemForDelection)
                }
                
            }
            catch
            {
                print("Error Deleting cell \(error)")
            }
            
            
        }
    }
    
   
    //MARK:ADD new items
    
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        let alerti = UIAlertController(title: "Add New ToDo Item", message: " ", preferredStyle:.alert)
        var textF = UITextField()
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks on add on ur UIAlert

            if let currentCategory = self.selectedCategory{
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textF.text!
                        newItem.dateCreated = Date()
                        
                        //newItem.done = false
                        currentCategory.items.append(newItem)
                    }
                }catch
                {
                    print("Error Saving context, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        
        //create a text felid inside the alter
        alerti.addTextField { (addTextF) in
            addTextF.placeholder = "Create New Item"
            textF = addTextF
        }
        
        alerti.addAction(action)
        //present the alert
        present(alerti, animated: true, completion: nil)
        
    }
    
    //MARK:FUNCTIONS
 
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    }




//END of our CLASS!
    
}





//MARK: - SearchBar Methods

extension ToDoVC : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
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





