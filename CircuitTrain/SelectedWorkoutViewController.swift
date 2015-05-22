//
//  SelectedWorkoutViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 5/11/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit
import AVFoundation

class SelectedWorkoutViewController: UIViewController {

    let synth = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance(string: "")

    @IBOutlet weak var dontLikeButton: UIButton!
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
        
        pause()
        reset()
        
    }
    
    @IBAction func rewind(sender: AnyObject) {
        
        pause()
        
        if exerciseNumber - 1 < 0 {
            setExercise(exerciseNumber)
        } else {
            
            if exercises[exerciseNumber - 1] == "Rest" {
                
                if exerciseNumber - 2 < 0 {
                    setExercise(exerciseNumber)
                } else {
                    setExercise(exerciseNumber - 2)
                }
                
            }
        
        }
        
    }
    
    @IBAction func play(sender: AnyObject) {
        
        if timer.valid == true {
            playButton.setTitle("Play", forState: UIControlState.Normal)
            pause()
        } else {
            playButton.setTitle("Pause", forState: UIControlState.Normal)
            speak(exercises[exerciseNumber])
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func fastforward(sender: AnyObject) {
        
        if exerciseNumber + 1 >= exercises.count {
            pause()
        } else {
            
            if timer.valid {
                timer.invalidate()
                setExercise(exerciseNumber + 1)
                play(sender)
            } else {
                timer.invalidate()
                if exercises[exerciseNumber + 1] == "Rest" {
                    if exerciseNumber + 2 >= exercises.count {
                        pause()
                    } else {
                        setExercise(exerciseNumber + 2)
                    }
                } else {
                    setExercise(exerciseNumber + 1)
                }
            
            }
        }
        
    }
    
    func reset() {
        
        pause()
        setExercise(0)
        
    }
    
    func pause() {
        
        if timer.valid == true {
            playButton.setTitle("Play", forState: UIControlState.Normal)
            timer.invalidate()
        }
        
    }
    
    func updateTime() {
        
        --currentTime
        
        switch currentTime {
        case 1,2,3:
            speak(String(currentTime))
        case 0:
            speak("Done")
        default:
            break
        }
        
        setTimerLabel(currentTime)
        
        if currentTime < 0 {
            if exerciseNumber + 1 < exercises.count {
                setExercise(exerciseNumber + 1)
            } else {
                println("stop")
                pause()
            }
        }
        
    }
    
    @IBAction func dontLike(sender: AnyObject) {
        
        if exerciseNumber + 2 >= exercises.count {
            pause()
        } else {
            setExercise(exerciseNumber + 2)
        }
    }

    func initialLoad() {
        
        dontLikeButton.hidden = true
        
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
        
        setExercise(exerciseNumber)
        
    }
    
    func setExercise(exNum: Int) {
        
        exerciseNumber = exNum
        
        if exercises[exerciseNumber] == "Rest" || exercises[exerciseNumber] == "Warmup" {
            
            dontLikeButton.hidden = false
            exerciseLabel.text = "Next: \(exercises[exerciseNumber + 1])"
            
        } else {
        
            dontLikeButton.hidden = true
            exerciseLabel.text = exercises[exerciseNumber]
            
        }
        
        currentTime = exerciseTimes[exerciseNumber]
        setTimerLabel(currentTime)
        
        if timer.valid {
            speak(exercises[exerciseNumber])
        }
        
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
    
    func speak(speech: String) {
        
        utterance = AVSpeechUtterance(string: speech)
        utterance.rate = 0.3
        synth.speakUtterance(utterance)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if timer.valid {
            timer.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
