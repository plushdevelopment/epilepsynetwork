//
//  JournalViewController.swift
//  EpilepsyUnited
//
//  Created by Pratikbhai Patel on 4/25/15.
//  Copyright (c) 2015 Pratikbhai Patel. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController {

    private var dataArray = [AnyObject]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let filePath = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        let data = NSData(contentsOfFile: filePath!)
        var error: NSError?
        let jsonData: AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        if !(error != nil) {
            for data in jsonData as! NSArray {
                let data1 = data as! NSDictionary
                dataArray.append(data1)
            }
        } else {
            println("There was an error")
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension JournalViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostTableViewCell
        cell.userLabel.text = (dataArray[indexPath.row] as! NSDictionary).objectForKey("user") as? String
        cell.postLabel.text = (dataArray[indexPath.row] as! NSDictionary).objectForKey("text") as? String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM.dd.yy (hh:mm a)" // superset of OP's format
        cell.timestampLabel.text = dateFormatter.stringFromDate(NSDate())
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
}

extension JournalViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected something")
    }
}

