//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/6/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
//Init RAM
    let realm = try! Realm()
    //Declare Virabels
    //instide of using hard coded array we use this
    var CategoryArray : Results<Category>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategorys()
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        tableView.rowHeight = 80.0
        
        //remove sepretore between cells
        tableView.separatorStyle = .none
    }
    //MARK: - TableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if categoryArray is not nill? then return count otherwise if its nill ?? return 1
        return CategoryArray?.count ?? 1
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //the identifier is for the cell it self
        //Call The cell from the swipeTableView Class
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = CategoryArray?[indexPath.row]{
            cell.textLabel?.text = category.name
            guard let categoryColour = UIColor(hexString: category.color!) else {fatalError()}
            
            cell.backgroundColor = categoryColour
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        }
      
    
        
       
        
        
       
        
        return cell
        
    }
    
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch
        {
            print("Error Saving context, \(error)")
        }
        
        //We have to reload data so that it can show in the cell
    tableView.reloadData()
        
    }
    
    //Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
                        if let categoryForDeletion = self.CategoryArray?[indexPath.row]{
                            do{
                                try self.realm.write {
                                    self.realm.delete(categoryForDeletion)
                                }
        
                            }
                            catch
                            {
                                print("Error Deleting cell \(error)")
                            }
        
        
                        }
    }

    func loadCategorys(){
        
         CategoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    
    
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alerti = UIAlertController(title: "Add New ToDo Category", message: " ", preferredStyle:.alert)
        var textF = UITextField()
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen when the user clicks on add on ur UIAlert
            
            let newCatogery = Category()
            newCatogery.name = textF.text!
            newCatogery.color = UIColor.init(randomFlatColorOf: UIShadeStyle.dark).hexValue()
            //NO NEED FOR APEENDED becuase its auto update
            //call the save function
            self.save(category: newCatogery)
    }
        alerti.addAction(action)
        
        
        //create a text felid inside the alter
        alerti.addTextField { (addTextF) in
            addTextF.placeholder = "Create New Catogery"
            textF = addTextF
        }
        
        //present the alert
        present(alerti, animated: true, completion: nil)
        
    }
    
    
    
    //MARK:FUNCTIONS
    
    
   
  
    
    //MARK: - TableView Delegate Methods
    //To print what we have selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToItem", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = CategoryArray?[indexPath.row]
            
        }
    }
    
}//END

