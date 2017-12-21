//
//  LoginViewController_Swift.swift
//  FFT Form
//
//  Created by Welltime on 10/09/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class LoginViewController_Swift: UIViewController {
    
    
    @IBOutlet weak var txt_username: UITextField!
    
    
    @IBOutlet weak var txt_password: UITextField!
    
    var alert1 : UIAlertView = UIAlertView(title:nil , message: "Sending message..." , delegate: nil, cancelButtonTitle: nil)
    
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
     
     //   UINavigationBar.appearance().titleTextAttributes = [UITextAttributeTextColor: UIColor.white]
        
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func login_click(_ sender: Any) {
        
        sendData()
    }
    
    
   
   
    
    func sendData()
    {
        
        
        
        var username = self.txt_username.text
        
        var password = self.txt_password.text
        
        if (username == "") || (password  == "") {
            let alertview:UIAlertView = UIAlertView(title: "Invalid Data", message: "Enter all the required fields", delegate: self, cancelButtonTitle: "OK")
            alertview.show()
            return
            
            // either textfield 1 or 2's text is empty
        }
        
        let viewBack:UIView = UIView(frame: CGRect(x: 83,y: 0,width: 100,height: 60))
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 57, height: 57))
        loadingIndicator.center = viewBack.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        viewBack.addSubview(loadingIndicator)
        viewBack.center = self.view.center
        alert1.setValue(viewBack, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        
        alert1.show()
        
        let postEndpoint: String = "https://onlineservices.patientconnections.co.uk/OnlineServices/RestServices.svc/GetOrganizationAccessKey"
        let url = URL(string: postEndpoint)!
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        var authStr: String = "\(username!):\(password!)"
        let data = (authStr).data(using: String.Encoding.utf8)
        let authValue = "Basic \(data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))"
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request, completionHandler: { ( data: Data?, response: URLResponse?, error: Error?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? HTTPURLResponse   ,
                realResponse.statusCode == 200 else {
                    
                    print("Response:\(response as? HTTPURLResponse)")
                    self.alert1.dismiss(withClickedButtonIndex: -1, animated: true)
                    let realResp = response as? HTTPURLResponse
                    
                    if(realResp?.statusCode == 401)
                    {
                        let alertview:UIAlertView = UIAlertView(title: "Unauthenticated User", message: "Invalid username or password ", delegate: self, cancelButtonTitle: "OK")
                        alertview.show()
                        return
                        
                    }
                   
                        
                   if(realResp?.statusCode == 400 || realResp?.statusCode == 500)
                    {
                        
                        
                        let alertview:UIAlertView = UIAlertView(title: "Server Error", message: "Sorry ... Server is down at the moment", delegate: self, cancelButtonTitle: "OK")
                        alertview.show()
                        return
                        
                        
                    }
                    
                    return
                    
                    //////
                    
                    
            }
            
            // Read the JSON
            if let postString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue) as? String {
                // Print what we got from the call
                print("POST: " + postString)
                
                
                
                self.alert1.dismiss(withClickedButtonIndex: -1, animated: true)
                
                
                var defaults = UserDefaults.standard
                defaults.set(self.txt_username.text, forKey: "USERNAME")
                defaults.set(self.txt_password.text, forKey: "PASSWORD")
                defaults.set(postString ,forKey: "ORGANIZATION_ACCESS_KEY" )
                
                 defaults.synchronize()
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc2 = storyboard.instantiateViewController(withIdentifier: "FeedbackVC")
                self.present(vc2, animated: true, completion: nil)
            }
            
            
            
            
        }).resume()
        

        
        
   ///////
    
    

            

            
    
     //   task.resume()
        
        
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
