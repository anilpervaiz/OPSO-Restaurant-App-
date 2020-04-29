//
//  LoginViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/16/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit

import RealmSwift
import Realm

class LoginViewController: UIViewController {
 

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var errorDisplay: UIAlertController = UIAlertController()
    
    let defaults = UserDefaults.standard
    
    let  realm =  try! Realm()
    
    var data:Results<RealmUserDetails>!
    
    @IBOutlet var orRegister: UILabel!
    var loginArray = [login]()
    
    @IBAction func loginButton(_ sender: Any) {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()

//
        
        
        
        if let mail = emailInput.text, let pass = passwordInput.text, mail.isEmpty || pass.isEmpty {
        
            errorDisplay = UIAlertController(title: "Empty Fields", message:
                "Email & Password (Required)", preferredStyle: .alert)

            errorDisplay.addAction(UIAlertAction(title: "Dismiss", style: .default ))
        
            self.present(errorDisplay, animated: true, completion: nil)
            return
        }
        else {
            let email = emailInput.text!
            let password = passwordInput.text!
            
            data_request("http://ppsapi.somee.com/token", email , password )
        }
        
    }
    @IBOutlet var emailInput: DesignableUITextField!
    @IBOutlet var passwordInput: DesignableUITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Realm:DB \(Realm.Configuration.defaultConfiguration.fileURL!) ")
        let tap = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.tapFunction))
        orRegister.isUserInteractionEnabled = true
        orRegister.addGestureRecognizer(tap)
     
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerViewController") as! RegisterViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func data_request(_ url:String, _ mail:String, _ pass:String)  {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramsString = "username=" + mail + "&" + "password=" + pass + "&" + "grant_type=password"
        request.httpBody = paramsString.data(using: String.Encoding.utf8)
        
        let task =  session.dataTask(with: request as URLRequest){
            
            (data , response, error) in
            
            //
            guard let data = data, error == nil, response != nil else {
                print("Somthing is worng")
                return
                
            }
            print("downloaded")
            do{
                let decoder = JSONDecoder()
                let success = try decoder.decode(Successs.self, from: data)
                
                
             
                // print(menu.menucat[0].title)
                  print(success.success)
                if(!success.success.isEmpty && success.success == "1")
                {
                    
                    let message = try decoder.decode(logins.self, from: data)
                    
                    self.defaults.set(true, forKey: "userLogedIn")
                    self.defaults.set(message.login.id, forKey: "userId")
                      self.defaults.set(message.login.email, forKey: "userEmail")
                      self.defaults.set(message.login.name, forKey: "userName")
                      self.defaults.set(message.login.password, forKey: "userPassword")
                    self.defaults.set(message.login.photo, forKey: "userPhoto")
                       self.defaults.set(message.login.phone, forKey: "userPhone")
                       self.defaults.set(message.login.location, forKey: "userLocation")
                    
                    
                  self.defaults.set(pass, forKey: "toRegisterPassword")
                    
                     DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                         self.saveUserDetails(message.login.id, message.login.name, message.login.email, message.login.password, message.login.photo, message.login.phone, message.login.location)
                    }
                }
                else if (!success.success.isEmpty && success.success == "0"){
                    
                    
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        
                        
                        self.errorDisplay = UIAlertController(title: "Error", message:
                            "This User donot exsist!", preferredStyle: .alert)
                        
                        self.errorDisplay.addAction(UIAlertAction(title: "Dismiss", style: .default ))
                        
                        self.present(self.errorDisplay, animated: true, completion: nil)
                    }
                    
               
                    
                }
                
                
                

             //   self.loginArray = message.
               
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
    
    func saveUserDetails(_ id:String , _ name:String, _ email:String , _ password:String , _ photo:String  , _ phone:String  , _ location:String)  {
        
        
        
    
            let details = RealmUserDetails()
         details.id = id
         details.name = name
         details.email = email
         details.password = password
         details.photo = "http://app.opso.ae/" + photo
         details.phone = phone
         details.location = location
        
        
            try! realm.write {
               // realm.add(details)
                
                 realm.add(RealmUserDetails(id: id, name: name, email: email, password: password, photo:photo, location: location, phone: phone))
            }
       // print(realm.objects(RealmUserDetails()))
            print("done")
        
      HomeScreen()
    
            self.data = realm.objects(RealmUserDetails.self)
    
            print(self.data!)
    }
    
    func HomeScreen()  {
        
        UIApplication.shared.windows[0].rootViewController = UIStoryboard(
            name: "Main",
            bundle: nil
            ).instantiateInitialViewController()
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }

}
