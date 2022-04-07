//
//  TomorrowTaskTableViewController.swift
//  BeyondList
//
//  Created by 07elenazheng-@naver.com on 4/6/22.
//

import UIKit
import Parse

class TomorrowTaskTableViewController: UITableViewController{
   
    @IBOutlet weak var tomorrowTaskTableView: UITableView!
    var tasks = [PFObject]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tomorrowTaskTableView.delegate = self
        tomorrowTaskTableView.dataSource = self
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Tasks")
        query.includeKey("author")
        query.limit = 10
        
        query.findObjectsInBackground{(tasks, error) in
            if tasks != nil {
                self.tasks = tasks!
                self.tomorrowTaskTableView.reloadData()
            }
        }
    

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tomorrowTaskTableView.dequeueReusableCell(withIdentifier: "TaskViewCell") as! TaskViewCell
        
        let task = tasks[indexPath.row]
        cell.taskNameLabel.text = task["name"] as! String
        
        /*
         priority hasn't be set up yet
         //cell.priorityLabel.text = task["priority"] as! String
         */
        
        return cell
    }
}

    
    @IBAction func onBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
