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

        if let exercises = editingWorkout["exercises"] {
        
            tableView.setEditing(true, animated: false)
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        return tableViewCell
        
    }
    
    @IBAction func add(sender: AnyObject) {
        
        
        
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
