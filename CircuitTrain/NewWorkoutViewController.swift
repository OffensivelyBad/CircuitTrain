//
//  NewWorkoutViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 4/27/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseNumber = -1

        if let exercises = editingWorkout["exercises"] {
        
            tableView.setEditing(true, animated: false)
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var exerciseCount:Int = 0
        
        if let exercises = editingWorkout["exercises"] {
            
            exerciseCount = exercises.count
            
        }
        
        return exerciseCount
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        if let thisExerciseArray = editingWorkout["exercises"], thisExerciseTimeArray = editingWorkout["exerciseTimes"], thisExerciseSetArray = editingWorkout["exerciseSets"] {
            
            let thisExerciseName = thisExerciseArray[indexPath.row]
            let thisExerciseNameLabel = tableViewCell.viewWithTag(301) as! UILabel
            thisExerciseNameLabel.text = thisExerciseName
            
            let thisExerciseTime = thisExerciseTimeArray[indexPath.row]
            let thisExerciseTimeLabel = tableViewCell.viewWithTag(302) as! UILabel
            thisExerciseTimeLabel.text = thisExerciseTime
            
            let thisExerciseSet = thisExerciseSetArray[indexPath.row]
            let thisExerciseSetLabel = tableViewCell.viewWithTag(303) as! UILabel
            thisExerciseSetLabel.text = thisExerciseSet
            
            
        }
        
        return tableViewCell
        
    }
    
    @IBAction func add(sender: AnyObject) {
        
        if let exerciseArray = editingWorkout["exercises"] {
            
            exerciseNumber = exerciseArray.count
            
        } else {
            
            exerciseNumber = 0
            
        }
        
        performSegueWithIdentifier("newNewSegue", sender: sender)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        
        performSegueWithIdentifier("newSelectSegue", sender: sender)
        
    }

    @IBAction func save(sender: AnyObject) {
        
        performSegueWithIdentifier("newSelectSegue", sender: sender)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let title = sender?.title {
            
            if title == "Cancel" {
                
                println("cancelled")
                
            } else if title == "Save" {
                
                println("saved")
                
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool { return true }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        if var thisExerciseArray = editingWorkout["exercises"], thisExerciseTimeArray = editingWorkout["exerciseTimes"], thisExerciseSetArray = editingWorkout["exerciseSets"], thisExerciseIntensityArray = editingWorkout["exerciseIntensities"] {
            
            let movedExercise = thisExerciseArray[fromIndexPath.row]
            thisExerciseArray.removeAtIndex(fromIndexPath.row)
            thisExerciseArray.insert(movedExercise, atIndex: toIndexPath.row)
            
            let movedExerciseTime = thisExerciseTimeArray[fromIndexPath.row]
            thisExerciseTimeArray.removeAtIndex(fromIndexPath.row)
            thisExerciseTimeArray.insert(movedExerciseTime, atIndex: toIndexPath.row)
            
            let movedExerciseSet = thisExerciseSetArray[fromIndexPath.row]
            thisExerciseSetArray.removeAtIndex(fromIndexPath.row)
            thisExerciseSetArray.insert(movedExerciseSet, atIndex: toIndexPath.row)
            
            let movedExerciseIntensity = thisExerciseIntensityArray[fromIndexPath.row]
            thisExerciseIntensityArray.removeAtIndex(fromIndexPath.row)
            thisExerciseIntensityArray.insert(movedExerciseIntensity, atIndex: toIndexPath.row)
            
            editingWorkout["exercises"] = thisExerciseArray
            editingWorkout["exerciseTimes"] = thisExerciseTimeArray
            editingWorkout["exerciseSets"] = thisExerciseSetArray
            editingWorkout["exerciseIntensities"] = thisExerciseIntensityArray
            
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            if var thisExerciseArray = editingWorkout["exercises"], thisExerciseTimeArray = editingWorkout["exerciseTimes"], thisExerciseSetArray = editingWorkout["exerciseSets"], thisExerciseIntensityArray = editingWorkout["exerciseIntensities"], thisSet = editingWorkout["sets"] {
                
                thisExerciseArray.removeAtIndex(indexPath.row)
                
                thisExerciseTimeArray.removeAtIndex(indexPath.row)
                
                thisExerciseSetArray.removeAtIndex(indexPath.row)
                
                thisExerciseIntensityArray.removeAtIndex(indexPath.row)
                
                editingWorkout["exercises"] = thisExerciseArray
                editingWorkout["exerciseTimes"] = thisExerciseTimeArray
                editingWorkout["exerciseSets"] = thisExerciseSetArray
                editingWorkout["exerciseIntensities"] = thisExerciseIntensityArray
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
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
