//
//  UploadViewController.swift
//  OPSO
//
//  Created by user on 10/8/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import Alamofire
import Photos
import RealmSwift
import Realm
import SDWebImage

class UploadViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var errorDisplay: UIAlertController = UIAlertController()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let myPickerController = UIImagePickerController()
    
    
    var imagePicker:UIImagePickerController!
    
    
    
    var finalImage: String = ""
    
     let  realm =  try! Realm()
    
    let picker = UIImagePickerController()
    
    let defaults = UserDefaults.standard
    
    
    struct Response: Codable { // or Decodable
        let user_success: String
        
        
    }
    
    
    @IBOutlet weak var inputImage: RoundedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.sourceType = .photoLibrary
       
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        @unknown default: break
            
        }
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        
        let myPickerController = UIImagePickerController()
        //        myPickerController.delegate = self
        //        myPickerController.sourceType = .photoLibrary
        //
        //        self.present(myPickerController, animated: true, completion: nil)
        //
        
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
            present(picker, animated: true, completion: nil)
            
            
            // self.present(myPickerController, animated: true, completion: nil)
            
        //            self.present(self.imagePicker, animated: true, completion: nil)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                    self.present(self.picker, animated: true, completion: nil)
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        @unknown default: break
            
        }
        //
    }
    
    @IBAction func uploadAction(_ sender: Any) {
        
        
        //  let imageData = (inputImageView.image?.jpegData(compressionQuality: 0.5))!
        
        
        var actualHeight: Float = Float(inputImage.image!.size.height)
        var actualWidth: Float = Float(inputImage.image!.size.width)
        let maxHeight: Float = 400.0
        let maxWidth: Float = 400.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.7
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        inputImage.image!.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        
        let imageData =  img?.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        
        
        //   let imageData = resizeImage(image: inputImageView.image!)
        let userId = defaults.string(forKey: "userId")
        //Call Parameters
        let params: Parameters = ["user_id": userId! ]
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "uploaded_file", fileName: "test2.jpg", mimeType: "image/jpg")
            
            for (key, value) in params
            {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: "http://app.opso.ae/upload_2.php") { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseString { response in
                    //  print("Success")
                    //   print(response)
                    
                    switch(response.result) {
                    case .success(_):
                        if let data = response.result.value{
                            
                            print("final Image")
                            print(data)
                            
                            
                            
                            DispatchQueue.main.async {
                                
                                // self.defaults.set(data, forKey: "userPhoto")
                               // self.finalImage = response.result.value!
                               
                                print(response.result.value!)
                                self.updateUserImage(data)
                                
                                
                            }
                            
                        }
                        
                    case .failure(_):
                        print("Error message:\(response.result.error ?? "Error" as! Error)")
                        break
                    }
                }
                
            case .failure(let encodingError):
                print("Error")
                print(encodingError)
            
    }
        }

}
    
    
    
    func updateUserImage(_ photo:String)  {
        
//
//       let result = finalImage.trimmingCharacters(in: .whitespaces)
//        if let user = realm.objects(RealmUserDetails.self).first
//        {
//            try! realm.write {
//
//
//                user.photo = result
//
//
//            }
//
//            print(realm.objects(RealmUserDetails.self).first!)
//
//           //to_MyProfile()
//
//        }
          let loginStatus = defaults.bool(forKey: "userLogedIn")
        if(loginStatus){
            
            let email = defaults.string(forKey: "userEmail")
              let pass = defaults.string(forKey: "toRegisterPassword")
           
           
            
            
            if (!email!.isEmpty || !pass!.isEmpty )
            {
                data_request("http://app.opso.ae/login.php" , email!, pass!)
            }
            
        }
        
       
        
        
    }
    
    
    func data_request(_ url:String, _ mail:String, _ pass:String)  {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramsString = "email=" + mail + "&" + "password=" + pass
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
        
        
 
        if let user = realm.objects(RealmUserDetails.self).first
        {
            try! realm.write {
                
               
                user.photo = photo
                
            }
            
            print(realm.objects(RealmUserDetails.self).first!)
            
            to_MyProfile()
            
        }

    }
    
    
    func to_MyProfile()  {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
     
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        inputImage.image = info[.originalImage] as? UIImage
        
    }
    
    
    
}
