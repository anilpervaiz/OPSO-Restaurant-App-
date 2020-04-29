//
//  ProductViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/16/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import SDWebImage


class ProductViewController: UIViewController {

    @IBOutlet var menuPhoto: UIImageView!
    @IBOutlet var productTitle: UILabel!
    @IBOutlet var productDescription: UITextView!
        var itemTitle = ""
    var itemDescription = ""
    var itemPhoto = ""
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        if (!itemTitle.isEmpty && !itemDescription.isEmpty && !itemPhoto.isEmpty)
        {
            
           // let url = URL(string: itemPhoto)
            
            menuPhoto.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            menuPhoto.sd_setImage(with: URL(string: "http://app.opso.ae/" + itemPhoto), placeholderImage: UIImage(named: "NoImage.png"))
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                DispatchQueue.main.async {
//                    self.menuPhoto.image = UIImage(data: data!)
//                }
//            }
            
            
           productTitle.text = itemTitle
            productDescription.text = itemDescription
            
        }
    }
    


}
