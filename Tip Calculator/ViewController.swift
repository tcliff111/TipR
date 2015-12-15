//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Thomas Clifford on 12/5/15.
//  Copyright (c) 2015 Thomas Clifford. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var percentButton: UISegmentedControl!
    
    var key1 = "firstKey"
    var key2 = "secondKey"
    var key3 = "thirdKey"
    var percentages = [Double]()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("18", forKey: key1)
        defaults.setObject("20", forKey: key2)
        defaults.setObject("22", forKey: key3)
        defaults.synchronize()
        percentages.append(0.1)
        percentages.append(0.1)
        percentages.append(0.1)
        percentButton.setTitle("18%", forSegmentAtIndex: 0)
        percentButton.setTitle("20%", forSegmentAtIndex: 1)
        percentButton.setTitle("22%", forSegmentAtIndex: 2)

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let first:Int? = Int(defaults.objectForKey(key1) as! String)
        let second:Int? = Int(defaults.objectForKey(key2) as! String)
        let third:Int? = Int(defaults.objectForKey(key3) as! String)
        
        if(first != nil && second != nil && third != nil) {
            percentages[0] = Double(first!)/100.00
            percentages[1] = Double(second!)/100.00
            percentages[2] = Double(third!)/100.00
            
            percentButton.setTitle(String(first!)+"%", forSegmentAtIndex: 0)
            percentButton.setTitle(String(second!)+"%", forSegmentAtIndex: 1)
            percentButton.setTitle(String(third!)+"%", forSegmentAtIndex: 2)
        }
        else {
            percentages[0] = 0.18
            percentages[1] = 0.2
            percentages[2] = 0.22
            
            percentButton.setTitle("18%", forSegmentAtIndex: 0)
            percentButton.setTitle("20%", forSegmentAtIndex: 1)
            percentButton.setTitle("22%", forSegmentAtIndex: 2)
        }
        let percent = percentages[percentButton.selectedSegmentIndex]
        
        if let billAmount = Double(billField.text!) {
            
            let tip = billAmount*percent
            let total = billAmount + tip
            
            tipLabel.text = String(format: "$%.2f", tip)
            
            totalLabel.text = String(format: "$%.2f", total)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let percent = percentages[percentButton.selectedSegmentIndex]
        
        if let billAmount = Double(billField.text!) {
      
        let tip = billAmount*percent
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)

        totalLabel.text = String(format: "$%.2f", total)
        }
    }
  
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

