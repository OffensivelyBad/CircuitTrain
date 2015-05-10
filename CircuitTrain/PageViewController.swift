//
//  PageViewController.swift
//  CircuitTrain
//
//  Created by Shawn Roller on 5/6/15.
//  Copyright (c) 2015 OffensivelyBad. All rights reserved.
//

import UIKit

var contentExercises = editingWorkout["exercises"]!
var contentTime = editingWorkout["exerciseTimes"]!
var contentSets = editingWorkout["exerciseSets"]!

class PageViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController?
    
    var firstItem:Int = exerciseNumber
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if firstItem >= contentExercises.count {
            
            self.addNew(firstItem)
            
        }
        
        createPageViewController()
        setupPageControl()
    }
    
    func addNew(newIndex: Int) {
        
        contentExercises.append(defaultExercises[0])
        contentTime.append("0")
        contentSets.append("1")
        
        editingWorkout["exercises"] = contentExercises
        editingWorkout["exerciseTimes"] = contentTime
        editingWorkout["exerciseSets"] = contentSets
        
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentExercises.count > 0 {
            let firstController = getItemController(firstItem)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! NewExerciseViewController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! NewExerciseViewController
        
        if itemController.itemIndex+1 < contentExercises.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> NewExerciseViewController? {
        
        if itemIndex < contentExercises.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("NewExerciseViewController") as! NewExerciseViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.exerciseName = contentExercises[itemIndex]
            pageItemController.exerciseTime = contentTime[itemIndex]
            pageItemController.exerciseSets = contentSets[itemIndex]
            exerciseNumber = itemIndex
            
            return pageItemController
        }
        
        return nil
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentExercises.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return exerciseNumber
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
