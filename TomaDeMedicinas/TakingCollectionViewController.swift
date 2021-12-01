//
//  TakingCollectionViewController.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 30/11/21.
//

import UIKit

private let reuseIdentifier = "TakingsByProfileCells"

class TakingCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        
        if let loadData = TakingsOfMedication.loadData() {
            items = loadData
        } else {
            items = TakingsOfMedication.sampleTaking()
        }
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
        print("Tomas contador: \(items.count)")
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TakingCollectionViewCell
        print(items[indexPath.item].date)
        cell.profileNameLabel.text = items[indexPath.item].profile.name.uppercased()
        cell.medicationNameLabel.text = items[indexPath.item].medicationName.name.uppercased()
        cell.dateLabel.text = items[indexPath.item].date
        cell.hourLabel.text = items[indexPath.item].hour
        cell.quantity.text = String(items[indexPath.item].quantity)
        return cell
    }

}
