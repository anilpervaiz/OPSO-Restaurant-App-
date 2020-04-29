//
//  SecondViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 6/26/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import SDWebImage

class SecondViewController: UIViewController {
    
    @IBOutlet var profileMainView: UIStackView!
    @IBOutlet var loginMainView: UIStackView!
    @IBOutlet var logoutMainView: UIStackView!
    
    @IBOutlet var registerMainView: UIStackView!
    @IBOutlet var followMainView: UIStackView!
    @IBOutlet var followUsButton: UILabel!
    @IBOutlet var logoutButton: UILabel!
    @IBOutlet var registerButton: UILabel!
    @IBOutlet var loginButton: UILabel!
    @IBOutlet var myProfile: UILabel!
    
    @IBOutlet weak var profileImage: RoundedImageView!
    @IBOutlet weak var userTitle: UILabel!
    let  realm =  try! Realm()
    
    
    var topicName: String!
    var data:Results<RealmUserDetails>!
    
     let defaults = UserDefaults.standard
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let loginStatus = defaults.bool(forKey: "userLogedIn")
        if(loginStatus){
            data = realm.objects(RealmUserDetails.self)
            
            userTitle.text = self.data[0].name
            
            
            if (data != nil)
            {
                print("found in second View")
                print(self.data[0].photo )
                let optionalString = self.data.first?.photo
                
                
                if let unwrapped = optionalString {
                    print(unwrapped)
                    
                    profileImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    profileImage.sd_setImage(with: URL(string: "http://app.opso.ae/" + self.data[0].photo), placeholderImage: UIImage(named: "NoImage.png"), options: .refreshCached)
                    
                    
                }
                
            }
        }
        
      
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
           let defaults = UserDefaults.standard
        let loginStatus = defaults.bool(forKey: "userLogedIn")
        
        print(loginStatus)
     
        if (loginStatus)
        
        {    loginMainView.removeFromSuperview()
            registerMainView.removeFromSuperview()
            
           
           
        }
        else {
            profileMainView.removeFromSuperview()
             logoutMainView.removeFromSuperview()
        
            
        }
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.tapFunction))
        myProfile.isUserInteractionEnabled = true
        myProfile.addGestureRecognizer(tap)
        
        let tapLogin = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.loginTapFunction))
        loginButton.isUserInteractionEnabled = true
        loginButton.addGestureRecognizer(tapLogin)
        
        let tapRegister = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.registerTapFunction))
        registerButton.isUserInteractionEnabled = true
        registerButton.addGestureRecognizer(tapRegister)
        let tapFollowUs = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.followUsTapFunction))
        followUsButton.isUserInteractionEnabled = true
        followUsButton.addGestureRecognizer(tapFollowUs)
        
        let tapLogout = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.logoutTapFunction))
        logoutButton.isUserInteractionEnabled = true
        logoutButton.addGestureRecognizer(tapLogout)
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc
    func loginTapFunction(sender:UITapGestureRecognizer) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    @objc
    func registerTapFunction(sender:UITapGestureRecognizer) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerViewController") as! RegisterViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc
    func followUsTapFunction(sender:UITapGestureRecognizer) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "followusViewController") as! FollowUsViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc
    func logoutTapFunction(sender:UITapGestureRecognizer) {
        
        
           let defaults = UserDefaults.standard
        
        defaults.set(false, forKey: "userLogedIn")
        
//        if let user = realm.objects(RealmUserDetails.self).all
//        {
//            try! realm.write {
//                realm.delete(user)
//            }
//
//            print(realm.objects(RealmUserDetails.self))
//        }
        let items = realm.objects(RealmUserDetails.self).first!
        try! realm.write {
            realm.delete(items)
        }

        
        
        
        
        
        resetApp()
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
//
//        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    
    func resetApp() {
        UIApplication.shared.windows[0].rootViewController = UIStoryboard(
            name: "Main",
            bundle: nil
            ).instantiateInitialViewController()
    }
    
    
    


}

