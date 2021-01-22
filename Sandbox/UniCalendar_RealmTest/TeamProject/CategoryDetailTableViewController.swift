//
//  CategoryDetailTableViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/16.
//

import UIKit
import RealmSwift

class CategoryDetailTableViewController: UITableViewController {
    
    var category = api.callCategory()
    var getImageChange: String = "category_purple"
    
    var categoryIndex: Int = 0
   
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var categoryColor: UIImageView!
    
    @IBAction func completeModal(_ sender: Any) {
        try? api.realm.write(){
            category[categoryIndex].categoryName = categoryNameTextField.text!
            category[categoryIndex].categoryColor =
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoryNameTextField.text = category[categoryIndex].categoryName
        categoryColor.image = UIImage(named: calculateColor(color: category[categoryIndex].categoryColor))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            performSegue(withIdentifier: "windToEditColor", sender: indexPath)
        } else if indexPath.row == 2 {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigation = segue.destination as? UINavigationController else {return}
        
        guard let detail = navigation.viewControllers[0] as? EditColorTableViewController else { return }
        
//        guard let destination: EditColorTableViewController = segue.destination as? EditColorTableViewController else {return}
        guard let colorIndexPath = sender as? IndexPath else {return}
        
        detail.firstColorIndex = colorIndexPath
        //destination.firstColor = category[categoryIndex].categoryColor
    }

    
    func calculateColor(color: Int) -> String{
        switch color {
        case 0:
            return "category_purple"
        case 1:
            return "category_blue"
        case 2:
            return "category_red"
        case 3:
            return "category_yellow"
        case 4:
            return "category_green"
        case 5:
            return "category_orange"
        default:
            return ""
        }
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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
