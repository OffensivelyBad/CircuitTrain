//
//  NewHeaderViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 4/27/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit

class NewHeaderViewController: UIViewController {

    @IBOutlet weak var workoutNameLabel: UITextField!
    @IBOutlet weak var warmupLabel: UITextField!
    @IBOutlet weak var restLabel: UITextField!
    
    var workoutName = ""
    var warmup = ""
    var rest = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !addNew {
        
            editingWorkout = workouts[workoutNumber]
            
            if let name = editingWorkout["name"], warmupTime = editingWorkout["warmup"], restTime = editingWorkout["rest"] {
                
                self.workoutName = name[0]
                workoutNameLabel.text = self.workoutName
                
                self.warmup = warmupTime[0]
                warmupLabel.text = self.warmup
                
                self.rest = restTime[0]
                restLabel.text = self.rest
                
            }
            
        } else {
            
            editingWorkout = [:]
            
        }
        
        println(editingWorkout)
        
    }
    
    @IBAction func next(sender: AnyObject) {
        
        if workoutNameLabel.text == "" || warmupLabel.text == "" || restLabel.text == "" {
            
            let alert = UIAlertController(title: "Missing info", message: "Fill in all fields", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
        
            if addNew {
            
                performSegueWithIdentifier("newNewSegue", sender: sender)
                
            } else {
                
                performSegueWithIdentifier("newEditSegue", sender: sender)
                
            }
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
        //save the changes
        
        editingWorkout["name"] = []
        editingWorkout["warmup"] = []
        editingWorkout["rest"] = []
        
        editingWorkout["name"]?.append(workoutNameLabel.text)
        editingWorkout["warmup"]?.append(warmupLabel.text)
        editingWorkout["rest"]?.append(restLabel.text)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
