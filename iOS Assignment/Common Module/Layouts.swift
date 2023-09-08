//
//  Layouts.swift
//  iOS Assignment
//
//  Created by Raju Kumar on 07/09/23.
//

import Foundation
import UIKit

class Layouts {
    static let shared = Layouts()
    
     func productListLayout() -> NSCollectionLayoutSection {
        //item
        let item_size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: item_size)
        
        //Group
        let group_size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: group_size, subitems: [item])
        
        //spacing between cells
        group.interItemSpacing = .fixed(20)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    func productDetailLayout() -> NSCollectionLayoutSection {
        //item
        let item_size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: item_size)
        
        //Group
        let group_size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: group_size, subitems: [item])
        
        //spacing between cells
        group.interItemSpacing = .fixed(8)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func captchaLayout() -> NSCollectionLayoutSection {
        //item
        let item_size = NSCollectionLayoutSize(widthDimension: .absolute(80), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: item_size)
        
        //Group
        let group_size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: group_size, subitems: [item])
        
        //spacing between cells
        group.interItemSpacing = .fixed(20)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func readyToPlayLayout() -> NSCollectionLayoutSection {
        //item
        let item_size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: item_size)
        
        //Group
        let group_size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: group_size, subitems: [item])
        
        //spacing between cells
        group.interItemSpacing = .fixed(10)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}
