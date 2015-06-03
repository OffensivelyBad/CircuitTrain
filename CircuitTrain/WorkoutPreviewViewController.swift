//
//  WorkoutPreviewViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 5/25/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit

class WorkoutPreviewViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseTimeLabel: UILabel!
    @IBOutlet weak var exerciseSetsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var workoutTitle: UINavigationItem!
    
    var workoutName = ""
    var sets = 0
    var warmup = 0
    var rest = 0
    var exercises = [String]()
    var exerciseTimes = [Int]()
    var exerciseSets = [Int]()
    var exerciseNumber:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoad()
        
    }
    
    @IBAction func back(sender: AnyObject) {
        
        performSegueWithIdentifier("previewSelectSegue", sender: self)
        
    }
    
    @IBAction func start(sender: AnyObject) {
        
        performSegueWithIdentifier("previewSelectedSegue", sender: self)
        
    }
    
    func initialLoad() {
        
        selectedWorkout = workouts[workoutNumber]
        
        if let name = selectedWorkout["name"] {
            self.workoutName = name[0]
            self.workoutTitle.title = self.workoutName
        }
        if let totalSets = selectedWorkout["sets"] {
            self.sets = totalSets[0].toInt()!
        }
        if let workoutWarmup = selectedWorkout["warmup"] {
            self.warmup = workoutWarmup[0].toInt()!
        }
        if let workoutRest = selectedWorkout["rest"] {
            self.rest = workoutRest[0].toInt()!
        }
        if let stringExercises = selectedWorkout["exercises"] {
            if self.warmup > 0 {
                
                self.exercises.append("Warmup")
                
            }
            if self.rest > 0 {
                
                for var i = 0; i < stringExercises.count; ++i {
                    
                    let exercise = stringExercises[i]
                    self.exercises.append(exercise)
                    
                    if i < stringExercises.count - 1 {
                        self.exercises.append("Rest")
                    }
                    
                }
                
            } else {
                
                for var i = 0; i < stringExercises.count; ++i {
                    let exercise = stringExercises[i]
                    self.exercises.append(exercise)
                    
                }
                
            }
            
        }
        if let stringExerciseTimes = selectedWorkout["exerciseTimes"] {
            
            if self.warmup > 0 {
                
                self.exerciseTimes.append(self.warmup)
                
            }
            if self.rest > 0 {
                
                for var i = 0; i < stringExerciseTimes.count; ++i {
                    
                    let time = stringExerciseTimes[i]
                    self.exerciseTimes.append(time.toInt()!)
                    
                    if i < stringExerciseTimes.count - 1 {
                        self.exerciseTimes.append(self.rest)
                    }
                    
                }
                
            } else {
                
                for var i = 0; i < stringExerciseTimes.count; ++i {
                    let time = stringExerciseTimes[i]
                    self.exerciseTimes.append(time.toInt()!)
                    
                }
                
            }
            
        }
        if let stringExerciseSets = selectedWorkout["exerciseSets"] {
            
            if self.warmup > 0 {
                
                self.exerciseSets.append(1)
                
            }
            if self.rest > 0 {
                
                for var i = 0; i < stringExerciseSets.count; ++i {
                    
                    let set = stringExerciseSets[i]
                    self.exerciseSets.append(set.toInt()!)
                    
                    if i < stringExerciseSets.count - 1 {
                        self.exerciseSets.append(self.rest)
                    }
                    
                }
                
            } else {
                
                for var i = 0; i < stringExerciseSets.count; ++i {
                    let set = stringExerciseSets[i]
                    self.exerciseSets.append(set.toInt()!)
                    
                }
                
            }
            
        }
        
        tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return exercises.count
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
            
        let thisExerciseName = exercises[indexPath.row]
        let thisExerciseNameLabel = tableViewCell.viewWithTag(701) as! UILabel
        thisExerciseNameLabel.text = thisExerciseName
        
        let thisExerciseTime = exerciseTimes[indexPath.row]
        let thisExerciseTimeLabel = tableViewCell.viewWithTag(702) as! UILabel
        thisExerciseTimeLabel.text = String(thisExerciseTime)
        
        let thisExerciseSet = exerciseSets[indexPath.row]
        let thisExerciseSetLabel = tableViewCell.viewWithTag(703) as! UILabel
        thisExerciseSetLabel.text = String(thisExerciseSet)
        
        return tableViewCell
        
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
