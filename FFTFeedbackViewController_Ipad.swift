//
//  FFTFeedbackViewController_Ipad.swift
//  FFT Form
//
//  Created by Welltime on 22/09/2017.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class FFTFeedbackViewController_Ipad: UIViewController {
    
    
    @IBOutlet weak var webview: UIWebView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    @IBAction func logout_click(_ sender: Any) {
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController_Swift
        
        self.present(vc, animated: true, completion: nil)
        
        
    }
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        var client_id_str =  UserDefaults.standard.value(forKey: "ORGANIZATION_ACCESS_KEY") as! String
        var client_id = client_id_str.replacingOccurrences(of: "\"", with: "")
        
        
        var url_str = "http://ds8223.dedicated.turbodns.co.uk/patientconnections/patient/fftfeedback.aspx?clientid=\(client_id)"
            
        
        
      
        
        let url = URL (string: url_str)
        
        
        
        let requestObj = URLRequest(url: url! as URL)
      
        
        self.webview.loadRequest(requestObj as URLRequest);
        
        // Do any additional setup after loading the view.
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
