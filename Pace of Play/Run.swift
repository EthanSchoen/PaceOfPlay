//
//  Run.swift
//  Pace of Play
//
//  Created by Ethan Schoen on 7/1/16.
//  Copyright © 2016 Ethan Schoen. All rights reserved.
//

import UIKit
import CoreData

class Run: UIViewController{
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var frontBackLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var selectedCourse: NSManagedObject!
    let formatTime = NSDateFormatter()
    var startTime: NSDate!
    var times = [Double]()
    var currentHole = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        times = modifyTimes()
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Run.runThread), userInfo: nil, repeats: true)
    }
    
    func runThread(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let now = NSDate()
            for i in 0...self.times.count-1{
                if(self.startTime.dateByAddingTimeInterval(NSTimeInterval(self.times[i]*60)).compare(now) == NSComparisonResult.OrderedDescending){
                    self.currentHole = i + 1
                    break
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                if(self.currentHole != -1){
                    self.statusLabel.text = "You should be on Hole \(self.currentHole)"
                }else{
                    self.statusLabel.text = "Please create new course with hole times"
                }
            }
        }
    }
    
    func modifyTimes()->[Double]{
        var temp = [Double]()
        let holeTimes = selectedCourse.valueForKey("holeTimes") as! [String]
        for i in 0...holeTimes.count-1{
            temp.append(0)
            for j in 0...i{
                if(Double(holeTimes[j]) != nil){
                    temp[i] += Double(holeTimes[j])!
                }
            }
        }
        return temp
    }
    
    func load(){
        if(selectedCourse != nil){
            nameLabel.text = selectedCourse.valueForKey("name") as? String
            frontBackLabel.text = (selectedCourse.valueForKey("front") as! Bool) ? "Front" : "Back"
            formatTime.dateFormat = "h:mm a"
            startLabel.text = formatTime.stringFromDate(startTime)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toTable") {
            let table = segue.destinationViewController as! RunTable
            table.holeTimes = selectedCourse.valueForKey("holeTimes") as? [String]
            table.start = startTime
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}