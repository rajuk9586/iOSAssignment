//
//  PlayListVC.swift
//  iOS Assignment
//
//  Created by Raju Kumar on 07/09/23.
//

import UIKit

class ProductListVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var collectionVw: UICollectionView!
    
    var selectedImageView: UIImageView?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.collectionVw.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureCompositionalLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionVw.isHidden = false
        self.collectionVw.verticallyAnimateCollectionViewCells()
    }
    
    //MARK: - Functions
    //Register Nib
    private func registerCell() {
        self.collectionVw.translatesAutoresizingMaskIntoConstraints = false
        self.collectionVw.delegate = self
        self.collectionVw.dataSource = self
        self.collectionVw.register(UINib(nibName: "PlayListCVCell", bundle: nil), forCellWithReuseIdentifier: "PlayListCVCell")
    }
    
    //set layout of collection view
    private func configureCompositionalLayout() {
        let collection_layout = UICollectionViewCompositionalLayout {sectionIndex, environment in
            return Layouts.shared.productListLayout()
        }
        self.collectionVw.setCollectionViewLayout(collection_layout, animated: true)
    }
}

//MARK: Extensions
extension ProductListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayListCVCell", for: indexPath) as? PlayListCVCell else { fatalError("unable deque cell...")}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {
            fatalError("Storyboard does not contain the view controller...")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
