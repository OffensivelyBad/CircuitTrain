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
    
    var center:CGFloat = 0
    var activePicker = 0
    var firstRun:Bool = true
    var seconds = [String]()
    var minutes = [String]()
    var sets = [Int]()
    var minutesTitle = "00"
    var secondsTitle = "01"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadArrays()
        
        center = exercisePicker.center.x
        
        if let exerciseArray = editingWorkout["exercises"] {
            
            if exerciseNumber < exerciseArray.count {
                //existing exercise
                
                
            } else {
                //new exercise
                
                
            }
            
        }
        
        exerciseLabel.text = defaultExercises[0]
        timeLabel.text = "\(minutesTitle):\(secondsTitle)"
        setsLabel.text = String(sets[0])
        
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
                return "m"
            } else if component == 3 {
                return "s"
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
        }
        
    }
    
    @IBAction func step(sender: AnyObject) {
        
        
        
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
        
        if activePicker == 0 {
        
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.exercisePicker.center = CGPointMake(self.center, self.exercisePicker.center.y)
                self.timePicker.center = CGPointMake(self.center + 400, self.timePicker.center.y)
                self.setsPicker.center = CGPointMake(self.center + 800, self.setsPicker.center.y)
                
            })
            
        } else if activePicker == 1 {
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.exercisePicker.center = CGPointMake(self.center - 400, self.exercisePicker.center.y)
                self.timePicker.center = CGPointMake(self.center, self.timePicker.center.y)
                self.setsPicker.center = CGPointMake(self.center + 400, self.setsPicker.center.y)
                
            })
            
        } else if activePicker == 2 {
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.exercisePicker.center = CGPointMake(self.center - 800, self.exercisePicker.center.y)
                self.timePicker.center = CGPointMake(self.center - 400, self.timePicker.center.y)
                self.setsPicker.center = CGPointMake(self.center, self.setsPicker.center.y)
                
            })
            
        }
        
    }
    
    func layout(position: Int) {
        
        if position == 0 {
                
                self.exercisePicker.center = CGPointMake(self.center, self.exercisePicker.center.y)
                self.timePicker.center = CGPointMake(self.center + 400, self.timePicker.center.y)
                self.setsPicker.center = CGPointMake(self.center + 800, self.setsPicker.center.y)
            
        } else if position == 1 {
                
                self.exercisePicker.center = CGPointMake(self.center - 400, self.exercisePicker.center.y)
                self.timePicker.center = CGPointMake(self.center, self.timePicker.center.y)
                self.setsPicker.center = CGPointMake(self.center + 400, self.setsPicker.center.y)
            
        } else if position == 2 {
                
                self.exercisePicker.center = CGPointMake(self.center - 800, self.exercisePicker.center.y)
                self.timePicker.center = CGPointMake(self.center - 400, self.timePicker.center.y)
                self.setsPicker.center = CGPointMake(self.center, self.setsPicker.center.y)
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
         
        initialSetup()
        
    }
    
    func initialSetup() {
        
        layout(activePicker)

    }
    
    func loadArrays() {
        
        for i in 01...60 {
            
            seconds.append(String(format: "%02d", i))
            minutes.append(String(format: "%02d", i))
            
        }
        
        for i in 01...20 {
            
            sets.append(i)
            
        }
        
        println("\(seconds),\(minutes),\(sets)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
