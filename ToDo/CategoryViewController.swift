//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Khawla Alsharqi on 1/6/19.
//  Copyright © 2019 Khawla Alsharqi. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    //Declare Virabels
    //instide of using hard coded array we use this
    var CategoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategorys()
    }
    //MARK: - TableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //the identifier is for the cell it self
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = CategoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
    
    //MARK: - Data Manipulation Methods
    func saveCategory() {
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
    func loadCategorys(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            CategoryArray = try context.fetch(request)
        }
        catch{
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
        
    }
    
    
    
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alerti = UIAlertController(title: "Add New ToDo Category", message: " ", preferredStyle:.alert)
        var textF = UITextField()
        let action = UIAlertAction(title: "Add Catogery", style: .default) { (action) in
            //what will happen when the user clicks on add on ur UIAlert
            
            let newCatogery = Category(context: self.context)
            newCatogery.name = textF.text!
            
            //Add the new Item to the array
            self.CategoryArray.append(newCatogery)
            //call the save function
            self.saveCategory()
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
            destinationVC.selectedCategory = CategoryArray[indexPath.row]
            
        }
    }
    
}
