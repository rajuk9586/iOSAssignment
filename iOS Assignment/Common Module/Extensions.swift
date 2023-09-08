//
//  Extensions.swift
//  iOS Assignment
//
//  Created by Raju Kumar on 07/09/23.
//

import Foundation
import UIKit


extension UICollectionView {
    func animateCollectionViewCells() {
        let visibleCells = self.visibleCells
        
        for (index, cell) in visibleCells.enumerated() {
            cell.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
            UIView.animate(withDuration: 2.0, delay: 0.1 * Double(index), usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    func verticallyAnimateCollectionViewCells() {
        let visibleCells = self.visibleCells
        
        for (index, cell) in visibleCells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
            UIView.animate(withDuration: 1.0, delay: 0.1 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
}
