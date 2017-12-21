//
//  SettingsViewController_Swift.swift
//  FFT Form
//
//  Created by Welltime on 10/09/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class SettingsViewController_Swift: UIViewController {

    @IBOutlet weak var toggle_button: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        var userDefaults = UserDefaults.standard
        let enabled = userDefaults.value(forKey: "ENABLE_EQUALITY_FORM") as! Bool
        
        if(enabled)
        {toggle_button.setOn(true, animated: true)}
        else{
        
        toggle_button.setOn(false, animated: true)}
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toggle_changed(_ sender: Any) {
        
        if toggle_button.isOn {
            var userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "ENABLE_EQUALITY_FORM")
            userDefaults.synchronize()
        }
        else {
            var userDefaults = UserDefaults.standard
            userDefaults.set(false, forKey: "ENABLE_EQUALITY_FORM")
            userDefaults.synchronize()
        }
   
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
