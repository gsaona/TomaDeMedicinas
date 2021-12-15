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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        dataSource = SwipeableDataSource(tableView: tableView) {
            tableView, indexPath, taking in

            let cell = tableView.dequeueReusableCell(withIdentifier: "takeListCell", for: indexPath) as! TakeTableViewCell
            let take = Database.shared.takes[indexPath.row]

            cell.profileNameLabel.text = take.profile
            cell.profileNameLabel.text = take.profile
            cell.medicationNameLabel.text = take.medicationName
            cell.dateLabel.text = take.formattedTakeDate
            cell.hourLabel.text = take.formattedTakeTime
            cell.quantity.text = String(format: "%.2f", take.quantity ?? 0)
            cell.unit.text = take.unitOfQuantity
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
//        let items = Database.shared.takes
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
    
    // MARK: - Navigation

    @IBSegueAction func addEditTake(_ coder: NSCoder, sender: Any?) -> TakeDetailTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let takeToEdit = Database.shared.takes[indexPath.row]
            return TakeDetailTableViewController(coder: coder, take: takeToEdit)
        } else {
            return TakeDetailTableViewController(coder: coder, take: nil)
        }
        
    }

    @IBAction func unwindFromTakingDetail(segue: UIStoryboardSegue) {
        
    }

}
