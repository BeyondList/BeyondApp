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
        cell.taskObjectId = task.objectId as! String
        cell.roundedView.layer.cornerRadius = cell.roundedView.frame.height / 8
        
        //let _switch = UIButton()
        
        //_switch.isOn = true
        //_switch.backgroundColor = #colorLiteral(red: 0.5514845945, green: 0.9542901354, blue: 1, alpha: 0.7765465561)
        //_switch.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        //_switch.setTitleColor(#colorLiteral(red: 0.5514845945, green: 0.9542901354, blue: 1, alpha: 0.7765465561), for: .normal)
        //_switch.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //cell.accessoryView = _switch
        
        /*
         priority hasn't be set up yet
         //cell.priorityLabel.text = task["priority"] as! String
         */
        
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
