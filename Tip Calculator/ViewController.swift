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
    @IBOutlet weak var total2: UILabel!
    @IBOutlet weak var total3: UILabel!
    @IBOutlet weak var total4: UILabel!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var percentButton: UISegmentedControl!
    
    var key1 = "firstKey"
    var key2 = "secondKey"
    var key3 = "thirdKey"
    var closeKey = "closingKey"
    var percentages = [Double]()
    var openingTime: NSDate? = nil
    var closingTime: NSDate? = nil
    let formatter = NSNumberFormatter()
    var tipLabelY: CGFloat = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabelY = tipLabel.frame.origin.y
        tipLabel.frame.origin.y += 400;
        totalLabel.frame.origin.y += 400;
        total2.frame.origin.y += 400;
        total3.frame.origin.y += 400;
        total4.frame.origin.y += 400;
        blackView.frame.origin.y += 400;
        percentButton.frame.origin.y += 400;
        billField.frame.origin.y += 100;
        
        // Do any additional setup after loading the view, typically from a nib.
        formatter.numberStyle = .CurrencyStyle
        billField.textAlignment = .Right
        billField.attributedPlaceholder = NSAttributedString(string:formatter.currencySymbol,
            attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        reset()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        billField.becomeFirstResponder()
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
            percentages[0] = 0.15
            percentages[1] = 0.18
            percentages[2] = 0.2
            
            percentButton.setTitle("15%", forSegmentAtIndex: 0)
            percentButton.setTitle("18%", forSegmentAtIndex: 1)
            percentButton.setTitle("20%", forSegmentAtIndex: 2)
        }
        
        let percent = percentages[percentButton.selectedSegmentIndex]
        
        if let billAmount = Double(billField.text!) {
            
            let tip = billAmount*percent
            let total = billAmount + tip
            
            tipLabel.text = "+ "+formatter.stringFromNumber(tip)!
            totalLabel.text = formatter.stringFromNumber(total)
            total2.text = formatter.stringFromNumber(total/2)
            total3.text = formatter.stringFromNumber(total/3)
            total4.text = formatter.stringFromNumber(total/4)
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
        
        tipLabel.text = "+ "+formatter.stringFromNumber(tip)!
        totalLabel.text = formatter.stringFromNumber(total)
        total2.text = formatter.stringFromNumber(total/2)
        total3.text = formatter.stringFromNumber(total/3)
        total4.text = formatter.stringFromNumber(total/4)
            if(tipLabelY != tipLabel.frame.origin.y) {
            UIView.animateWithDuration(0.4, animations: {
                self.tipLabel.frame.origin.y -= 400;
                self.totalLabel.frame.origin.y -= 400;
                self.total2.frame.origin.y -= 400;
                self.total3.frame.origin.y -= 400;
                self.total4.frame.origin.y -= 400;
                self.blackView.frame.origin.y -= 400;
                self.percentButton.frame.origin.y -= 400;
                self.billField.frame.origin.y -= 100;
            })
            }
        }
         else if(billField.text!.isEmpty) {
            if(tipLabelY == tipLabel.frame.origin.y) {
            UIView.animateWithDuration(0.4, animations: {
                self.tipLabel.frame.origin.y += 400;
                self.totalLabel.frame.origin.y += 400;
                self.total2.frame.origin.y += 400;
                self.total3.frame.origin.y += 400;
                self.total4.frame.origin.y += 400;
                self.blackView.frame.origin.y += 400;
                self.percentButton.frame.origin.y += 400;
                self.billField.frame.origin.y += 100;
            })
            }
            tipLabel.text = "+ "+formatter.stringFromNumber(0)!
            totalLabel.text = formatter.stringFromNumber(0)
            total2.text = formatter.stringFromNumber(0)
            total3.text = formatter.stringFromNumber(0)
            total4.text = formatter.stringFromNumber(0)
        }
    }
    
    func reset() {
        billField.text=""
        tipLabel.text = "+ "+formatter.stringFromNumber(0)!
        totalLabel.text = formatter.stringFromNumber(0)
        total2.text = formatter.stringFromNumber(0)
        total3.text = formatter.stringFromNumber(0)
        total4.text = formatter.stringFromNumber(0)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("15", forKey: key1)
        defaults.setObject("18", forKey: key2)
        defaults.setObject("20", forKey: key3)
        defaults.synchronize()
        percentages.append(0.1)
        percentages.append(0.1)
        percentages.append(0.1)
        percentButton.setTitle("15%", forSegmentAtIndex: 0)
        percentButton.setTitle("18%", forSegmentAtIndex: 1)
        percentButton.setTitle("20%", forSegmentAtIndex: 2)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
//        func compareTimes(opens: NSDate?, closes: NSDate?) {
//            print("compare")
//            if(opens!.timeIntervalSinceReferenceDate-closes!.timeIntervalSinceReferenceDate>3) {
//                reset()
//                print("op")
//            }
//        }
//        func openApp() {
//            print("open")
//            openingTime = NSDate()
//            let defaults = NSUserDefaults.standardUserDefaults()
//            closingTime = defaults.objectForKey(closeKey) as! NSDate?
//            if (closingTime != nil) {
//                compareTimes(openingTime, closes: closingTime)
//            }
//        }
//    
//        func closeApp() {
//            print("close")
//            closingTime = NSDate()
//            let defaults = NSUserDefaults.standardUserDefaults()
//            defaults.setObject(closingTime, forKey: closeKey)
//        }


}

