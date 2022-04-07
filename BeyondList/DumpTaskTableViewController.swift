//
//  DumpTaskTableViewController.swift
//  BeyondList
//
//  Created by 07elenazheng-@naver.com on 4/6/22.
//

import UIKit
import Parse

class DumpTaskTableViewController: UITableViewController {
    @IBOutlet weak var dumpTaskTableView: UITableView!
    
    var tasks = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dumpTaskTableView.delegate = self
        dumpTaskTableView.dataSource = self
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
                self.dumpTaskTableView.reloadData()
            }
        }
    }
    
   
  
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dumpTaskTableView.dequeueReusableCell(withIdentifier: "TaskViewCell") as! TaskViewCell
        
        let task = tasks[indexPath.row]
        cell.taskNameLabel.text = task["name"] as! String
        
        /*
         priority hasn't be set up yet
         //cell.priorityLabel.text = task["priority"] as! String
         */
        
        return cell
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
       
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
