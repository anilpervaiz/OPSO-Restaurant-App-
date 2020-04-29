//
//  AllMenuViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/13/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit




class AllMenuViewController: UIViewController, UITableViewDataSource , UITableViewDelegate{
   
 
    @IBOutlet var tableView: UITableView!
      var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
 
     var arrayofmenuCategory = [menucat]()

    @IBOutlet var menuTitle: UILabel!
    
      var titlePassed = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        menuTitle.text = titlePassed
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        
        
        indicatorView()
        activityIndicator.startAnimating()
        
        if (!titlePassed.isEmpty && titlePassed == "Dining")
        {
              data_request("http://app.opso.ae/menusubcat.php", "0000000001")
            activityIndicator.stopAnimating()
        }
        else if (!titlePassed.isEmpty && titlePassed == "Prive")
        {
              data_request("http://app.opso.ae/menusubcat.php", "0000000002")
             activityIndicator.stopAnimating()
            
        }
        else if (!titlePassed.isEmpty && titlePassed == "Social")
        {
              data_request("http://app.opso.ae/menusubcat.php", "0000000003")
             activityIndicator.stopAnimating()
        }
        
       

      //  print(titlePassed)

      
        // Do any additional setup after loading the view.
    }
    
    
    var indicator = UIActivityIndicatorView()
    
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
                let menu = try decoder.decode(menucats.self, from: data)
               // print(menu.menucat[0].title)

                self.arrayofmenuCategory = menu.menucat
                
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
//            //
//                        if let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue){
//
//                            print(dataString)
//                        }
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
       return  arrayofmenuCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? MenuTableViewCell else {return UITableViewCell()}
        
        cell.menuTitle.text = arrayofmenuCategory[indexPath.row].title
        
        cell.backgroundColor = UIColor.clear
        
//        cell.layer.cornerRadius = 8
//        cell.clipsToBounds = true
        
        return cell

    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
        
        
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "subMenuViewController") as! SubMenuViewController
        
                let id =  arrayofmenuCategory[indexPath.row].menusubid
                let title = arrayofmenuCategory[indexPath.row].title
                secondViewController.idPassed = id
        secondViewController.titlePassed = title
                self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // note that indexPath.section is used rather than indexPath.row
//        print("You tapped cell number \(indexPath.section).")
//
//
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "subMenuViewController") as! SubMenuViewController
//
//        let id =  arrayofmenuCategory[0].menusubid
//        secondViewController.idPassed = id
//        self.navigationController?.pushViewController(secondViewController, animated: true)
//
//
//    }
//

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
