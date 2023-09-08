//
//  OrderVC.swift
//  iOS Assignment
//
//  Created by Raju Kumar on 07/09/23.
//

import UIKit

class OrderVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var transparentVw: UIView!
    @IBOutlet weak var oswaldlbl: UILabel!
    @IBOutlet weak var readytoPlayLbl: UILabel!
    @IBOutlet weak var readytoPlayVw: UIView!
    @IBOutlet weak var readytoPlayCollectionVw: UICollectionView!
    @IBOutlet weak var captchaVw: UIView!
    @IBOutlet weak var walletVw: UIView!
    @IBOutlet weak var captchaLbl: UILabel!
    @IBOutlet weak var captchaCollectionVw: UICollectionView!
    @IBOutlet weak var offerCollectionVw: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var offersVw: UIView!
    
    //MARK: - Variables
    var view_count = 1
    var closureConfirm : (()->())?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.registerCell()
        self.configureCompositionalLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentVw.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.offerCollectionVw.isHidden = false
        self.offerCollectionVw.animateCollectionViewCells()
    }
    
    //MARK: - Functions
    //Register Nib
    private func registerCell() {
        self.captchaCollectionVw.translatesAutoresizingMaskIntoConstraints = false
        self.captchaCollectionVw.delegate = self
        self.captchaCollectionVw.dataSource = self
        self.readytoPlayCollectionVw.translatesAutoresizingMaskIntoConstraints = false
        self.readytoPlayCollectionVw.delegate = self
        self.readytoPlayCollectionVw.dataSource = self
        self.offerCollectionVw.translatesAutoresizingMaskIntoConstraints = false
        self.offerCollectionVw.delegate = self
        self.offerCollectionVw.dataSource = self
        self.offerCollectionVw.register(UINib(nibName: "OffersCVCell", bundle: nil), forCellWithReuseIdentifier: "OffersCVCell")
        self.captchaCollectionVw.register(UINib(nibName: "CaptchaCVCell", bundle: nil), forCellWithReuseIdentifier: "CaptchaCVCell")
        self.readytoPlayCollectionVw.register(UINib(nibName: "CaptchaCVCell", bundle: nil), forCellWithReuseIdentifier: "CaptchaCVCell")
    }
    
    //set layout of collection view
    private func configureCompositionalLayout() {
        let collection_layout = UICollectionViewCompositionalLayout {sectionIndex, environment in
            return Layouts.shared.productDetailLayout()
        }
        let collection_layout_2 = UICollectionViewCompositionalLayout {sectionIndex, environment in
            return Layouts.shared.captchaLayout()
        }
        let collection_layout_3 = UICollectionViewCompositionalLayout {sectionIndex, environment in
            return Layouts.shared.readyToPlayLayout()
        }
        self.offerCollectionVw.setCollectionViewLayout(collection_layout, animated: true)
        self.captchaCollectionVw.setCollectionViewLayout(collection_layout_2, animated: true)
        self.readytoPlayCollectionVw.setCollectionViewLayout(collection_layout_3, animated: true)
    }
    
    //setInitial Layout
    private func setUI() {
        self.offerCollectionVw.isHidden = true
        self.readytoPlayCollectionVw.isHidden = true
        self.captchaCollectionVw.isHidden = true
        self.captchaVw.isHidden = true
        self.readytoPlayVw.isHidden = true
        self.walletVw.isHidden = true
        self.captchaLbl.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.readytoPlayLbl.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        self.oswaldlbl.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    }
    
    //MARK: - IBActions
    @IBAction func onClickNext(_ sender: Any) {
        if self.view_count == 1 {
            self.view_count += 1
            self.offersVw.isHidden = true
            self.captchaVw.isHidden = false
            self.captchaCollectionVw.isHidden = false
            self.walletVw.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.captchaCollectionVw.animateCollectionViewCells()
            self.walletVw.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                self.walletVw.transform = .identity // Final scale (1.0)
                self.captchaLbl.transform = .identity
            }, completion: nil)
        }else if self.view_count == 2 {
            self.view_count += 1
            self.readytoPlayVw.isHidden = false
            self.nextBtn.setTitle("Confirm", for: .normal)
            self.nextBtn.backgroundColor = .darkGray
            self.captchaVw.isHidden = true
            self.readytoPlayCollectionVw.isHidden = false
            self.readytoPlayCollectionVw.animateCollectionViewCells()
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                self.oswaldlbl.transform = .identity // Final scale (1.0)
                self.readytoPlayLbl.transform = .identity
            }, completion: nil)
        }else {
            self.dismiss(animated: true)
            self.closureConfirm?()
        }
    }
}

//MARK: Extensions
extension OrderVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.offerCollectionVw:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCVCell", for: indexPath) as? OffersCVCell else { fatalError("unable deque cell...")}
            return cell
        case self.captchaCollectionVw:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaptchaCVCell", for: indexPath) as? CaptchaCVCell else { fatalError("unable deque cell...")}
            cell.imgvw.isHidden = true
            cell.txtLbl.isHidden = false
            if indexPath.row == 0 {
                cell.contentView.backgroundColor = UIColor(red: 151/255, green: 214/255, blue: 79/255, alpha: 1.0)
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaptchaCVCell", for: indexPath) as? CaptchaCVCell else { fatalError("unable deque cell...")}
            cell.txtLbl.isHidden = true
            cell.imgvw.isHidden = false
            return cell
        }
    }
}
