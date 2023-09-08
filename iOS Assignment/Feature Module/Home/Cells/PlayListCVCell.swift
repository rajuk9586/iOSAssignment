//
//  PlayListCVCell.swift
//  iOS Assignment
//
//  Created by Raju Kumar on 07/09/23.
//

import UIKit

class PlayListCVCell: UICollectionViewCell {
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var mainVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.playBtn.layer.cornerRadius = 25.0
        self.imgVw.layer.cornerRadius = 16.0
        self.mainVw.layer.cornerRadius = 24.0
    }
}
