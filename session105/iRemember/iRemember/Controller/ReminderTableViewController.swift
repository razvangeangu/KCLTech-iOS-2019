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
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didStartRefreshing), for: .valueChanged)
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let request: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        request.sortDescriptors = [sortDescriptor]

        resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        resultsController.delegate = self
        
        do {
            try resultsController.performFetch()
        } catch {
            print("Perform fetch request error: \(error)")
        }
    }
    
    @objc func didStartRefreshing() {
        // tableView.refreshControl?.beginRefreshing()
        
        tableView.refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController.sections?[section].objects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)
        
        let reminder = resultsController.object(at: indexPath)
        cell.textLabel?.text = reminder.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let reminder = self.resultsController.object(at: indexPath)
            self.resultsController.managedObjectContext.delete(reminder)
            
            do {
                try self.resultsController.managedObjectContext.save()
                completion(true)
            } catch {
                print("Error deleting reminder: \(error)")
                completion(false)
            }
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showAddReminder" {
            guard let destinationVC = segue.destination as? AddReminderViewController else { return }
            destinationVC.managedContext = resultsController.managedObjectContext
        }
    }

}

extension ReminderTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = newIndexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
}
