//
//  PasswordUpdateViewController.swift
//  OPSO
//
//  Created by user on 10/8/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class PasswordUpdateViewController: UIViewController {
    
    var errorDisplay: UIAlertController = UIAlertController()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let defaults = UserDefaults.standard
    
    let  realm =  try! Realm()

    @IBOutlet weak var inputPassword: DesignableUITextField!
    
    @IBOutlet weak var inputConfirmPassword: DesignableUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
        
        
        activityIndicator.startAnimating()
        if (self.inputPassword.text == self.inputConfirmPassword.text)
        {
            
            
            let loginStatus = defaults.bool(forKey: "userLogedIn")
            if(loginStatus){
                let userID = defaults.string(forKey: "userId")!
                let password = inputPassword.text!
                data_request("http://app.opso.ae/edit_password.php", userID, pass: password)
            }
            
            
        }
        else
        {
            
            errorDisplay = UIAlertController(title: "Message", message:
                "Password Mismatch", preferredStyle: .alert)
            
            errorDisplay.addAction(UIAlertAction(title: "Dismiss", style: .default ))
            
            self.present(errorDisplay, animated: true, completion: nil)
            self.activityIndicator.stopAnimating()
            return
        }
        
    }
    
    
    func data_request(_ url:String, _ id:String, pass:String)  {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramsString = "id=" + id + "&" + "password=" + pass
        request.httpBody = paramsString.data(using: String.Encoding.utf8)
        
        let task =  session.dataTask(with: request as URLRequest){
            
            (data , response, error) in
            
            guard let data = data, error == nil, response != nil else {
                print("Somthing is worng")
                return
                
            }
            
            print("downloaded")
            do{
                let decoder = JSONDecoder()
                print(decoder)
                let message = try decoder.decode(register.self, from: data)
                
                print(message)
                
                if(!message.success.isEmpty && message.success == "1")
                {
                    
                    print(message.success)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.Logout()
                    }
                }
                else if (!message.success.isEmpty && message.success == "0"){
                    
                    DispatchQueue.main.async {
                        self.errorDisplay = UIAlertController(title: "Error updating password!", message:
                            "Please try again later.", preferredStyle: .alert)
                        
                        self.errorDisplay.addAction(UIAlertAction(title: "Dismiss", style: .default ))
                        
                        self.present(self.errorDisplay, animated: true, completion: nil)
                    }
                    
                }
                
                
            }
            catch {
                
                print("Error")
                
            }
            guard let _:NSData = data  as NSData?, let _:URLResponse = response, error == nil  else {
                print("error")
                
                return
            }
            
            if let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue){
                
                print(dataString)
            }
            
            print(data)
            
        }
        
        task.resume()
        
    }
    func Logout()  {
        
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "userLogedIn")
        defaults.set("", forKey: "userId")
        defaults.set("", forKey: "userEmail")
        defaults.set("", forKey: "userName")
        defaults.set("", forKey: "userPassword")
        defaults.set("", forKey: "userPhoto")
        
        let items = realm.objects(RealmUserDetails.self).first!
        try! realm.write {
            realm.delete(items)
        }
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
 
}
