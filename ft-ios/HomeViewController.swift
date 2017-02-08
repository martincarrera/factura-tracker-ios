//
//  HomeViewController.swift
//  ft-ios
//
//  Created by Martin on 25/1/17.
//  Copyright © 2017 Martin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    let facturasReference: FIRDatabaseReference = FIRDatabase.database().reference().child("facturas")
    var facturas: Array<[String : AnyObject]> = []
    var facturasKeys: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.facturasReference.observe(.childAdded, with: { (snapshot) -> Void in
            self.facturasKeys.append(snapshot.key)
            self.facturas.append(snapshot.value as! [String : AnyObject])
            self.tableView.insertRows(at: [IndexPath(row: self.facturas.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
        })
        
        self.facturasReference.observe(.childRemoved, with: { (snapshot) -> Void in
            let index = Utils.indexOf(string: snapshot.key, inArray: self.facturasKeys)
            self.facturas.remove(at: index)
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: UITableViewRowAnimation.automatic)
        })
        
        self.facturasReference.observe(.childChanged, with: { (snapshot) -> Void in
            let index = Utils.indexOf(string: snapshot.key, inArray: self.facturasKeys)
            self.facturas[index] = snapshot.value as! [String : AnyObject]
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableViewRowAnimation.automatic)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "facturaCell") as? FacturaTableViewCell!
        self.loadDataTo(cell: cell!, withDictionary: self.facturas[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.facturas.count
    }
    
    func loadDataTo(cell: FacturaTableViewCell, withDictionary json: [String : AnyObject]) {
        cell.guiltyNameLabel.text = json["guilty"] as! String?
        cell.creatorNameLabel.text = json["creator"] as! String?
        cell.ruleLabel.text = json["motive"] as! String?
        var imageName = "owed"
        let isPaid = json["paid"] as! Bool?
        let expirationDate = json["expirationDate"] as! String?
        let dateFormatterFromJson = DateFormatter()
        let dateFormaterForView = DateFormatter()
        dateFormatterFromJson.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormaterForView.dateFormat = "dd MMM yyyy"
        if let date = dateFormatterFromJson.date(from: expirationDate!) {
            cell.expirationDateLabel.text = dateFormaterForView.string(from: date)
            if (Date().isGreaterThanDate(dateToCompare: date)) {
                cell.isExpiredImageView.isHidden = false
            }
        }
        if (isPaid!) {
            imageName = "paid"
            cell.validatedByLabel.isHidden = false
            cell.validatedByNameLabel.isHidden = false
            cell.validatedByNameLabel.text = json["verifier"] as! String?
            cell.isExpiredImageView.isHidden = true
        } else {
            cell.validatedByLabel.isHidden = true
            cell.validatedByNameLabel.isHidden = true
        }
        cell.isPayedImageView.image = UIImage.init(named: imageName)
    }
}

