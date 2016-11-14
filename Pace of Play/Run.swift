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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var frontOrBack: UISegmentedControl!
    var selectedCourse: NSManagedObject!
    let formatTime = DateFormatter()
    var startTime: Date!
    var times = [Double]()
    var currentHole = -1
    var table: RunTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        times = modifyTimes()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Run.runThread), userInfo: nil, repeats: true)
    }
    
    func runThread(){
        DispatchQueue.global().async {
            let mod = (self.frontOrBack.selectedSegmentIndex == 0) ? 0 : 9
            let now = Date()
            for i in 0+mod...8+mod{
                if(self.startTime.addingTimeInterval(TimeInterval(self.times[i]*60)).compare(now) == ComparisonResult.orderedDescending){
                    self.currentHole = i + 1
                    break
                }
                if(i == 8+mod){
                    self.currentHole = i+1
                }
            }
            DispatchQueue.main.async {
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
        let holeTimes = selectedCourse.value(forKey: "holeTimes") as! [String]
        for i in 0...8{
            temp.append(0)
            for j in 0...i{
                if(Double(holeTimes[j]) != nil){
                    temp[i] += Double(holeTimes[j])!
                }
            }
        }
        for i in 9...17{
            temp.append(0)
            for j in 9...i{
                if(Double(holeTimes[j]) != nil){
                    temp[i] += Double(holeTimes[j])!
                }
            }
        }
        return temp
    }
    
    func load(){
        if(selectedCourse != nil){
            nameLabel.text = selectedCourse.value(forKey: "name") as? String
            formatTime.dateFormat = "h:mm a"
            startLabel.text = formatTime.string(from: startTime)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toTable" && selectedCourse != nil) {
            table = segue.destination as! RunTable
            table.holeTimes = selectedCourse.value(forKey: "holeTimes") as? [String]
            table.start = startTime
            table.front = frontOrBack.isEnabledForSegment(at: 0)
        }
        if(segue.identifier == "frontBackChange"){
            table.holeTimes = selectedCourse.value(forKey: "holeTimes") as? [String]
            table.start = startTime
            table.front = (frontOrBack.selectedSegmentIndex == 0) ? true : false
            runThread()
            table.modifyTimes()
            table.reload()
        }
    }
    
    @IBAction func clearKeyboard(){
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
