//
//  SelectedWorkoutViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 5/11/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit

class SelectedWorkoutViewController: UIViewController {


    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
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
    var timer = NSTimer()
    var currentTime: Int = 0
    
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
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func fastforward(sender: AnyObject) {
        
        
        
    }
    
    func reset() {
        
        
        
    }
    
    func updateTime() {
        
        --currentTime
        setTimerLabel(currentTime)
        
        if currentTime < 0 {
            if exerciseNumber + 1 < exercises.count {
                setExercise(exerciseNumber + 1)
            } else {
                println("stop")
                timer.invalidate()
            }
        }
        
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
        
        setExercise(exerciseNumber)
        
    }
    
    func setExercise(exNum: Int) {
        
        exerciseNumber = exNum
        exerciseLabel.text = exercises[exerciseNumber]
        currentTime = exerciseTimes[exerciseNumber]
        setTimerLabel(currentTime)
        
    }
    
    func convertTime(seconds: Int) -> (String, String) {
        
        var min = seconds / 60
        var sec = (seconds % 60) % 60
        
        return (String(format: "%02d", min), String(format: "%02d", sec))
        
    }
    
    func setTimerLabel(time: Int) {
        
        let (m,s) = convertTime(time)
        
        minutesLabel.text = m
        if s.toInt() < 0 {
            secondsLabel.text = "00"
        } else {
            secondsLabel.text = s
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
