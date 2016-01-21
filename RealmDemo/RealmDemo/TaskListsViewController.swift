//
//  TaskListsViewController.swift
//  RealmDemo
//
//  Created by mengxiangjian on 16/1/21.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

import UIKit
import RealmSwift

class TaskListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var lists : Results<TaskList>!
    var isEditingMode = false
    var currentCreateAction:UIAlertAction!
    @IBOutlet weak var taskListsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let library = NSSearchPathForDirectoriesInDomains(.LibraryDirectory,
            .UserDomainMask, true)
        print(library)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 读取taskLists并且刷新UI
        readTasksAndUpdateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Fetch TaskLists -
    
    func readTasksAndUpdateUI() {
        lists = uiRealm.objects(TaskList)
        self.taskListsTableView.setEditing(false, animated: true)
        taskListsTableView.reloadData()
    }
    
    func displayAlertToAddTaskList(updatedList:TaskList!) {
        
        var title = "New Tasks List"
        var doneTitle = "Create"
        if updatedList != nil{
            title = "Update Tasks List"
            doneTitle = "Update"
        }
        
        let alertController = UIAlertController(title: title,
            message: "Write the name of your tasks list.",
            preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: doneTitle,
            style: .Default) { action in
                let firstName = alertController.textFields?.first?.text
                
                if let name = firstName {
                    if updatedList != nil {
                        // 更新
                        try! uiRealm.write({ () -> Void in
                            updatedList.name = name
                            self.readTasksAndUpdateUI()
                        })
                        
                    } else {
                        // 新增
                        let tasklist = TaskList()
                        tasklist.name = name
                        try! uiRealm.write({ () -> Void in
                            uiRealm.add(tasklist)
                            self.readTasksAndUpdateUI()
                        })
                    }
                }
        }
        alertController.addAction(alertAction)
        
        alertAction.enabled = false
        self.currentCreateAction = alertAction
        
        alertController.addAction(UIAlertAction(title: "Cancel",
            style: .Cancel, handler: nil))
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Task List Name"
            textField.addTarget(self, action: "listNameFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            if updatedList != nil{
                textField.text = updatedList.name
            }
        }
        
        self.presentViewController(alertController,
            animated: true, completion: nil)
    }
    
    func listNameFieldDidChange(sender : AnyObject) {
        let textField : UITextField = sender as! UITextField
        self.currentCreateAction.enabled = textField.text?.characters.count > 0
    }
    
    @IBAction func didSelectSortCriteria(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            
            // A-Z
            self.lists = self.lists.sorted("name")
        }
        else{
            // date
            self.lists = self.lists.sorted("createdAt", ascending:false)
        }
        self.taskListsTableView.reloadData()
    }
    
    @IBAction func didClickOnEditButton(sender: UIBarButtonItem) {
        isEditingMode = !isEditingMode
        self.taskListsTableView.setEditing(isEditingMode, animated: true)
    }
    
    @IBAction func didClickOnAddButton(sender: UIBarButtonItem) {
        displayAlertToAddTaskList(nil)
    }
    
    // MARK: UITableViewDataSource & UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let listsTasks = lists{
            return listsTasks.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell")
        
        let list = lists[indexPath.row]
        
        cell?.textLabel?.text = list.name
        cell?.detailTextLabel?.text = "\(list.tasks.count) Tasks"
        return cell!
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            
            let listToBeDeleted = self.lists[indexPath.row]
            try! uiRealm.write({ () -> Void in
                uiRealm.delete(listToBeDeleted)
                self.readTasksAndUpdateUI()
                })
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in
            
            // Editing will go here
            let listToBeUpdated = self.lists[indexPath.row]
            self.displayAlertToAddTaskList(listToBeUpdated)
            
        }
        return [deleteAction, editAction]
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("openTasks", sender: self.lists[indexPath.row])
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tasksVC = segue.destinationViewController as! TasksViewController
        let tasks = sender as! TaskList
        tasksVC.selectedList = tasks
    }

}
