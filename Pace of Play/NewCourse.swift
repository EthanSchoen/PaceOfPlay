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
    var textFields: [UITextField]?
    var holeTimes: [String] = []
    
    func save(_ tfs: [UITextField]?){
        textFields = tfs
        let name: String = nameField.text!
        
        for i in 0...17{
            holeTimes.append(textFields![i].text!)
        }
        
        //start save
        let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Courses", in: context)
        let course = NSManagedObject(entity: entity!, insertInto: context)
        course.setValue(name, forKey: "name")
        course.setValue(holeTimes, forKey: "holeTimes")
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is InputTable){
            let controller = segue.destination as! InputTable
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
