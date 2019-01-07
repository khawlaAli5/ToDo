//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/6/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
//Init RAM
    let realm = try! Realm()
    //Declare Virabels
    //instide of using hard coded array we use this
    var CategoryArray : Results<Category>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategorys()
    }
    //MARK: - TableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if categoryArray is not nill? then return count otherwise if its nill ?? return 1
        return CategoryArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //the identifier is for the cell it self
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
      
        cell.textLabel?.text = CategoryArray?[indexPath.row].name ?? "NO categories Added yet"
        
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
    
    
    //= Item.fetchRequest is a defult value
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
    
}
