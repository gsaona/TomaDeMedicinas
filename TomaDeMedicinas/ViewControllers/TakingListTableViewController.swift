//
//  TakingListTableViewController.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 9/12/21.
//

import UIKit
import CoreData

private class SwipeableDataSource: UITableViewDiffableDataSource<Int,Taking> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

class TakingListTableViewController: UITableViewController {
    
    fileprivate var dataSource: SwipeableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        dataSource = SwipeableDataSource(tableView: tableView) {
            tableView, indexPath, taking in

            let cell = tableView.dequeueReusableCell(withIdentifier: "takingListCell", for: indexPath)
            let taking = Database.shared.takings[indexPath.row]

            cell.textLabel?.text = taking.profile
            cell.detailTextLabel?.text = taking.medicationName
            return cell
        }

        tableView.dataSource = dataSource

        updateSnapshot()

        NotificationCenter.default.addObserver(forName: Database.takingUpdatedNotification, object: nil, queue: nil)
        { _ in
            self.updateSnapshot()
        }
    }

    // MARK: - Table view data source
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Taking>()
        snapshot.appendSections([0])
        snapshot.appendItems(Database.shared.takings, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
   
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            contextualAction, view, completationHandler in
            guard let taking = self.dataSource.itemIdentifier(for: indexPath) else { return }
            Database.shared.delete(taking: taking)
            Database.shared.save()
            self.updateSnapshot()
            completationHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editTakings", sender: indexPath)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath, segue.identifier == "editTakings" {
            
            let navigationController = segue.destination as? UINavigationController
            let takingDetailTableViewController = navigationController?.viewControllers.first as? TakingDetailTableViewController
            takingDetailTableViewController?.taking = Database.shared.takings[indexPath.row]
        }
    }
    
    @IBAction func unwindFromTakingDetail(segue: UIStoryboardSegue) {}

}
