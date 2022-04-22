//
//  TodayTaskViewController.swift
//  BeyondList
//
//  Created by 07elenazheng-@naver.com on 4/5/22.
//

import UIKit
import Parse

class TodayTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var todayTaskTableView: UITableView!

    var tasks = [PFObject]()
    var lastTaskIndexUsed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayTaskTableView.delegate = self
        todayTaskTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Tasks")
        query.includeKey("author")
        query.limit = 10
        
        query.findObjectsInBackground{(tasks, error) in
            if tasks != nil {
                self.tasks = tasks!
                self.tasks.sort {$0["Priority"] as! Int > $1["Priority"] as! Int}
                self.todayTaskTableView.reloadData()
            }
        }
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var totalUncompletedDueToday = 0
        
        for object in tasks {
            if ( Calendar.current.isDateInToday(object["dueDate"] as! Date) && (object["Completed"] as! Bool) == false ) {
                totalUncompletedDueToday += 1
            }
        }
        return totalUncompletedDueToday
    }
    
    func getNextTaskToDisplay () -> Int {
        for index in lastTaskIndexUsed...tasks.count {
            if (tasks[index]["Completed"] as! Bool == false &&
                Calendar.current.isDateInToday(tasks[index]["dueDate"] as! Date)) {
                self.lastTaskIndexUsed = index + 1
                return index
            }
        }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todayTaskTableView.dequeueReusableCell(withIdentifier: "TaskViewCell") as! TaskViewCell
        
        let ind = getNextTaskToDisplay()
        print(String(ind))
        let task = tasks[ind]
        
        cell.taskNameLabel.text = task["name"] as! String
        cell.taskObjectId = task.objectId as! String
        cell.roundedView.layer.cornerRadius = cell.roundedView.frame.height / 8
        
        cell.completedButton.tag = indexPath.row
        
        return cell
    }
    
    override func viewDidLayoutSubviews() {
       
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        let taskCell = tasks[indexPath.row]
        let objectIdToDelete = taskCell.objectId
        let query = PFQuery(className: "Tasks")
        
        do {
            let taskToDelete = try query.getObjectWithId(objectIdToDelete!)
            if editingStyle == .delete {
                tableView.beginUpdates()
                
                taskToDelete.deleteInBackground { (success, error) in
                    if success {
                        self.tasks.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        print("Deleted!")
                    } else {
                        print("error!")
                    }
                    
                }
            }
            tableView.endUpdates()
        } catch {
            print(error)
        }
    }
    @IBAction func onClickCompleteButton(_ sender: UIButton) {
        // There's a bug where if you delete multiple
        // tasks in a row then you might get an indexPath.row oob
        // because maybe you're supposed to reload whole table??
        print("Deleting row: " + String(sender.tag))
        let task = self.tasks[sender.tag]
        task["completed"] = true
        // Set the task as completed in Parse
        // Make changes so that the table only shows non-completed tasks
        
        let query = PFQuery(className: "Tasks")
        
        let objectId:String = task.objectId!
       
        do {
            let taskToDelete = try query.getObjectWithId(objectId)
            taskToDelete["Completed"] = true
            taskToDelete.saveInBackground()
            
        } catch {
            print(error)
        }
        //taskToComplete["Completed"] = true
        
        //taskToComplete.saveInBackground()
        
        self.tasks.remove(at:sender.tag)
        //todayTaskTableView.beginUpdates()
        todayTaskTableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        //todayTaskTableView.endUpdates()
        todayTaskTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
