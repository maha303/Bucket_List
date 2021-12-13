//
//  ViewController.swift
//  Bucket_List
//
//  Created by Maha saad on 09/05/1443 AH.
//

import UIKit

class BucketListViewController: UITableViewController ,  AddItemTableViewControllerDelegate {
 
    
    func addItemTableViewControllerDelegate(_ controller: AddItemViewController, didFinishAddingItem item: String , at indexPath : NSIndexPath?) {
        if let ip = indexPath {
            items[ip.row] = item
        }else {
            items.append(item)
        }
        dismiss(animated: true, completion: nil)
              
               tableView.reloadData()
     
    }
    
    func addItemTableViewControllerDelegate(_ controller: AddItemViewController, didPressCancelButton button: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
   
    
    var items = ["Sky diving", "Live in Hawaii"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        cell.textLabel?.text = items[indexPath.row]
       
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "edit", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         //  if segue.identifier == "AddNewMission"
        if sender is UIBarButtonItem {
               let navigationController = segue.destination as! UINavigationController
               let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
               
               
           }else if sender is IndexPath
            //segue.identifier == "edit"
        {
               
               let navigationController = segue.destination as! UINavigationController
               let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
               let indexpath = sender as! NSIndexPath
               let item = items[indexpath.row]
               controller.item = item
               controller.indexpath = indexpath
               
           }
      }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

