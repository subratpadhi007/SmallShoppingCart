//
//  CartViewController.swift
//  ShoppingCart
//
//  Created by SUBRAT on 6/9/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var totalPricelabel: UILabel!
    @IBOutlet var outerView: UIView!
    var tableData : [Products] = []
    
    var costArray = [0, 0, 0, 0, 0, 0, 0, 0]
    
    var total = 0
    
    var val = [1, 1, 1, 1, 1, 1, 1, 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.outerView.dropShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Cart Details"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.name.text = self.tableData[indexPath.row].pName
        cell.price.text = self.tableData[indexPath.row].pPrice
        cell.imageHolder.image = self.tableData[indexPath.row].pImage
        cell.costLabel.text = "1 x \(self.tableData[indexPath.row].pPrice)"
        
        cell.cellView.dropShadow()
        
        cell.plusOutlet.tag = indexPath.row
        cell.minusOutlet.tag = indexPath.row
        
        let cost = 1 * Int(self.tableData[indexPath.row].pPrice)!
        self.costArray[indexPath.row] = cost
        self.calcualteCost()
        return cell
    }
    
    
    @IBAction func plusClicked(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        let index = IndexPath(item: button.tag, section: 0)
        let cell = self.tableView.cellForRow(at: index) as! CartCell
        
        let indexVal = self.val[index.row] + 1
        if indexVal != 11{
            self.val[index.row] = indexVal
        }
        let value = self.val[index.row]
        if value < 10{
            let prc = self.tableData[index.row].pPrice
            cell.costLabel.text = "\(indexVal) x \(prc)"
            cell.qty.text = "\(indexVal)"
            let cost = indexVal * Int(prc)!
            self.costArray[index.row] = cost
            self.calcualteCost()
        }

    }
    @IBAction func minusClicked(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        let index = IndexPath(item: button.tag, section: 0)
        let cell = self.tableView.cellForRow(at: index) as! CartCell
        
        let indexVal = self.val[index.row] - 1
        if indexVal != 0 {
            self.val[index.row] = indexVal
        }
        if indexVal == 0{
            
        }else{
            let value = self.val[index.row]
            if value >= 1{
                let prc = self.tableData[index.row].pPrice
                cell.costLabel.text = "\(indexVal) x \(prc)"
                cell.qty.text = "\(indexVal)"
                let cost = indexVal * Int(prc)!
                self.costArray[index.row] = cost
                self.calcualteCost()
            }
        }
        }
    
    func calcualteCost(){
        let sum = costArray.reduce(0, +)
        self.totalPricelabel.text = "₹ \(sum)"
    }
    
}

class CartCell: UITableViewCell{
    @IBOutlet var cellView: UIView!
    @IBOutlet var imageHolder: UIImageView!
    @IBOutlet var qty: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var plusOutlet: UIButton!
    @IBOutlet var minusOutlet: UIButton!
    @IBOutlet var costLabel: UILabel!
}
