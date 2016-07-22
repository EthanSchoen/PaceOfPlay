//
//  InputTable.swift
//  Pace of Play
//
//  Created by Ethan Schoen on 7/1/16.
//  Copyright © 2016 Ethan Schoen. All rights reserved.
//

import UIKit

protocol DetailsDelegate: class {
    func save(tfs: [UITextField]?)
}

class InputTable: UITableViewController {

    var delegate: DetailsDelegate?
    var tfs: [UITextField]!
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.save(tfs)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        tfs = []
        for _ in 0...17{
            let tf = UITextField(frame: CGRectMake(80, 5, 100, 35))
            tf.borderStyle = UITextBorderStyle.RoundedRect
            tf.textColor = UIColor.blackColor()
            tf.placeholder = "Minutes"
            tf.keyboardType = UIKeyboardType.NumberPad
            tfs.append(tf)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inputCell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "Hole \(indexPath.row + 1):"
        cell.addSubview(tfs[indexPath.row])
        return cell
    }
}
