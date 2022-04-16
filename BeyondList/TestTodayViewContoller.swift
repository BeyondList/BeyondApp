//
//  TestTodayViewContoller.swift
//  BeyondList
//
//  Created by Mark on 4/10/22.
//

import UIKit
import Parse

class TestTodayViewContoller: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    

    @IBOutlet weak var todayTaskTableView: TestTodayTableView!
    var tasks = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        todayTaskTableView.delegate = self
        todayTaskTableView.dataSource = self
        todayTaskTableView.register(TestTaskTableViewCell.self, forCellReuseIdentifier: "testTaskCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Tasks")
        query.includeKey("author")
        query.limit = 4
        
        query.findObjectsInBackground{(tasks, error) in
            if tasks != nil {
                self.tasks = tasks!
                print("tasks was not nil")
                self.todayTaskTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    override func viewDidLayoutSubviews() {
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todayTaskTableView.dequeueReusableCell(withIdentifier: "testTaskCell") as! TestTaskTableViewCell
        
        let task = tasks[indexPath.row]
        print("testststs")
        print(task["name"] as! String)
        
        /*
        // Crashes here due to found nil
        cell.taskNameLabel.text = task["name"] as! String
        cell.taskObjectId = task.objectId as! String
        cell.roundedView.layer.cornerRadius = cell.roundedView.frame.height / 8
         */
        
        /*
         priority hasn't be set up yet
         //cell.priorityLabel.text = task["priority"] as! String
         */
        
        return cell
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
