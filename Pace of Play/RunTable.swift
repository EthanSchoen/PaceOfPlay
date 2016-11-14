//
//  RunTable.swift
//  Pace of Play
//
//  Created by Ethan Schoen on 7/1/16.
//  Copyright © 2016 Ethan Schoen. All rights reserved.
//

import UIKit

class RunTable: UITableViewController {
    
    var holeTimes: [String]!
    var modHoles = [Double]()
    var start: Date!
    var front: Bool!
    var mod: Int!
    
    func modifyTimes(){
        var temp = [Double]()
        mod = 0
        if(!front){ //if  back
            mod = 9
        }
        for i in 0...8{
            temp.append(0)
            for j in 0+mod...i+mod{
                if(Double(holeTimes[j]) != nil){
                    temp[i] += Double(holeTimes[j])!
                }
            }
        }
        modHoles = temp
    }
    
    func reload(){
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyTimes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "holes", for: indexPath)

        // Configure the cell...
        var temp = start
        temp = temp?.addingTimeInterval(TimeInterval(modHoles[indexPath.row]*60))
        let formater = DateFormatter()
        formater.dateFormat = "h:mm a"
        let time = formater.string(from: temp!)
        cell.textLabel?.text = "Hole \(indexPath.row+1+mod)-\(time)"
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
