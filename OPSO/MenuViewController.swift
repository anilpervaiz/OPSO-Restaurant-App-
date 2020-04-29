//
//  MenuViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/6/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import EasyPeasy
import Alamofire


class MenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    let imagesCellId = "bannersCellId"
    let menuCellId = "menuCellId"
    let homeProductCellId = "homeProductCellId"
    
    let imageArray = ["banner", "banner","banner", "banner", "banner"]
    let categorisArray = ["DiningBg", "PriveBg","SocialBg"]
    let categorisTitle = ["DiningText", "PriveText","SocialText"]
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(BannersCell.self, forCellWithReuseIdentifier: imagesCellId)
        // cv.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        
        
        return cv
    }()
    
    
    let MainFullView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.black
        return topView
        
    }()
    
    @IBOutlet var diningImage: UIImageView!
    @IBOutlet var priveImage: UIImageView!
    @IBOutlet var socialImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SetupMainView()
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapGesture1))
           let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapGesture2))
           let tap3 = UITapGestureRecognizer(target: self, action: #selector(tapGesture3))
        diningImage.addGestureRecognizer(tap1)
        diningImage.isUserInteractionEnabled = true
        priveImage.addGestureRecognizer(tap2)
        priveImage.isUserInteractionEnabled = true
        socialImage.addGestureRecognizer(tap3)
        socialImage.isUserInteractionEnabled = true
    }
    @objc func tapGesture1() {
        
      
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuIdentifier") as! MenuSubViewController
    
   secondViewController.stringPassed = "dining"
        self.navigationController?.pushViewController(secondViewController, animated: true)

    }
    @objc func tapGesture2() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuIdentifier") as! MenuSubViewController
         secondViewController.stringPassed = "prive"
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    @objc func tapGesture3() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuIdentifier") as! MenuSubViewController
         secondViewController.stringPassed = "social"
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
      
        
        
       
    
    func SetupMainView()  {
        
        view.addSubview(MainFullView)
        MainFullView.easy.layout(
            Top(0),
            Left(0),
            Right(0),
            Bottom(0)
        )
        MainFullView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
    
    func setupMainCollectionView() {
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = categorisTitle[indexPath.row]
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: name)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCellId, for: indexPath) as! BannersCell
        cell.images = categorisArray
        cell.titles = categorisTitle
        
        return cell
        
        
        
    }
}


class BannersCell:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource  {
    
    var images: [String]? {
        didSet {
            bannerCollectionView.reloadData()
        }
    }
    
    var titles: [String]? {
        didSet {
            bannerCollectionView.reloadData()
        }
    }
    
    
    let cellId = "cellId"
    lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.red
        cv.delegate =  self
        cv.dataSource = self
        cv.register(IconCell.self, forCellWithReuseIdentifier: cellId)
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    func setupView()  {
        backgroundColor = UIColor.black
        addSubview(bannerCollectionView)
        
        bannerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bannerCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bannerCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bannerCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bannerCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconCell
        if let imageName =  images?[indexPath.item]{
            cell.imageView.image = UIImage(named: imageName)
        }
        
        if let titleName =  titles?[indexPath.item]{
            cell.logos.image = UIImage(named: titleName)
        }
        
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return print("clicked")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private class IconCell: UICollectionViewCell{
        
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 0
            return iv
        }()
        
        let titleView: UILabel = {
            let tv = UILabel()
            tv.textAlignment = .center
            tv.textColor = UIColor(named: "AccentColor")
            
            return tv
        }()
        
        
        let logos: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .center
            // iv.clipsToBounds = true
            iv.layer.cornerRadius = 0
            return iv
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            
            imageView.addSubview(logos)
            //titleView.easy.layout(center, center)
            
            let  isCenterAligned = true
            
            logos.easy.layout(
                Top(10),
                Bottom(10),
                Width(250),
                Left(10).when { !isCenterAligned },
                CenterX(0).when { isCenterAligned }
            )
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    
}


