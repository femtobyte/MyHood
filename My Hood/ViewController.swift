//
//  ViewController.swift
//  My Hood
//
//  Created by C Sinclair on 12/3/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //loads the posts that are saved on disc
        DataService.instance.loadPosts()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = DataService.instance.loadedPosts[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell{
            cell.configureCell(post)
            return cell
        } else {
            //creates and configures a new cell if the tableView doesn't give you a recycled one
            let cell = PostCell()
            cell.configureCell(post)
            return cell
        }
    }
    
    // can eliminate this func by adding a line in viewDidLoad: tableView.estimatedRowHeight = 115.  This allows cell to grow and shrink
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 115.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func onPostsLoaded(notif: AnyObject){
        tableView.reloadData()
    }
    
    /*
    // implement this when you want user to be able to select a row to load new view, new data  - when you select a row and it takes you somewhere else.
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        <#code#>
    }
    */
}

