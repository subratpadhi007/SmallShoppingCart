//
//  ViewController.swift
//  ShoppingCart
//
//  Created by SUBRAT on 6/9/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit
import  BBBadgeBarButtonItem

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableData : [Products] = []
    var cartProducts : [Products] = []
    var cartCount = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Data.getData { (pro) in
            self.tableData = pro
            self.tableView.reloadData()
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Fruits"
        self.navItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell", for: indexPath) as! ViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.addToCartButnOutlet.layer.cornerRadius = 10
        cell.addToCartButnOutlet.layer.borderColor = UIColor.defaultColor.cgColor
        cell.addToCartButnOutlet.layer.borderWidth = 1
        
        cell.outerView.dropShadow()
        
        cell.nameLabel?.text = self.tableData[indexPath.row].pName
        cell.priceLabel?.text = self.tableData[indexPath.row].pPrice
        cell.imageHolder.image = self.tableData[indexPath.row].pImage
        
        cell.addToCartButnOutlet.tag = indexPath.row
        
        return cell
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        let selectedProduct = self.tableData[button.tag]
        self.cartProducts.append(selectedProduct)
        self.alert(info: "Selected ttem added to cart")
    }
    
    func alert(info:String) {
        let popUp = UIAlertController(title: "Added", message: info, preferredStyle: UIAlertControllerStyle.alert)
        popUp.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {alertAction in
            popUp.dismiss(animated: true, completion: nil)
            self.cartCount = "\(self.cartProducts.count)"
            self.navItems()
        }))
        self.present(popUp, animated: true, completion: nil)
    }
    
    @objc func cartTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.tableData = self.cartProducts
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func barItemWithView(view: UIView, rect: CGRect) -> UIBarButtonItem {
        let container = UIView(frame: rect)
        container.addSubview(view)
        view.frame = rect
        return UIBarButtonItem(customView: container)
    }
    func navItems(){
        
        let home: UIButton = UIButton(type: UIButtonType.custom)
        let barButton = BBBadgeBarButtonItem(customUIButton: home)
        barButton?.badgeValue = "\(self.cartCount)"
        home.setImage(UIImage(named: "cart"), for: UIControlState.normal)
        home.imageView?.contentMode = .scaleAspectFit
        home.addTarget(self, action: #selector(self.cartTapped), for: UIControlEvents.touchUpInside)
        let rightBar = barItemWithView(view: home, rect: CGRect(x: 0, y: 0, width: 25, height: 25))
        self.navigationItem.setRightBarButtonItems([ rightBar], animated: true)
        self.title = "Fruti List"
        
    }
    
    
    
}

class ViewCell: UITableViewCell{
    @IBOutlet var imageHolder: UIImageView!
    
    @IBOutlet var outerView: UIView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addToCartButnOutlet: UIButton!
    
}

extension UIView{
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 0)
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 5
    }
}

extension UIColor{
    open class var defaultColor: UIColor {
        get {
            return UIColor(red:0.50, green:0.87, blue:0.92, alpha:1.0)
        }
    }
}
