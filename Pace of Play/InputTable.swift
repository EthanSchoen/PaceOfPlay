//
//  InputTable.swift
//  Pace of Play
//
//  Created by Ethan Schoen on 7/1/16.
//  Copyright © 2016 Ethan Schoen. All rights reserved.
//

import UIKit

protocol DetailsDelegate: class {
    func save(_ tfs: [UITextField]?)
}

class InputTable: UITableViewController {

    var delegate: DetailsDelegate?
    var tfs: [UITextField]!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.save(tfs)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        tfs = []
        for _ in 0...17{
            let tf = UITextField(frame: CGRect(x: 80, y: 5, width: 100, height: 35))
            tf.borderStyle = UITextBorderStyle.roundedRect
            tf.textColor = UIColor.black
            tf.placeholder = "Minutes"
            tf.keyboardType = UIKeyboardType.numberPad
            tfs.append(tf)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "Hole \(indexPath.row + 1):"
        cell.addSubview(tfs[indexPath.row])
        return cell
    }
}
