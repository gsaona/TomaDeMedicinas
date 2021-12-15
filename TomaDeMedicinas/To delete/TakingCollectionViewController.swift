//
//  TakingCollectionViewController.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 30/11/21.
//

import UIKit
import CoreData

private let reuseIdentifier = "TakesByProfileCells"

private class SwipeableDataSource: UITableViewDiffableDataSource<Int, Take> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

class TakingCollectionViewController: UICollectionViewController {
    
    fileprivate var dataSource: SwipeableDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
}
    
    private func generateLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        let bigSpacing: CGFloat = 20
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = bigSpacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Tomas contador: \(Database.shared.takes.count)")
        return Database.shared.takes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TakingCollectionViewCell
        cell.profileNameLabel.text = Database.shared.takes[indexPath.item].profile!.uppercased()
        cell.medicationNameLabel.text = Database.shared.takes[indexPath.item].medicationName!.uppercased()
//        cell.dateLabel.text = Database.shared.takings[indexPath.item].formattedTakingDate
//        cell.hourLabel.text = Database.shared.takings[indexPath.item].hour
        cell.quantity.text = String(Database.shared.takes[indexPath.item].quantity!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editTakings", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath, segue.identifier == "editTake" {
            let navigationController = segue.destination as? UINavigationController
            let takeDetailTableViewController = navigationController?.viewControllers.first as? TakeDetailTableViewController
//            var taking = self.takings
//            takingDetailTableViewController?.taking = Database.shared.items[indexPath.row]
            takeDetailTableViewController?.take = Database.shared.takes[indexPath.row]
        }
    }
}
