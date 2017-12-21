//
//  FeedbackViewController_Q2_Iphone.swift
//  FFT Form
//
//  Created by Welltime on 18/09/2017.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class FeedbackViewController_Q2_Iphone: UIViewController,UITextViewDelegate, UITextFieldDelegate{
    
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    
    @IBOutlet weak var checkbox_yes: VKCheckbox!
    var patientName = ""

    @IBOutlet weak var txt_name: UITextField!
    
    var satisfactionDescription = ""
    
    var commentsForPractice = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    
    @IBOutlet weak var details_tv: GCPlaceholderTextView!
      var alert : UIAlertView = UIAlertView(title:nil , message: "Sending message..." , delegate: nil, cancelButtonTitle: nil)
    
var ischecked = false
    
  
    

    @IBAction func back_click(_ sender: Any) {
       
        let storyboard = UIStoryboard(name: "Main_iphone", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FeedbackIphoneQ1VC") as! FeedbackViewController_Q1_Iphone
        
            
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func send_click(_ sender: Any) {
        
       patientName = self.txt_name.text!
        commentsForPractice = self.details_tv.text
        
        if (commentsForPractice == "")  {
            let alertview:UIAlertView = UIAlertView(title: nil, message: "Please provide your reviews", delegate: self, cancelButtonTitle: "OK")
            alertview.show()
            return
            
            // either textfield 1 or 2's text is empty
        }
        
        sendData()
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.details_tv.delegate=self as! UITextViewDelegate;
        self.details_tv.isEditable=true;
        checkbox_yes.setOn(false)
        checkbox_yes.setOn(false)
        
        
        checkbox_yes.checkboxValueChangedBlock = {
            isOn in
            
                self.ischecked = true

            
            print("Custom checkbox is \(isOn ? "ON" : "OFF")")
        }

       
        
        
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ////////// ************** textView Methods *************/////////////
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        myScrollView.setContentOffset(CGPoint(x: 0, y:250), animated: true)
        
        
        
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        myScrollView.setContentOffset(CGPoint(x: 0, y:0), animated: true)
    }
    
    
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing:")
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing:")
        textView.backgroundColor = UIColor.white
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("textViewShouldEndEditing:")
        textView.backgroundColor = UIColor.white
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing:")
        details_tv.text = textView.text
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange:")
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("textViewDidChangeSelection:")
    }
    

    
    
    func sendData()
    {
        let viewBack:UIView = UIView(frame: CGRect(x: 83,y: 0,width: 100,height: 60))
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 57, height: 57))
        loadingIndicator.center = viewBack.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        viewBack.addSubview(loadingIndicator)
        viewBack.center = self.view.center
        alert.setValue(viewBack, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        
        alert.show()
        
        
        
        let postEndpoint: String = "https://onlineservices.patientconnections.co.uk/OnlineServices/RestServices.svc/InsertGPFFTAnswers"
        let url = URL(string: postEndpoint)!
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        var request = URLRequest(url: url)
        
                
        request.httpMethod = "POST"
        
        
        
        
        
        var username =  UserDefaults.standard.value(forKey: "USERNAME") as! String
        
        var password =  UserDefaults.standard.value(forKey: "PASSWORD") as! String
        
        
       
        
        
        do {
            
            
            
            let dic = ["satisfactionDescription":self.satisfactionDescription,"commentsForPractice":details_tv.text!,"isAnonymous":ischecked,"patientName":ischecked] as [String : Any]
            
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            //  let jsonObject: AnyObject = json.object
            request.httpBody = jsonData
            
            //try NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions())
            
        } catch {
            print("bad things happened")
        }
        
        
        var authStr: String = "\(username):\(password)"
        let data = (authStr).data(using: String.Encoding.utf8)
        let authValue = "Basic \(data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))"
        
        
        
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        session.dataTask(with: request, completionHandler: { ( data: Data?, response: URLResponse?, error: Error?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? HTTPURLResponse   ,
                realResponse.statusCode == 200 else {
                    
                    print("Response:\(response as? HTTPURLResponse)")
                    self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
                    let realResp = response as? HTTPURLResponse
                    
                    
                    if(realResp?.statusCode == 401)
                    {   let alertview:UIAlertView = UIAlertView(title: "UnAuthorized Access", message: nil, delegate: self, cancelButtonTitle: "OK")
                        alertview.show()
                        return
                        
                        
                        
                    }
                        
                    else if(realResp?.statusCode == 400 || realResp?.statusCode == 500)
                    {
                        
                        
                        let alertview:UIAlertView = UIAlertView(title: "Server Error", message: "Sorry ... Server is down at the moment", delegate: self, cancelButtonTitle: "OK")
                        alertview.show()
                        return
                        
                        
                    }
                    
                    return
                    
                    //////
                    
                    
            }
            
            if let postString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue) as? String {
                
                print("POST: " + postString)
                
                
                if(postString.contains("true"))
                { self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
                    let alertview:UIAlertView = UIAlertView(title: "Inserted successfully!", message: "", delegate: self, cancelButtonTitle: "OK")
                    alertview.show()}
                    
                else
                {
                    self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
                    let alertview:UIAlertView = UIAlertView(title: "Server down at the moment... Please try later ", message: "", delegate: self, cancelButtonTitle: "OK")
                    alertview.show()
                }
                
                return
                
            }
            
            
            
        }).resume()
        
        
    }

}
