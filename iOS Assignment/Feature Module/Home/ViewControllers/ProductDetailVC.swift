//
//  OpenListVC.swift
//  iOS Assignment
//
//  Created by Raju Kumar on 07/09/23.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var downloadBtnVw: UIStackView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var progressVwTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var downloadProgressLbl: UILabel!
    @IBOutlet weak var downloadProgressVw: UIView!
    @IBOutlet weak var cancelDownloadBtn: UIButton!
    @IBOutlet weak var cancelDownloadVw: UIView!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var collectionVw: UICollectionView!
    
    //MARK: - Variables
    private var isDownloadCancelled = false
    var isBlinking = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.registerCell()
        self.configureCompositionalLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionVw.isHidden = false
        self.collectionVw.animateCollectionViewCells()
    }
    
    //MARK: - Functions
    //Register Nib
    private func registerCell() {
        self.collectionVw.translatesAutoresizingMaskIntoConstraints = false
        self.collectionVw.delegate = self
        self.collectionVw.dataSource = self
        self.collectionVw.register(UINib(nibName: "ProductDetailsCVCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailsCVCell")
    }
    
    //set layout of Collection view
    private func configureCompositionalLayout() {
        let collection_layout = UICollectionViewCompositionalLayout {sectionIndex, environment in
            return Layouts.shared.productDetailLayout()
        }
        self.collectionVw.setCollectionViewLayout(collection_layout, animated: true)
    }
    
    //setInitial Layout
    private func setUI() {
        self.collectionVw.isHidden = true
        self.detailLbl.numberOfLines = 2
        self.progressVwTrailingConstraint.constant = self.view.frame.size.width - 85
        self.downloadProgressVw.isHidden = true
        self.cancelDownloadVw.isHidden = true
        self.cancelDownloadBtn.isSelected = false
        self.cancelDownloadBtn.isUserInteractionEnabled = true
        self.downloadBtnVw.isHidden = false
        self.playBtn.isHidden = true
        self.playBtn.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)
    }
    
    //Animation
    private func animateProgressVw() {
        UIView.animate(withDuration: 2.0, animations: {
            // Change the view's position or properties you want to animate
            self.progressVwTrailingConstraint.constant -= (self.view.frame.size.width - 85) / 3
            self.view.layoutIfNeeded()
        }) { (completed) in
            // This completion block is called when the animation finishes
            if !self.isDownloadCancelled {
                self.downloadProgressLbl.text = "10 MB / 30 MB"
                UIView.animate(withDuration: 1.0, animations: {
                    // Change the view's position or properties you want to animate
                    self.progressVwTrailingConstraint.constant -= (self.view.frame.size.width - 85) / 3
                    self.view.layoutIfNeeded() // Force layout update
                }) { (completed) in
                    // This completion block is called when the animation finishes
                    if !self.isDownloadCancelled {
                        self.downloadProgressLbl.text = "15 MB / 30 MB"
                        UIView.animate(withDuration: 1.0, animations: {
                            // Change the view's position or properties you want to animate
                            self.progressVwTrailingConstraint.constant -= (self.view.frame.size.width - 85) / 3
                            self.view.layoutIfNeeded() // Force layout update
                        }) { (completed) in
                            // This completion block is called when the animation finishes
                            if !self.isDownloadCancelled {
                                self.downloadProgressLbl.text = "30 MB / 30 MB"
                                self.cancelDownloadBtn.isSelected = true
                                self.cancelDownloadBtn.isUserInteractionEnabled = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    UIView.animate(withDuration: 0.5) {
                                        // Slide down view2
                                        self.downloadBtnVw.isHidden = true
                                        self.downloadBtnVw.alpha = 0
                                        
                                        // Slide up view1
                                        self.playBtn.isHidden = false
                                        self.playBtn.alpha = 1
                                    }
                                    UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                                        self.playBtn.transform = .identity // Final scale (1.0)
                                    }, completion: nil)
                                    self.isBlinking = true
                                    UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveEaseInOut, .autoreverse, .allowUserInteraction, .repeat], animations: {
                                        // Blinking effect
                                        self.playBtn.alpha = 0.8 // Fade out
                                    }, completion: nil)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
   private func stopBlinking() {
       if self.isBlinking {
           self.isBlinking = false
                self.playBtn.layer.removeAllAnimations()
                self.playBtn.alpha = 1
            }
        }
    
    //MARK: - IBActions
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickDownload(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.isDownloadCancelled = false
            self.downloadBtn.backgroundColor = UIColor(red: 151/255, green: 214/255, blue: 79/255, alpha: 0.6)
            self.downloadProgressVw.isHidden = false
            self.cancelDownloadVw.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.animateProgressVw()
            }
        }
    }
    
    @IBAction func onClickCancelDownload(_ sender: UIButton) {
        if !cancelDownloadBtn.isSelected {
            self.isDownloadCancelled = true
            self.downloadBtn.backgroundColor = UIColor(red: 151/255, green: 214/255, blue: 79/255, alpha: 1.0)
            self.downloadProgressVw.isHidden = true
            self.progressVwTrailingConstraint.constant = self.view.frame.size.width - 85
            self.view.layoutIfNeeded()
            self.downloadProgressLbl.text = "Download \n30 MB"
            self.cancelDownloadVw.isHidden = true
            self.cancelDownloadBtn.isSelected = false
            self.cancelDownloadBtn.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func onClickPlay(_ sender: Any) {
        print("Stop Blinking")
        self.stopBlinking()
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "OrderVC") as? OrderVC else {
            fatalError("Storyboard does not contain the view controller...")
        }
        vc.closureConfirm = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func onClickReadmore(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.detailLbl.numberOfLines = 0
        }else {
            self.detailLbl.numberOfLines = 2
        }
    }
}

//MARK: Extensions
extension ProductDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCVCell", for: indexPath) as? ProductDetailsCVCell else { fatalError("unable deque cell...")}
        return cell
    }
}

