//
//  EditWorkoutViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 4/22/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit

class EditWorkoutViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var editingWorkout = workouts[workoutNumber]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(editingWorkout)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var exerciseCount:Int
        
        if let exercises = editingWorkout["exercises"] {
        
            exerciseCount =  exercises.count
            
        } else {
            
            exerciseCount = 1
            
        }
        
        return exerciseCount
        
    }
    

    @IBAction func cancel(sender: AnyObject) {
        
        performSegueWithIdentifier("editSelectSegue", sender: sender)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        if let thisExerciseArray = editingWorkout["exercises"] {
        
            let thisExerciseName = thisExerciseArray[indexPath.row]
            let thisExerciseNameLabel = tableViewCell.viewWithTag(201) as! UILabel
            thisExerciseNameLabel.text = thisExerciseName
        
        }
        if let thisExerciseTimeArray = editingWorkout["exerciseTimes"] {
            
            let thisExerciseTime = thisExerciseTimeArray[indexPath.row]
            let thisExerciseTimeLabel = tableViewCell.viewWithTag(202) as! UILabel
            thisExerciseTimeLabel.text = thisExerciseTime
            
        }
        if let thisExerciseSetArray = editingWorkout["exerciseSets"] {
            
            let thisExerciseSet = thisExerciseSetArray[indexPath.row]
            let thisExerciseSetLabel = tableViewCell.viewWithTag(203) as! UILabel
            thisExerciseSetLabel.text = thisExerciseSet
            
        }
        
        return tableViewCell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let title = sender?.title {
        
            if title == "Cancel" {
                
                println("cancelled")
                
            }
        
        }
        
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
