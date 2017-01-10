//
//  ThirdViewController.swift
//  Test
//
//  Created by Mobile Developer on 1/8/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var locationHistory: NSMutableArray?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func updatedLocation() {
        let userDefault = UserDefaults.standard
        let data = userDefault.value(forKey: "Sessions")
        if let data = data {
            locationHistory = NSMutableArray(array: data as! NSArray)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if locationHistory == nil {
            return 1
        } else {
            return (locationHistory?.count)!
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "sessiontablecell") as! SessionTableViewCell
        if locationHistory == nil {
        } else {
           cell.displayLabel.text = locationHistory?[indexPath.item] as! String 
        }
        
        return cell
    }

}
