//
//  TomorrowTaskTableViewController.swift
//  BeyondList
//
//  Created by 07elenazheng-@naver.com on 4/6/22.
//

import UIKit
import Parse

class TomorrowTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
     @IBOutlet weak var tomorrowTaskTableView: UITableView!
     var tasks = [PFObject]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tomorrowTaskTableView.delegate = self
        tomorrowTaskTableView.dataSource = self
        tomorrowTaskTableView.rowHeight = 120
        
      //  self.tomorrowTaskTableView.isEditing = true //1. enable the editing mode for the UITableView

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Tasks")
        query.includeKey("author")// should a tomorrow column be created for Tomorrow task display?
        query.limit = 10
        
        query.findObjectsInBackground{(tasks, error) in
            if tasks != nil {
                self.tasks = tasks!
                self.tomorrowTaskTableView.reloadData()
            }
        }
    

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tomorrowTaskTableView.dequeueReusableCell(withIdentifier: "TaskViewCell") as! TaskViewCell
        let task = tasks[indexPath.row]
        cell.taskNameLabel.text = task["name"] as! String
        cell.taskObjectId = task.objectId as! String
        cell.roundedView.layer.cornerRadius = cell .roundedView.frame.height / 8
        
        return cell
    }
  /*
    //2. Disable the buttons by implementing these UITableViewDataSource methods
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // 3 Enable the reorder control to move cells by overwriting tableView:moveRowAtIndexPath: and implement the method so that the elements in the underlying data list are updated
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
         let movedObject = self.tasks[sourceIndexPath.row]
         tasks.remove(at: sourceIndexPath.row)
         tasks.insert(movedObject, at: destinationIndexPath.row)
     }
*/
    
    private func handleMoveToDump() {
        print("Moved to dump.")// Not done item which would be saved and displayed in Dump.
    }
    
    private func handleMoveToTrash() {
        print("Moved to trash.")// Delete item. Can be cambined with Mark delete fuction.
    }
    
    private func handleMarkAsEdit(){
        print("Edited task.")
    }
    
    private func handleMarkAsDone() {
        print("Done task.")// Save done task(to dump?), self-dismiss in current page and be awarded "medal" which display in profole "My medal".
    }

   
 
    
    func tableView(_ tableView: UITableView,
                       leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Archive action
        let dump = UIContextualAction(style: .normal,
                                         title: "Dump") { [weak self] (action, view, completionHandler) in
                                            self?.handleMoveToDump()
                                            completionHandler(true)
        }
        dump.backgroundColor = .systemGreen

        // Trash action
        let trash = UIContextualAction(style: .destructive,
                                       title: "Trash") { [weak self] (action, view, completionHandler) in
                                        self?.handleMoveToTrash()
                                        completionHandler(true)
        }
        trash.backgroundColor = .systemRed

        // Edit action
        let edit = UIContextualAction(style: .normal,
                                       title: "Edit") { [weak self] (action, view, completionHandler) in
                                        self?.handleMarkAsEdit()
                                        completionHandler(true)
        }
        edit.backgroundColor = .systemOrange
        
        // Move to Dump
        
        let done = UIContextualAction(style: .normal,
                             title: "Done") { [weak self] (action, view, completionHandler) in
                                 self?.handleMarkAsDone()
                                 completionHandler(true)
        }
        done.backgroundColor = .systemBlue

        let configuration = UISwipeActionsConfiguration(actions: [dump, trash, edit, done])

        return configuration
        
        configuration.performsFirstActionWithFullSwipe = false
    }
    
    
    
    @IBAction func onBackButton(_ sender: Any) {
    
             PFUser.logOut()
             
             let main = UIStoryboard(name: "Main", bundle: nil)
             let TabBarViewController = main.instantiateViewController(withIdentifier: "TabBarViewController")
             guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
             
             delegate.window?.rootViewController = TabBarViewController
            
    }
    
   
}
