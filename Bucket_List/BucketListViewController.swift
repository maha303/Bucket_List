//
//  ViewController.swift
//  Bucket_List
//
//  Created by Maha saad on 09/05/1443 AH.
//

import UIKit



class BucketListViewController: UITableViewController  ,  AddItemTableViewControllerDelegate
{

    var itemsApi : [Task]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  tableView.delegate = self
        
        TaskModel.getAllTasks { data, response, error in
            do{
                self.itemsApi = try JSONDecoder().decode([Task].self, from: data!)
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                       }catch{
                           print(error)
                       }
                   }
        tableView.dataSource = self
        }
        
    func addItemTableViewControllerDelegate(_ controller: AddItemViewController, didFinishAddingItem item: String , at indexPath : NSIndexPath?) {
        if let ip = indexPath {
            
            guard var itema = itemsApi?[ip.row] else {return}
            itema.objective = item
            
            updateTask(object: item, id: itema.id )
            
        }else {
        addTask(item)
           // items.append(item)
       }
        dismiss(animated: true, completion: nil)
              
              tableView.reloadData()
     
    }
    
    func addItemTableViewControllerDelegate(_ controller: AddItemViewController, didPressCancelButton button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsApi?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        cell.textLabel?.text = itemsApi?[indexPath.row].objective
       
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "edit", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        TaskModel.deleteTask(index: itemsApi?[indexPath.row].id ?? 0) { data, response, error in
            do{
                self.itemsApi = try JSONDecoder().decode([Task].self, from: data!)
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                       }catch{
                           print(error)
                       }
        }
        tableView.dataSource = self
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
               let item = itemsApi?[indexpath.row]
               controller.item = item?.objective
               controller.indexpath = indexpath
               
           }
      }
    
    func addTask(_ text : String) {
        
        TaskModel.addTasks(objective: text) { data, response, error in
            print("in here get")
                       
                       // see: Swift nil coalescing operator (double questionmark)
                       print(data ?? "no data get") // the "no data" is a default value to use if data is nil
                       
                       guard let myData = data else { return }
            do{
                self.itemsApi = try JSONDecoder().decode([Task].self, from: myData)
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                       }catch{
                           print(error)
                       }
                   
        }
        tableView.dataSource = self

    }
    
    func updateTask(object : String , id : Int){
        TaskModel.updateTask(index: id, objective: object) { data, response, error in
            guard let myData = data else { return }
            do{
                self.itemsApi = try JSONDecoder().decode([Task].self, from: myData)
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                       }catch{
                           print(error)
                       }
        }
        tableView.dataSource = self
        
    }
}

    
    


