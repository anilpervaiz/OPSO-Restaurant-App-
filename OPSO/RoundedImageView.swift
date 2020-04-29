//
//  RoundedImageView.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/17/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit

@IBDesignable class RoundedImageView:UIImageView {
    @IBInspectable var borderColor:UIColor = UIColor.white {
        willSet {
            layer.borderColor = newValue.cgColor
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
        layer.borderWidth = 0
        layer.borderColor = borderColor.cgColor
    }
}
