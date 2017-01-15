//
//  SettingViewController.swift
//  Tip Calculator
//
//  Created by Jiapei Liang on 1/15/17.
//  Copyright © 2017 jiapei. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Setting"
        
        let defaults = UserDefaults.standard
        
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "DefaultTipPercentage")
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeDefaultTipPercentage(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(tipControl.selectedSegmentIndex, forKey: "DefaultTipPercentage")
        
        defaults.synchronize()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
