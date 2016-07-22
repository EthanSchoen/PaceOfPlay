//
//  ViewController.swift
//  Pace of Play
//
//  Created by Ethan Schoen on 6/26/16.
//  Copyright © 2016 Ethan Schoen. All rights reserved.
//

import UIKit
import CoreData

class NewCourse: UIViewController, DetailsDelegate{
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var frontOrBack: UISegmentedControl!
    var textFields: [UITextField]?
    var holeTimes: [String] = []
    
    func save(tfs: [UITextField]?){
        textFields = tfs
        let name: String = nameField.text!
        let front: Bool = (frontOrBack.selectedSegmentIndex == 0) ? true : false
        
        for i in 0...17{
            holeTimes.append(textFields![i].text!)
        }
        
        //start save
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName("Courses", inManagedObjectContext: context)
        let course = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)
        course.setValue(name, forKey: "name")
        course.setValue(front, forKey: "front")
        course.setValue(holeTimes, forKey: "holeTimes")
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is InputTable){
            let controller = segue.destinationViewController as! InputTable
            controller.delegate = self
        }
    }
    
    @IBAction func clearKeyboard(){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}