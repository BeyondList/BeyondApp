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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todayTaskTableView.dequeueReusableCell(withIdentifier: "TaskViewCell") as! TaskViewCell
        
        let task = tasks[indexPath.row]
        cell.taskNameLabel.text = task["name"] as! String
        
        /*
         priority hasn't be set up yet
         //cell.priorityLabel.text = task["priority"] as! String
         */
        
        return cell
    }
    
    override func viewDidLayoutSubviews() {
       
    }
    
    
    /* needed for adding delete task cell func
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let newtaskObject = PFObject(className: "Tasks")
        let taskCell = tasks[indexPath.row]
        newtaskObject["name"] = taskCell["name"]
        newtaskObject["author"] = PFUser.current()!
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            PFUser.deleteInBackground(newtaskObject)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
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
