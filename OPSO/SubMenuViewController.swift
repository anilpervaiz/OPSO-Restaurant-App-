//
//  SubMenuViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/16/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import SDWebImage

class SubMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet var subMenuTitle: UILabel!
    
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet var tableView: UITableView!
    
    var idPassed = ""
      var titlePassed = ""
    
    var menuItemsArray = [menuitem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)

        
        if(!titlePassed.isEmpty)
        {
            subMenuTitle.text = titlePassed
            
        }
        
        indicatorView()
        activityIndicator.startAnimating()
        
        if(!idPassed.isEmpty)
        {
            print(idPassed)
             data_request("http://app.opso.ae/menuitem.php", idPassed)
            activityIndicator.stopAnimating()
        }
        
       
    }
    
    
    func indicatorView () {
        
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        view.addSubview(activityIndicator)
        
    }
    
    
    
    func data_request(_ url:String, _ id:String)  {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramsString = "id=" + id
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
                let menuit = try decoder.decode(menuitems.self, from: data)
                // print(menu.menucat[0].title)

                
                self.menuItemsArray = menuit.menuitem
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.backgroundColor = UIColor.clear
                }

            }
            catch {

                print("Error")

            }
            
            
            
            //                        guard let data = data else { return }
            //
            //                        guard let _:NSData = data  as NSData?, let _:URLResponse = response, error == nil  else {
            //                            print("error")
            //
            //                            return
            //                        }
            //
            //
            //
                        //
                                    if let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue){
            
                                        print(dataString)
                                    }
            //
            //                        print(data)
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "submenuCell") as? SubMenuTableViewCell else {return UITableViewCell()}
        
        cell.menuTitle.text = menuItemsArray[indexPath.row].title
        cell.menuDescription.text = menuItemsArray[indexPath.row].description
        
        if let imageUrl = URL(string: menuItemsArray[indexPath.row].image) {
            
            
            cell.menuImage.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.menuImage.sd_setImage(with: URL(string: "http://app.opso.ae/" + menuItemsArray[indexPath.row].image), placeholderImage: UIImage(named: "NoImage.png"))
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: imageUrl)
//                if let data = data {
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        cell.menuImage.image = image
//                    }
//                }
//            }
          
        }

    
        
        cell.backgroundColor = UIColor.clear
        
        //        cell.layer.cornerRadius = 8
        //        cell.clipsToBounds = true
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "productViewController") as! ProductViewController
        
        let title =  menuItemsArray[indexPath.row].title
         let descripton =  menuItemsArray[indexPath.row].description
        let photo = menuItemsArray[indexPath.row].image
        
        
        secondViewController.itemTitle = title
         secondViewController.itemDescription = descripton
        secondViewController.itemPhoto = photo
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    

}
