//
//  RegisterViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/18/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
 var errorDisplay: UIAlertController = UIAlertController()
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet var confirmPasswordInput: DesignableUITextField!
    @IBOutlet var passwordInput: DesignableUITextField!
    @IBOutlet var emailInput: DesignableUITextField!
    @IBOutlet var usernameInput: DesignableUITextField!
    @IBAction func registerButton(_ sender: Any) {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        
        if (self.passwordInput.text == self.confirmPasswordInput.text)
        {
        
           if let mail = emailInput.text, let pass = passwordInput.text,let user = usernameInput.text,  mail.isEmpty || pass.isEmpty || user.isEmpty
            {
                errorDisplay = UIAlertController(title: "Message", message:
                    "Field empty!", preferredStyle: .alert)
                
                errorDisplay.addAction(UIAlertAction(title: "Dismiss", style: .default ))
                
                self.present(errorDisplay, animated: true, completion: nil)
                return
            }
           else {
              let name = usernameInput.text!
            let email = emailInput.text!
            let password = passwordInput.text!
            
            
             data_request("http://app.opso.ae/register.php", name, email, password)
            }
            
        }
            
        else
        {
           
            errorDisplay = UIAlertController(title: "Message", message:
                "Password Mismatch", preferredStyle: .alert)
            
            errorDisplay.addAction(UIAlertAction(title: "Dismiss", style: .default ))
            
            self.present(errorDisplay, animated: true, completion: nil)
            return
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func data_request(_ url:String, _ user:String, _ mail:String, _ pass:String)  {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramsString = "name=" + user + "&" + "email=" + mail + "&" + "password=" + pass
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
                let message = try decoder.decode(register.self, from: data)
                // print(menu.menucat[0].title)
                
                if(!message.success.isEmpty && message.success == "1")
                {
                    
                    print(message.success)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.LoginScreen()
                    }
                }
                else if (!message.success.isEmpty && message.success == "1"){
                    
                 DispatchQueue.main.async {
                    self.errorDisplay = UIAlertController(title: "Error", message:
                        "This email donot exsist!", preferredStyle: .alert)

                    self.errorDisplay.addAction(UIAlertAction(title: "Dismiss", style: .default ))

                    self.present(self.errorDisplay, animated: true, completion: nil)
                    }
                    
                }
                
                
                
            }
            catch {

                print("Error")

            }
//            guard let _:NSData = data  as NSData?, let _:URLResponse = response, error == nil  else {
//                print("error")
//
//                return
//            }
//
//            if let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue){
//
//                print(dataString)
//            }
//
//            print(data)
            
        }
        
        task.resume()
      
    }
    
    func LoginScreen()  {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    

}
