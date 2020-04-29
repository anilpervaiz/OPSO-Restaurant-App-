//
//  FollowUsViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/20/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit

class FollowUsViewController: UIViewController {

    @IBOutlet var facebookButton: UIImageView!
    @IBOutlet var instagramButton: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapInsta = UITapGestureRecognizer(target: self, action: #selector(FollowUsViewController.tapInstaFunction))
        instagramButton.isUserInteractionEnabled = true
        instagramButton.addGestureRecognizer(tapInsta)
        
        
        
        let tapFacebook = UITapGestureRecognizer(target: self, action: #selector(FollowUsViewController.tapFacebookFunction))
        facebookButton.isUserInteractionEnabled = true
        facebookButton.addGestureRecognizer(tapFacebook)

        // Do any additional setup after loading the view.
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
