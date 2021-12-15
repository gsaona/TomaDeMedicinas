//
//  TakingListTableViewController.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 9/12/21.
//

import UIKit
import CoreData

private class SwipeableDataSource: UITableViewDiffableDataSource<Int,Take> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

class TakeListTableViewController: UITableViewController {
    
    fileprivate var dataSource: SwipeableDataSource!
    
//    static let editNameSegue = "editTake"
    static let addNameSegue = "addTakes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        dataSource = SwipeableDataSource(tableView: tableView) {
            tableView, indexPath, taking in

            let cell = tableView.dequeueReusableCell(withIdentifier: "takeListCell", for: indexPath)
            let take = Database.shared.takes[indexPath.row]

            cell.textLabel?.text = take.profile
            cell.detailTextLabel?.text = take.formattedTakeDate
//            taking.medicationName
            return cell
        }

        tableView.dataSource = dataSource

        updateSnapshot()

        NotificationCenter.default.addObserver(forName: Database.takeUpdatedNotification, object: nil, queue: nil)
        { _ in
            self.updateSnapshot()
        }
    }

    // MARK: - Table view data source
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Take>()
        snapshot.appendSections([0])
        snapshot.appendItems(Database.shared.takes, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
   
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            contextualAction, view, completationHandler in
            guard let takeToDelete = self.dataSource.itemIdentifier(for: indexPath) else { return }
            Database.shared.delete(take: takeToDelete)
            Database.shared.save()
            self.updateSnapshot()
            completationHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editTake", sender: indexPath)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = sender as? IndexPath, segue.identifier == "editTake" {
        
            let navigationController = segue.destination as? UINavigationController
            let takeDetailTableViewController = navigationController?.viewControllers.first as? TakeDetailTableViewController
//            takeDetailTableViewController?.take = Database.shared.takes[indexPath.row]
            takeDetailTableViewController?.take = self.dataSource.itemIdentifier(for: indexPath)
        }
    }
    
    @IBAction func unwindFromTakingDetail(segue: UIStoryboardSegue) {
        
    }

}
