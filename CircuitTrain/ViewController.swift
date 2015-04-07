//
//  ViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 4/7/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var editDoneButton: UIBarButtonItem!
    @IBOutlet weak var workoutListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableViewCell = UITableViewCell()
        
        return tableViewCell
        
    }
    
    @IBAction func addNewWorkout(sender: AnyObject) {
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

