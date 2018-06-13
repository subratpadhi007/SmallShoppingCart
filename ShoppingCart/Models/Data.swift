//
//  Data.swift
//  ShoppingCart
//
//  Created by SUBRAT on 6/9/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import Foundation

class Data {
    
    static func getData(complition: ([Products]) -> ()){
        var data : [Products] = []
        let name = ["Orange", "Apple", "Kiwi", "Banana", "Apricot", "Avocado", "Blackcurrant", "Blueberry"]
        let price = ["10", "20", "30", "40", "50", "60", "70", "80"]
        
        
        data.append(Products(name: name[0], price: price[0], image: #imageLiteral(resourceName: "orange")))
        data.append(Products(name: name[1], price: price[1], image: #imageLiteral(resourceName: "apple")))
        data.append(Products(name: name[2], price: price[2], image: #imageLiteral(resourceName: "kiwi")))
        data.append(Products(name: name[3], price: price[3], image: #imageLiteral(resourceName: "banana")))
        data.append(Products(name: name[4], price: price[4], image: #imageLiteral(resourceName: "apricot")))
        data.append(Products(name: name[5], price: price[5], image: #imageLiteral(resourceName: "avacado")))
        data.append(Products(name: name[6], price: price[6], image: #imageLiteral(resourceName: "black")))
        data.append(Products(name: name[7], price: price[7], image: #imageLiteral(resourceName: "black")))
        
        
        complition(data)
    }
}
