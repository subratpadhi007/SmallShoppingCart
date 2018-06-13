//
//  Products.swift
//  ShoppingCart
//
//  Created by SUBRAT on 6/9/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit

class Products {

    var pName  = ""
    var pPrice  = ""
    var pImage : UIImage?
    
    init(name: String, price: String, image: UIImage? ) {
        pName = name
        pPrice = price
        pImage = image
    }
}
