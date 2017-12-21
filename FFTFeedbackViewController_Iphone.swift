//
//  FFTFeedbackViewController_Iphone.swift
//  FFT Form
//
//  Created by Welltime on 25/09/2017.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class FFTFeedbackViewController_Iphone: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
   
    @IBAction func logout_click(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginIphoneVC") as! LoginViewController_Iphone
        
        self.present(vc, animated: true, completion: nil)
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        var url_str = "http://ds8223.dedicated.turbodns.co.uk/patientconnections/patient/fftfeedback.aspx?clientid=20990696-8b85-4e23-9596-6b24b8888ef8"
        
        
        
        let url = URL (string: url_str)
        
        
        
        let requestObj = URLRequest(url: url! as URL)
        
        
        self.webView.loadRequest(requestObj as URLRequest);
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
