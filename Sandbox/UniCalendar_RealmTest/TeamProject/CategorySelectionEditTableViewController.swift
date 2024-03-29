//
//  CategorySelectionEditTableViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/24.
//

import UIKit

class CategorySelectionEditTableViewController: UITableViewController {
    
    var events = api.callEvent()
    var categories = api.callCategory()
    var selected: Int = 0
    var selectedCategory: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let selectedEventCategoryName = events[selected].parentCategory[0].categoryName
        var count: Int = 0
        for category in categories {
            if category.categoryName == selectedEventCategoryName {
                selectedCategory = count
            }
            count += 1
        }
        self.tableView.selectRow(at: [0, selectedCategory], animated: false, scrollPosition: UITableView.ScrollPosition.none)
        self.tableView.cellForRow(at: [0,selectedCategory])?.accessoryType = .checkmark
    }

    // MARK: - Table view data source

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination
        
        guard let vc = destView as? EventEditTableViewController else {
            return
        }
        
        vc.categoryLabel.text = categories[selectedCategory].categoryName
        vc.selectedCategory = self.selectedCategory
        vc.changedCategory = true
        //vc.selectedCategory = selectedCategory
    }
    
    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeModal(_ sender: Any) {
        performSegue(withIdentifier: "unwindToEventEdit", sender: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "CategorySelectionCell", for: indexPath) as! CategoryCell
        // cell.categoryName.text = categories[indexPath.row].categoryName
        let cell = UITableViewCell()
        
        cell.selectionStyle = .none
        
        cell.textLabel?.text = categories[indexPath.row].categoryName
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedCategory = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
