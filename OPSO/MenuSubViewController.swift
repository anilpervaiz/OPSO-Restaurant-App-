//
//  MenuSubViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/6/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import EasyPeasy

class MenuSubViewController: UIViewController {
    @IBAction func seeAllButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllMenuIdentifier") as! AllMenuViewController
        
        
        if (!stringPassed.isEmpty && stringPassed == "dining"){
           
            secondViewController.titlePassed = "Dining"
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        else if (!stringPassed.isEmpty && stringPassed == "prive"){
            secondViewController.titlePassed = "Prive"
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        else if (!stringPassed.isEmpty && stringPassed == "social"){
            secondViewController.titlePassed = "Social"
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        
       

        
        
    }
    @IBOutlet var instagramButton: UIImageView!
    
   
    @IBOutlet var facebookButton: UIImageView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var descriptionText: UILabel!
    var stringPassed = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(stringPassed)
        if (!stringPassed.isEmpty && stringPassed == "dining"){
            dining()
            
        }
        else if (!stringPassed.isEmpty && stringPassed == "prive"){
            prive()
        }
        else if (!stringPassed.isEmpty && stringPassed == "social"){
             social()
        }
        
        let tapInsta = UITapGestureRecognizer(target: self, action: #selector(FollowUsViewController.tapInstaFunction))
        instagramButton.isUserInteractionEnabled = true
        instagramButton.addGestureRecognizer(tapInsta)
        
        
        
        let tapFacebook = UITapGestureRecognizer(target: self, action: #selector(FollowUsViewController.tapFacebookFunction))
        facebookButton.isUserInteractionEnabled = true
        facebookButton.addGestureRecognizer(tapFacebook)
        
        
    }
    
    func dining(){
        backgroundImage.image = UIImage(named: "diningBackground")
        logoImage.image = UIImage(named: "DiningText")
    }
    func prive(){
        backgroundImage.image = UIImage(named: "diningBackground")
        logoImage.image = UIImage(named: "PriveText")
    }
    func social(){
        backgroundImage.image = UIImage(named: "SocialBackground")
        logoImage.image = UIImage(named: "SocialText")
    }


    @objc
    func tapInstaFunction (sender:UITapGestureRecognizer) {
        
        let Username =  "anilpervaiz" // Your Instagram Username here
        let appURL = URL(string: "instagram://user?username=\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            let webURL = URL(string: "https://instagram.com/\(Username)")!
            application.open(webURL)
        }
    }
    
    
    @objc
    func tapFacebookFunction (sender:UITapGestureRecognizer) {
        
        let Username =  "anilpervaiz" // Your Instagram Username here
        let appURL = URL(string: "fb://profile/\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            let webURL = URL(string: "https://facebook.com/\(Username)")!
            application.open(webURL)
        }
    }
    
    

}
