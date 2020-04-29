//
//  ProfileViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/16/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import Kingfisher
import SDWebImage
import Alamofire
import AlamofireImage

class ProfileViewController: UIViewController {
    
     let defaults = UserDefaults.standard

    @IBAction func saveChangesButton(_ sender: Any) {
    }
    @IBOutlet var LocationField: DesignableUITextField!
    @IBOutlet var phoneField: DesignableUITextField!
    @IBOutlet var emailfield: DesignableUITextField!
    @IBOutlet var fullNameField: DesignableUITextField!
    @IBOutlet var profileImage: UIImageView!
   
    
    @IBOutlet weak var editImageButton: UILabel!
    
    let  realm =  try! Realm()
    
    
    
    var data:Results<RealmUserDetails>!
  
    
    override func viewWillAppear(_ animated: Bool) {
        
      //viewDidLoad()
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        data = realm.objects(RealmUserDetails.self)
        
        
        
        
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
    
   
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            
        
        
        let loginStatus = defaults.bool(forKey: "userLogedIn")
        if(loginStatus){
            let id = defaults.string(forKey: "userId")
            let email = defaults.string(forKey: "userEmail")
            let name = defaults.string(forKey: "userName")
            let photo = defaults.string(forKey: "userPhoto")
            
            
            if (!id!.isEmpty || !email!.isEmpty || !name!.isEmpty || !photo!.isEmpty)
            {
                
              //  let url = URL(string: "http://app.opso.ae/" + photo!)
                
//                DispatchQueue.global().async {
//                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                    DispatchQueue.main.async {
//                        self.profileImage.image = UIImage(data: data!)
//                    }
//                }
//                
//                fullNameField.text = name
//                emailfield.text = email
//                
            }
            
            
        }
        
        let tapEditImage = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.tapFunction))
        editImageButton.isUserInteractionEnabled = true
        editImageButton.addGestureRecognizer(tapEditImage)
        

        // Do any additional setup after loading the view.
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
          data = realm.objects(RealmUserDetails.self)
//        guard let url = URL(string: data.first?.photo ?? "Photo Not Found")else { print("Error"); return}
//        
//        print(url)
//        SDImageCache.shared.removeImage(forKey: url.description, withCompletion: nil)
//        
//        profileImage.image = nil

        let uploadImageViewController = self.storyboard?.instantiateViewController(withIdentifier: "uploadViewController") as! UploadViewController

        self.navigationController?.pushViewController(uploadImageViewController, animated: true)
    }
    
    
    @IBAction func updatePasswordAction(_ sender: Any) {
        
        
        let passwordViewController = self.storyboard?.instantiateViewController(withIdentifier: "passwordUpdateViewController") as! PasswordUpdateViewController
        
        self.navigationController?.pushViewController(passwordViewController, animated: true)
    }
    
    

  

}


