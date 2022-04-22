//
//  CreateNewTaskViewController.swift
//  BeyondList
//
//  Created by 07elenazheng-@naver.com on 4/5/22.
//

import UIKit
import Parse

class CreateNewTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var importanceValue: UISegmentedControl!
    @IBOutlet weak var urgencyValue: UISegmentedControl!
    @IBOutlet weak var dateValue: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackForward(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSubmitButton(_ sender: Any) {
        let task = PFObject(className: "Tasks")
        task["name"] = taskTextField.text!
        task["author"] = PFUser.current()!
        
        task["Priority"] = (urgencyValue.selectedSegmentIndex + 1) + (importanceValue.selectedSegmentIndex + 1)
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: dateValue.date)
        task["dueDate"] = modifiedDate
        
        
        task.saveInBackground(){ (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else{
                print("error!")
            }
            
        }
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
