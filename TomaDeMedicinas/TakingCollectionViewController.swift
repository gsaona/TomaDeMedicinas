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
        print("Tomas contador: \(takingDaysAndQauntity.count)")
        return takingDaysAndQauntity.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TakingCollectionViewCell
        print(takingDaysAndQauntity[indexPath.item].date)
        cell.profileNameLabel.text = takingDaysAndQauntity[indexPath.item].profile.name.uppercased()
        cell.medicationNameLabel.text = takingDaysAndQauntity[indexPath.item].medicationName.name.uppercased()
        cell.dateLabel.text = takingDaysAndQauntity[indexPath.item].date
        cell.hourLabel.text = takingDaysAndQauntity[indexPath.item].hour
        cell.quantity.text = String(takingDaysAndQauntity[indexPath.item].quantity)
        return cell
    }

}
