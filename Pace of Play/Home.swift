//
//  Home.swift
//  Pace of Play
//
//  Created by Ethan Schoen on 7/1/16.
//  Copyright © 2016 Ethan Schoen. All rights reserved.
//

import UIKit
import CoreData

class Home: UIViewController {
    
    var viewItems = [String]()
    var viewObj = [NSManagedObject]()
    @IBOutlet weak var picker: UIPickerView!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toRun" && viewObj.count != 0) {
            let run = (segue.destinationViewController as! Run)
            run.startTime = NSDate()
            for obj in viewObj {
                let selName = viewItems[picker.selectedRowInComponent(0)]
                if(obj.valueForKey("name") as! String == selName){
                    run.selectedCourse = obj
                }
            }
        }
    }
    
    @IBAction func deleteButton(button: UIButton) {
        if(viewItems.count == 0){return}
        let currentVal = picker.selectedRowInComponent(0)
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        context.deleteObject(viewObj[currentVal])
        viewItems.removeAtIndex(currentVal)
        viewObj.removeAtIndex(currentVal)
        picker.reloadAllComponents()
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //viewItems.removeAll()
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Courses")
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            viewObj = results as! [NSManagedObject]
            if(viewObj.count == 0){return}
            for i in 0...viewObj.count-1{
                viewItems.append(viewObj[i].valueForKey("name") as! String)
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewItems.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return viewItems[row]
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