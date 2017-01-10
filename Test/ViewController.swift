//
//  ViewController.swift
//  Test
//
//  Created by Mobile Developer on 1/7/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstVC : FirstViewController!
    var secondVC : SecondViewController!
    var thirdVC : ThirdViewController!
    
    var navCtrl1 : UINavigationController!
    var navCtrl2 : UINavigationController!
    var navCtrl3 : UINavigationController!

    @IBOutlet weak var tabView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func initView() {
        firstVC = self.storyboard?.instantiateViewController(withIdentifier: "firstvc") as! FirstViewController
        navCtrl1 = UINavigationController(rootViewController: firstVC)
        navCtrl1.navigationBar.isHidden = true
        secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondvc") as! SecondViewController
        navCtrl2 = UINavigationController(rootViewController: secondVC)
        navCtrl2.navigationBar.isHidden = true
        thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "thirdvc") as! ThirdViewController
        navCtrl3 = UINavigationController(rootViewController: thirdVC)
        navCtrl3.navigationBar.isHidden = true
        self.addChildViewController(navCtrl1)
        self.addChildViewController(navCtrl2)
        self.addChildViewController(navCtrl3)
        self.view.addSubview(navCtrl1.view)
        self.view.addSubview(navCtrl2.view)
        self.view.addSubview(navCtrl3.view)
        self.setSelectItem(index: 0)
        self.view.bringSubview(toFront: self.tabView)
    }

    func setSelectItem(index: Int!) {
        
        switch(index) {
        case 0:
            navCtrl1.view.isHidden = false
            navCtrl2.view.isHidden = true
            navCtrl3.view.isHidden = true
            break
        case 1:
            navCtrl2.view.isHidden = false
            navCtrl1.view.isHidden = true
            navCtrl3.view.isHidden = true
            break
        case 2:
            navCtrl3.view.isHidden = false
            navCtrl2.view.isHidden = true
            navCtrl1.view.isHidden = true
            break
        default:
            break
        }
    }
    
    @IBAction func firstButtonClicked(_ sender: AnyObject) {
        self.setSelectItem(index: 0)
    }
    
    @IBAction func secondButtonClicked(_ sender: AnyObject) {
        self.setSelectItem(index: 1)
    }
    
    @IBAction func thirdButtonClicked(_ sender: AnyObject) {
        self.setSelectItem(index: 2)
        thirdVC.updatedLocation()
    }
}

