//
//  HomeViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 6/26/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import EasyPeasy
import Alamofire
import SDWebImage




class HomeViewController: UIViewController{
    
    @IBOutlet var sliderCollectionView: UICollectionView!
    
    @IBOutlet var pageContoller: UIPageControl!
    var bannersofArray = [banner]()
    
    var imgArr = [UIImage(named: "diningBackground"),UIImage(named: "diningBackground"),UIImage(named: "diningBackground")]
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //    self.navigationItem.title = "The title"
        
         data_request("http://app.opso.ae/fetch_banners.php")
       
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
    
        
       
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
//        }
//

//
//         let url = URL(fileURLWithPath: urlString)
//
//
//        URLSession.shared.dataTask(with: url){ (data, responds, err ) in
//
//
//            print("doo stuff here")
//
//            print(data)
//            print(responds)
//
//        }.resume()
        
//
//
//
//        AF.request(urlString, method: .post, parameters: ["banners": "opso_banners"],encoding: JSONEncoding.default, headers: nil).responseJSON {
//            response in
//            switch response.result {
//            case .success:
//                print(response)
//
//                break
//            case .failure(let error):
//
//                print(error)
//            }
        
       
        }
    @objc func changeImage() {

        if counter < bannersofArray.count {
            pageContoller.currentPage = counter
            counter += 1
        } else {
            counter = 0
            pageContoller.currentPage = counter
            counter = 1
        }

    }
    
    
    
    func data_request(_ url:String)  {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramsString = "banners=opso_banners"
        request.httpBody = paramsString.data(using: String.Encoding.utf8)
        
        let task =  session.dataTask(with: request as URLRequest){
            
            (data , response, error) in
            
            
            guard let data = data, error == nil, response != nil else {
                print("Somthing is worng")
                return
                
            }
            print("Downloaded")
            do{
                let decoder = JSONDecoder()
                let ban = try decoder.decode(banners.self, from: data)
               // print(ban.banners[0].image)
                
                self.bannersofArray = ban.banners
                
                
                DispatchQueue.main.async {
                    self.pageContoller.numberOfPages = self.bannersofArray.count
                
                     self.sliderCollectionView.reloadData()
                }
              
            }
            catch {
                
                print("Error")
                
            }
            
//            guard let data = data else { return }
//
//            guard let _:NSData = data  as NSData?, let _:URLResponse = response, error == nil  else {
//                print("error")
//
//                return
//            }
//
//
//
////
//            if let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue){
//
//                print(dataString)
//            }
//
//            print(data)
////
//
//
//            do {
//
//                let banners = try JSONDecoder().decode(fetch_banners.self, from: data)
//
//                print(banners)
//
//            }
//            catch let error {
//
//                print(error)
//            }
//            if let content = data
//            {
//
//                let jsonData = JSONSerialization(data: content)
//
//                let id = jsonData["id"].intValue
//                let name = jsonData["title"]["rendered"].string!
//                let link = jsonData["link"].url!
//                let content = jsonData["content"]["rendered"].string!
//
//
//                // Create Object
//                let detail = Detail(id: id, name: name, content: content, thumbnailUrl: link)
//                self.details.append(detail)
//                completionHandler(self.details)
//
//            }
            
        }
        
        task.resume()
        
        
    }
    
    
   
      
        
    }

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannersofArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.changeImage()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannersCollectionViewCell
        
        
        cell.bannerImage.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                    cell.bannerImage.sd_setImage(with: URL(string: "https://www.opso.ae/systemfiles/" + bannersofArray[indexPath.row].image), placeholderImage: UIImage(named: "NoImage.png"))
//        if let vc = cell.viewWithTag(111) as? UIImageView {
//            vc.image = imgArr[indexPath.row]
////        }
//             if let vc = cell.viewWithTag(111) as? UIImageView {
//        if let imageUrl = URL(string:"https://www.opso.ae/systemfiles/" + bannersofArray[indexPath.row].image){
//
//
//
//
////            DispatchQueue.global().async {
////                let data = try? Data(contentsOf: imageUrl)
////                if let data = data {
////                    let image = UIImage(data: data)
////
////                        DispatchQueue.main.async {
////
////                              vc.image = image
////
////
////                        }
////
////
////                }
////            }
//        }
//    }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}




