//
//  ViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 4/7/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit
import CoreData

var workouts = [Dictionary<String,[String]>()]
var editingWorkout = Dictionary<String, [String]>()
var newWorkout = Dictionary<String, [String]>()
var selectedWorkout = Dictionary<String, [String]>()
var workoutNumber:Int = -1
var exerciseNumber:Int = -1
var firstLoad:Bool = true
var addNew:Bool = true
var defaultExercises = [String]()
var previousView:String = ""
var user = "Shawn"
var storedWorkouts = [NSManagedObject]()

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var editDoneButton: UIBarButtonItem!
    @IBOutlet weak var workoutListTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        workoutNumber = -1
        
        if firstLoad {
            
            initialLoad()
            
        }
        
        editingWorkout = [:]
        
        tableView.allowsSelectionDuringEditing = true
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return workouts.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("workoutListCell", forIndexPath: indexPath) as! UITableViewCell
        
        let thisWorkoutName = workouts[indexPath.row]["name"]!
        let thisWorkoutTime = workouts[indexPath.row]["time"]!
        let thisWorkoutSets = workouts[indexPath.row]["sets"]!
        let thisWorkoutIntensity = workouts[indexPath.row]["intensity"]!
        
        let workoutNameLabel = tableViewCell.viewWithTag(101) as! UILabel
        workoutNameLabel.text = thisWorkoutName[0]

        let workoutTimeLabel = tableViewCell.viewWithTag(102) as! UILabel
        workoutTimeLabel.text = thisWorkoutTime[0]
        
        let workoutSetsLabel = tableViewCell.viewWithTag(103) as! UILabel
        workoutSetsLabel.text = thisWorkoutSets[0]
        
        return tableViewCell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        workoutNumber = indexPath.row
        
        if tableView.editing {
            
            addNew = false
            
            performSegueWithIdentifier("listNewSegue", sender: self)
            
        } else {
            
            performSegueWithIdentifier("selectSelectedSegue", sender: self)
            
        }
        
    }
    
    @IBAction func addNewWorkout(sender: AnyObject) {
        
        addNew = true
        
        performSegueWithIdentifier("listNewSegue", sender: sender)
        
    }

    @IBAction func edit(sender: AnyObject) {
        
        if tableView.editing {
            
            tableView.setEditing(false, animated: true)
            editDoneButton.style = UIBarButtonItemStyle.Done
            editDoneButton.title = "Edit"
            
        } else {
            
            tableView.setEditing(true, animated: true)
            editDoneButton.style = UIBarButtonItemStyle.Plain
            editDoneButton.title = "Done"
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool { return true }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        let movedWorkout = workouts[fromIndexPath.row]
        workouts.removeAtIndex(fromIndexPath.row)
        workouts.insert(movedWorkout, atIndex: toIndexPath.row)
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

            workouts.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
    }
    
    func initialLoad() {
        
        //remove initial placeholder record
        if workouts.count == 1 { workouts.removeAtIndex(0) }
        
        //get workouts from server
//        let urlPath = "http://104.236.180.121:8080/iOS/CircuitTrain/workouts/default.json"
//        let url = NSURL(string: urlPath)
//        let request = NSMutableURLRequest(URL: url!)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
//            
//            if let httpResponse = response as? NSHTTPURLResponse {
//
//                if httpResponse.statusCode == 404 || error != nil {
//                    
//                    println("\(httpResponse) \(error)")
//                    
//                    self.setDefaultWorkouts()
//                    
//                } else {
//                    
//                    if let jsonWorkout = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray {
//                    
//                        for workout in jsonWorkout {
//                            
//                            workouts.append(workout as! Dictionary<String, [String]>)
//                            
//                        }
//                    
//                    } else {
//                        
//                        self.setDefaultWorkouts()
//                        
//                    }
//                    
//                }
//                
//            } else {
//                
//                println("could not connect to server")
//                
//                self.setDefaultWorkouts()
//            }
//            
//            self.tableView.reloadData()
//            
//        })
        
        let urlDBWorkouts = "http://104.236.180.121:3000/defaultWorkouts/default"
        let urlDBWorkout = NSURL(string: urlDBWorkouts)
        let requestDBWorkouts = NSMutableURLRequest(URL: urlDBWorkout!)
        requestDBWorkouts.HTTPMethod = "GET"
        requestDBWorkouts.addValue("application/json", forHTTPHeaderField: "Accept")
        NSURLConnection.sendAsynchronousRequest(requestDBWorkouts, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
            
            if error != nil  {
                
                self.setDefaultWorkouts()
                
            } else if let httpResponse = response as? NSHTTPURLResponse {

                if httpResponse.statusCode == 404 || error != nil {
                    
                    println("\(httpResponse) \(error)")
                    
                    self.setDefaultWorkouts()
                    
                } else {
                    
                    if let dbWorkoutArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray {

                        for workout in dbWorkoutArray {
                            
                            var tempWorkout = [String: [String]]()
                            var id: [String] = []
                            id.append(workout["_id"] as! String)
                            tempWorkout["_id"] = id
                            tempWorkout["exerciseIntensities"] = workout["exerciseIntensities"] as? [String]
                            tempWorkout["exerciseSets"] = workout["exerciseSets"] as? [String]
                            tempWorkout["exerciseTimes"] = workout["exerciseTimes"] as? [String]
                            tempWorkout["exercises"] = workout["exercises"] as? [String]
                            tempWorkout["intensity"] = workout["intensity"] as? [String]
                            tempWorkout["name"] = workout["name"] as? [String]
                            tempWorkout["rest"] = workout["rest"] as? [String]
                            tempWorkout["sets"] = workout["sets"] as? [String]
                            tempWorkout["time"] = workout["time"] as? [String]
                            tempWorkout["warmup"] = workout["warmup"] as? [String]
                            
                            if let updated: AnyObject? = workout["updated_at"] {
                                var update: [String] = []
                                if updated != nil {
                                    update.append(updated as! String)
                                    tempWorkout["updated_at"] = update
                                }
                            }
                            
                            if let created: AnyObject? = workout["created_at"] {
                                var create: [String] = []
                                if created != nil {
                                    create.append(created as! String)
                                    tempWorkout["created_at"] = create
                                }
                            }
                            
                            workouts.append(tempWorkout)
                            
                        }
                        
                    } else {
                        
                        self.setDefaultWorkouts()
                    }
                    
                }
                
            }
            
            self.tableView.reloadData()
            
        })
        
        let urlUserWorkouts = "http://104.236.180.121:3000/userWorkouts/" + user
        let urlUserWorkout = NSURL(string: urlUserWorkouts)
        let requestUserWorkouts = NSMutableURLRequest(URL: urlUserWorkout!)
        requestUserWorkouts.HTTPMethod = "GET"
        requestUserWorkouts.addValue("application/json", forHTTPHeaderField: "Accept")
        NSURLConnection.sendAsynchronousRequest(requestUserWorkouts, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
            
            if error != nil  {
                
                self.setDefaultWorkouts()
                
            } else if let httpResponse = response as? NSHTTPURLResponse {
                
                if httpResponse.statusCode == 404 || error != nil {
                    
                    println("\(httpResponse) \(error)")
                    
                    self.setDefaultWorkouts()
                    
                } else {
                    
                    if let dbWorkoutArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray {
                        
                        for workout in dbWorkoutArray {
                            
                            var tempWorkout = [String: [String]]()
                            var id: [String] = []
                            id.append(workout["_id"] as! String)
                            tempWorkout["_id"] = id
                            tempWorkout["exerciseIntensities"] = workout["exerciseIntensities"] as? [String]
                            tempWorkout["exerciseSets"] = workout["exerciseSets"] as? [String]
                            tempWorkout["exerciseTimes"] = workout["exerciseTimes"] as? [String]
                            tempWorkout["exercises"] = workout["exercises"] as? [String]
                            tempWorkout["intensity"] = workout["intensity"] as? [String]
                            tempWorkout["name"] = workout["name"] as? [String]
                            tempWorkout["rest"] = workout["rest"] as? [String]
                            tempWorkout["sets"] = workout["sets"] as? [String]
                            tempWorkout["time"] = workout["time"] as? [String]
                            tempWorkout["warmup"] = workout["warmup"] as? [String]
                            
                            if let updated: AnyObject? = workout["updated_at"] {
                                var update: [String] = []
                                if updated != nil {
                                    update.append(updated as! String)
                                    tempWorkout["updated_at"] = update
                                }
                            }
                            
                            if let created: AnyObject? = workout["created_at"] {
                                var create: [String] = []
                                if created != nil {
                                    create.append(created as! String)
                                    tempWorkout["created_at"] = create
                                }
                            }
                            
                            workouts.append(tempWorkout)
                            
                        }
                        
                    } else {
                        
                        self.setDefaultWorkouts()
                    }
                    
                }
                
            }
            
            self.tableView.reloadData()
            
        })
    
        let urlDBExercises = "http://104.236.180.121:3000/defaultExercises/default"
        let urlDB = NSURL(string: urlDBExercises)
        let requestDBExercises = NSMutableURLRequest(URL: urlDB!)
        requestDBExercises.HTTPMethod = "GET"
        requestDBExercises.addValue("application/json", forHTTPHeaderField: "Accept")
        NSURLConnection.sendAsynchronousRequest(requestDBExercises, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
            
            if error != nil {
                
                self.setDefaultExercises()
                
            } else if let httpResponse = response as? NSHTTPURLResponse {
                
                if httpResponse.statusCode == 404 || error != nil {
                    
                    println("\(httpResponse) \(error)")
                    
                    self.setDefaultExercises()
                    
                } else {
                    
                    if let dbExerciseArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray {
                        
                        for exerciseArray in dbExerciseArray {
                            if let dbExercises = exerciseArray["exercises"] as? [String]{
                                for exercise in dbExercises {
                                    defaultExercises.append(exercise)
                                }
                            }
                        }
                        
                    } else {
    
                        self.setDefaultExercises()
                    }
                    
                    
                }
                
            }
            
        })
        
        firstLoad = false
//        persist()
        
    }
    
    func setDefaultWorkouts() {
        
        workouts.append(["name":["Workout 1"], "time":["80"], "sets":["3"], "intensity":["83"], "warmup":["10"], "rest":["5"], "exercises":["pushups","squats","jumping jacks"], "exerciseTimes":["30","30","20"], "exerciseIntensities":["100","90","80"], "exerciseSets":["1","1","1"]])
        
        workouts.append(["name":["Workout 2"], "time":["40"], "sets":["8"], "intensity":["56"], "warmup":["10"], "rest":["5"], "exercises":["pushups","squats","jumping jacks","turkish getup","pullups","high knees","curls","crawl outs"], "exerciseTimes":["5","5","5","5","5","5","5","5"], "exerciseIntensities":["60","50","60","55","65","70","50","60"], "exerciseSets":["1","1","1","1","1","1","1","1"]])
        
    }
    
    func setDefaultExercises() {
        
        defaultExercises = ["pushups","situps","pullups","benchpress","squats"]
        
    }
    
    func persist() {
        
        var data: NSData = NSKeyedArchiver.archivedDataWithRootObject(workouts)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Workout", inManagedObjectContext: managedContext)
        let workoutSet = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        workoutSet.setValue(data, forKey: "workouts")
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
    }
    
    func fetch() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "Workout")
        fetchRequest.returnsObjectsAsFaults = false
        
        var error = NSError?()
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error)
        
        if let results = fetchedResults {
            for result: AnyObject in results {
                var data: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(result as! NSData)
                println(data)
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //fetch()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

