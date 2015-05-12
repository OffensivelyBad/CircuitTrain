//
//  SelectedWorkoutViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 5/11/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit

class SelectedWorkoutViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var exerciseLabel: UILabel!
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

        selectedWorkout = workouts[workoutNumber]
        initialLoad()
        
    }
    
    @IBAction func done(sender: AnyObject) {
        
        performSegueWithIdentifier("selectListSegue", sender: sender)
        
    }

    @IBAction func restart(sender: AnyObject) {
        
        
        
    }
    
    @IBAction func rewind(sender: AnyObject) {
        
        
        
    }
    
    @IBAction func play(sender: AnyObject) {
        
        
        
    }
    
    @IBAction func fastforward(sender: AnyObject) {
        
        
        
    }
    
    func reset() {
        
        
        
    }
    
    func initialLoad() {
        
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
            for var i = 0; i < stringExercises.count; ++i {
                let exercise = stringExercises[i]
                self.exercises.append(exercise)
            }
        }
        if let stringExerciseTimes = selectedWorkout["exerciseTimes"] {
            for var i = 0; i < stringExerciseTimes.count; ++i {
                let time = stringExerciseTimes[i]
                self.exerciseTimes.append(time.toInt()!)
            }
        }
        if let stringExerciseSets = selectedWorkout["exerciseSets"] {
            for var i = 0; i < stringExerciseSets.count; ++i {
                let set = stringExerciseSets[i]
                self.exerciseSets.append(set.toInt()!)
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
