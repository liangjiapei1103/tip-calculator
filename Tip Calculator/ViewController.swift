//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Jiapei Liang on 1/15/17.
//  Copyright © 2017 jiapei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var tipTotalContainer: UIView!
    
    @IBAction func onTap(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billTextField.becomeFirstResponder()
        
        let defaults = UserDefaults.standard
        
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "DefaultTipPercentage")
        
        billTextField.text = defaults.string(forKey: "billAmount")
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = NSLocale.current
        
        billTextField.placeholder = currencyFormatter.string(from: 0 as NSNumber)
        tipLabel.text = currencyFormatter.string(from: 0 as NSNumber)
        totalLabel.text = currencyFormatter.string(from: 0 as NSNumber)
        
        calculateTip(self)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "DefaultTipPercentage")
        
        tipTotalContainer.alpha = 0
        
        calculateTip(self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        billTextField.becomeFirstResponder()
        
        
        UIView.animate(withDuration: 1, animations: {
            self.tipTotalContainer.alpha = 1
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeTipPercent(_ sender: Any) {
        calculateTip(self)
    }

    @IBAction func calculateTip(_ sender: Any) {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = NSLocale.current
        
        let tipPercentages = [0.15, 0.18, 0.20]
        
        let bill = Double(billTextField.text!) ?? 0
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        
        let total = bill + tip
        
        tipLabel.text = currencyFormatter.string(from: tip as NSNumber)
        
        totalLabel.text = currencyFormatter.string(from: total as NSNumber)
        
        
        let defaults = UserDefaults.standard
        
        if bill == 0 {
            defaults.set("", forKey: "billAmount")
        } else {
            defaults.set(bill, forKey: "billAmount")
        }
        
        
        
        defaults.synchronize()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        let backItem = UIBarButtonItem()
        backItem.title = "Done"
        navigationItem.backBarButtonItem = backItem
    }

}

