//
//  NewExerciseViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 4/28/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit

class NewExerciseViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var exercisePicker: UIPickerView!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var setsPicker: UIPickerView!
    @IBOutlet weak var exerciseLabel: UITextField!
    @IBOutlet weak var timeLabel: UITextField!
    @IBOutlet weak var setsLabel: UITextField!
    
    var itemIndex: Int = 0
    var center:CGFloat = 0
    var activePicker = 0
    var seconds = [String]()
    var minutes = [String]()
    var sets = [Int]()
    var minutesTitle = "00"
    var secondsTitle = "00"
    var exerciseName: String = "" {
        
        didSet {
            
            if let exerciseNameView = exerciseLabel {
                exerciseNameView.text = exerciseName
            }
            
        }
        
    }
    var exerciseTime: String = "" {
        
        didSet {
            
            if let exerciseTimeView = timeLabel {
                exerciseTimeView.text = exerciseTime
            }
            
        }
        
    }
    var exerciseSets: String = "" {
        
        didSet {
            
            if let exerciseSetsView = setsLabel {
                exerciseSetsView.text = exerciseSets
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(exerciseName)
    
        loadArrays()
        
        center = exercisePicker.center.x
        
        setDefaults()
        
    }
    
    @IBAction func done(sender: AnyObject) {
        
        save()
        
        performSegueWithIdentifier("page\(previousView)Segue", sender: sender)
        
    }
    
    func save() -> Bool {
        
        contentExercises[exerciseNumber] = exerciseLabel.text
        contentSets[exerciseNumber] = setsLabel.text
        
        var time = timeLabel.text
        var minIndexStart = time.startIndex
        var minIndexEnd = find(time, ":")
        var minRange = minIndexStart..<minIndexEnd!
        var minInt = time.substringWithRange(minRange).toInt()! * 60
        var secIndexStart = advance(time.startIndex,3)
        var secIndexEnd = time.endIndex
        var secRange = secIndexStart..<secIndexEnd
        var secInt = time.substringWithRange(secRange).toInt()
        var totalTime = minInt + secInt!
        
        var saved = false
        
        if totalTime <= 0 {
        
            let alert = UIAlertController(title: "Set Time", message: "Enter the exercise time", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
                
        } else {
        
            saved = true
            
            contentTime[exerciseNumber] = String(totalTime)
            
            editingWorkout["exercises"] = contentExercises
            editingWorkout["exerciseTimes"] = contentTime
            editingWorkout["exerciseSets"] = contentSets
            
        }
        
        return saved
        
    }
    
    @IBAction func add(sender: AnyObject) {
        
        var saved: Bool = save()
        
        if saved {
        
            if let totalExercises = editingWorkout["exercises"] {
                
                exerciseNumber = totalExercises.count
                
            }
            
            performSegueWithIdentifier("addPageSegue", sender: sender)
        
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender?.title == "Done" {
            
            println("done")
            
        } else if sender?.tag == 501 {
            
            println("add")
            
        }
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 402 { return 4 }
        else if pickerView.tag == 403 { return 2 }
        
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 402 {
            
            if component == 0 {
                return minutes.count
            } else if component == 2 {
                return seconds.count
            } else if component == 1 {
                return 1
            } else if component == 3 {
                return 1
            }
            
        } else if pickerView.tag == 401 {
            
            return defaultExercises.count
            
        } else if pickerView.tag == 403 {
            
            if component == 0 {
                return sets.count
            } else if component == 1 {
                return 2
            }
            
        }
        
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if pickerView.tag == 402 {
            
            if component == 0 {
                return minutes[row]
            } else if component == 2 {
                return seconds[row]
            } else if component == 1 {
                return "min"
            } else if component == 3 {
                return "sec"
            }
            
        } else if pickerView.tag == 401 {
            
            return defaultExercises[row]
            
        } else if pickerView.tag == 403 {
            
            if component == 0 {
                return String(sets[row])
            } else if component == 1 && row == 0 {
                return "set"
            } else if component == 1 && row > 0 {
                return "sets"
            }
            
        }
        
        return ""
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //add save for the exercises
        
        if pickerView.tag == 401 {
            
            exerciseLabel.text = defaultExercises[row]
            
        } else if pickerView.tag == 402 {
            
            if component == 0 {
                
                minutesTitle = minutes[row]
                
            } else if component == 2 {
                
                secondsTitle = seconds[row]
                
            }
        
            timeLabel.text = "\(minutesTitle):\(secondsTitle)"
            
        } else if pickerView.tag == 403 {
            
            if row > 0 {
                
                pickerView.selectRow(1, inComponent: 1, animated: true)
                
            } else if row == 0 {
                
                pickerView.selectRow(0, inComponent: 1, animated: true)
                
            }
            
            if component == 0 {
            
                setsLabel.text = String(sets[row])
            
            }
            
            if component == 1 {
                
                if pickerView.selectedRowInComponent(0) == 0 {
                    
                    pickerView.selectRow(0, inComponent: 1, animated: true)
                    
                } else {
                    
                    pickerView.selectRow(1, inComponent: 1, animated: true)
                    
                }
                
            }
        }
        
        save()
        
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        if pickerView.tag == 401 {
            
            return 200
            
        } else if pickerView.tag == 402 {
            switch component {
            case 0,2:
                return 40
            case 1,3:
                return 50
            default:
                return 100
            }
            
        } else if pickerView.tag == 403 {
            
            switch component {
            case 0:
                return 40
            case 1:
                return 60
            default:
                return 100
            }
            
        }
        
        return 0
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField.tag == 451 {
            activePicker = 0
        } else if textField.tag == 452 {
            activePicker = 1
        } else if textField.tag == 453 {
            activePicker = 2
        }
    
        selectPicker()
        
        return false
    
    }
    
    func selectPicker() {
        
        self.exercisePicker.hidden = false
        self.timePicker.hidden = false
        self.setsPicker.hidden = false
        
        if activePicker == 0 {
            
            UIView.animateWithDuration(0.5 , animations: { () -> Void in
                
                self.exercisePicker.center = CGPointMake(self.center, self.exercisePicker.center.y)
                self.timePicker.center = CGPointMake(self.center + 400, self.timePicker.center.y)
                self.setsPicker.center = CGPointMake(self.center + 800, self.setsPicker.center.y)
                
            }, completion: { (done) -> Void in
                
                if done == true {
                
                    self.timePicker.hidden = true
                    self.setsPicker.hidden = true
                    
                }
                
            })
            
        } else if activePicker == 1 {
            
            UIView.animateWithDuration(0.5 , animations: { () -> Void in
                
                self.exercisePicker.center = CGPointMake(self.center - 400, self.exercisePicker.center.y)
                self.timePicker.center = CGPointMake(self.center, self.timePicker.center.y)
                self.setsPicker.center = CGPointMake(self.center + 400, self.setsPicker.center.y)
                
                }, completion: { (done) -> Void in
            
                    if done == true {
                            
                        self.exercisePicker.hidden = true
                        self.setsPicker.hidden = true
                    }
        
            })
    
        } else if activePicker == 2 {
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.exercisePicker.center = CGPointMake(self.center - 800, self.exercisePicker.center.y)
                self.timePicker.center = CGPointMake(self.center - 400, self.timePicker.center.y)
                self.setsPicker.center = CGPointMake(self.center, self.setsPicker.center.y)
                
                }, completion: { (done) -> Void in
            
                    if done == true {
                        self.exercisePicker.hidden = true
                        self.timePicker.hidden = true
                            
                    }
        
            })
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
         
        initialSetup()
        
    }
    
    func initialSetup() {
        
        if activePicker == 0 {
            
            self.exercisePicker.center = CGPointMake(self.center, self.exercisePicker.center.y)
            self.timePicker.center = CGPointMake(self.center + 400, self.timePicker.center.y)
            self.setsPicker.center = CGPointMake(self.center + 800, self.setsPicker.center.y)
            
        } else if activePicker == 1 {
            
            self.exercisePicker.center = CGPointMake(self.center - 400, self.exercisePicker.center.y)
            self.timePicker.center = CGPointMake(self.center, self.timePicker.center.y)
            self.setsPicker.center = CGPointMake(self.center + 400, self.setsPicker.center.y)
            
        } else if activePicker == 2 {
            
            self.exercisePicker.center = CGPointMake(self.center - 800, self.exercisePicker.center.y)
            self.timePicker.center = CGPointMake(self.center - 400, self.timePicker.center.y)
            self.setsPicker.center = CGPointMake(self.center, self.setsPicker.center.y)
            
        }

    }
    
    func loadArrays() {
        
        for i in 0...60 {
            
            seconds.append(String(format: "%02d", i))
            minutes.append(String(format: "%02d", i))
            
        }
        
        for i in 01...20 {
            
            sets.append(i)
            
        }
        
    }
    
    func setDefaults() {
        
        var sec:Int = exerciseTime.toInt()! % 60
        var min:Int = (exerciseTime.toInt()! - sec) / 60
        var minString = String(format: "%02d", min)
        var secString = String(format: "%02d", sec)
        var secToMin = minString + ":" + secString
        
        timeLabel.text = secToMin
        setsLabel.text = exerciseSets
        exerciseLabel.text = exerciseName
        
        save()
        
        var defaultExercise = 0
        var e = 0
        while e < defaultExercises.count {
            if exerciseName == defaultExercises[e] {
                defaultExercise = e
            }
            e++
        }
        exercisePicker.selectRow(defaultExercise, inComponent: 0, animated: true)
        
        var defaultSet = 0
        var s = 0
        while s < sets.count {
            if exerciseSets == String(sets[s]) {
                defaultSet = s
            }
            s++
        }
        setsPicker.selectRow(defaultSet, inComponent: 0, animated: true)
        
        var defaultMin = 0
        var tm = 0
        while tm < minutes.count {
            if minString == minutes[tm] {
                defaultMin = tm
            }
            tm++
        }
        timePicker.selectRow(defaultMin, inComponent: 0, animated: true)
        
        var defaultSec = 0
        var ts = 0
        while ts < seconds.count {
            if secString == seconds[ts] {
                defaultSec = ts
            }
            ts++
        }
        timePicker.selectRow(defaultSec, inComponent: 1, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
