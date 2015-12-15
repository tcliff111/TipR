//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Thomas Clifford on 12/9/15.
//  Copyright © 2015 Thomas Clifford. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var firstTip: UITextField!
    @IBOutlet weak var secondTip: UITextField!
    @IBOutlet weak var thirdTip: UITextField!
    var key1 = "firstKey"
    var key2 = "secondKey"
    var key3 = "thirdKey"

    
    @IBAction func screenTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        firstTip.text=defaults.objectForKey(key1) as? String
        secondTip.text=defaults.objectForKey(key2) as? String
        thirdTip.text=defaults.objectForKey(key3) as? String

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDefaults(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(firstTip.text, forKey: key1)
        defaults.setObject(secondTip.text, forKey: key2)
        defaults.setObject(thirdTip.text, forKey: key3)
        defaults.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
