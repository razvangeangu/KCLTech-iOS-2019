//
//  ReminderTableViewController.swift
//  iRemember
//
//  Created by Răzvan-Gabriel Geangu on 12/11/2018.
//  Copyright © 2018 Răzvan-Gabriel Geangu. All rights reserved.
//

import UIKit
import CoreData

class ReminderTableViewController: UITableViewController {
    
    var resultsController: NSFetchedResultsController<Reminder>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let request: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        request.sortDescriptors = [sortDescriptor]

        resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            completion(true)
        }
        // action.image = #trash
        action.title = "Delete"
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Check") { (action, view, completion) in
            completion(true)
        }
        // action.image = #trash
        action.title = "Done"
        action.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [action])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
