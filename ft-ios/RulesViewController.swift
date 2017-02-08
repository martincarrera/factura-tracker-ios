//
//  RulesViewController.swift
//  ft-ios
//
//  Created by Martin on 25/1/17.
//  Copyright © 2017 Martin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RullesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!

    let rulesReference: FIRDatabaseReference = FIRDatabase.database().reference().child("rules")
    var rules: Array<[String : AnyObject]> = []
    var rulesKeys: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rulesReference.observe(.childAdded, with: { (snapshot) -> Void in
            print(snapshot)
            self.rulesKeys.append(snapshot.key)
            self.rules.append(snapshot.value as! [String : AnyObject])
            self.tableView.insertRows(at: [IndexPath(row: self.rules.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
        })
        
        self.rulesReference.observe(.childRemoved, with: { (snapshot) -> Void in
            let index = Utils.indexOf(string: snapshot.key, inArray: self.rulesKeys)
            self.rules.remove(at: index)
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: UITableViewRowAnimation.automatic)
        })
        
        self.rulesReference.observe(.childChanged, with: { (snapshot) -> Void in
            let index = Utils.indexOf(string: snapshot.key, inArray: self.rulesKeys)
            self.rules[index] = snapshot.value as! [String : AnyObject]
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableViewRowAnimation.automatic)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ruleCell") as? RuleTableViewCell!
        self.loadDataTo(cell: cell!, withDictionary: self.rules[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rules.count
    }
    
    func loadDataTo(cell: RuleTableViewCell, withDictionary json: [String : AnyObject]) {
        cell.ruleDescriptionLabel.text = json["description"] as! String?
        cell.ruleCreatorLabel.text = json["creator"] as! String?
    }
}

