//
//  FeedbackViewController_Swift.swift
//  FFT Form
//
//  Created by Welltime on 07/09/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class FeedbackViewController_Swift: UIViewController,UITableViewDataSource,
UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIPopoverPresentationControllerDelegate{
    
      var selectedItem = ""
   
    var ischecked = false
    
    var patientName = ""
    @IBOutlet weak var txt_name: UITextField!
   
    @IBOutlet weak var checkbox_yes: VKCheckbox!
    
   
    
    
  
    @IBOutlet weak var myView: KeyboardDismissingView!
    
    
    @IBOutlet weak var details_tv: GCPlaceholderTextView!
        @IBOutlet weak var tblView: UITableView!
    var commentsForPractice = ""
    
    var myData = NSMutableArray()
   var myImages = NSMutableArray()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    @IBOutlet weak var myScrollView: UIScrollView!
   
    
    @IBOutlet weak var lbl1: UILabel!
    
    
    @IBOutlet weak var lbl2: UILabel!
    
     var autocompleteUrls = NSMutableArray()
    
    var pastUrls:NSMutableArray = []
     var alert : UIAlertView = UIAlertView(title:nil , message: "Sending message..." , delegate: nil, cancelButtonTitle: nil)
    
    override func viewDidAppear(_ animated: Bool) {
       KeyboardAvoiding.avoidingView = self.details_tv
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.hideKeyboard()'

  
        
        
        checkbox_yes.setOn(false)
        self.lbl1.font = UIFont.boldSystemFont(ofSize: self.lbl1.font.pointSize)
        
        self.lbl2.font = UIFont.boldSystemFont(ofSize: self.lbl2.font.pointSize)
        

        
        
        checkbox_yes.checkboxValueChangedBlock = {
            isOn in
            
            
                self.ischecked = true
            
       
            
            print("Custom checkbox is \(isOn ? "ON" : "OFF")")
        }
        
        
        
        
        
        self.details_tv.delegate=self;
        self.details_tv.textColor = UIColor.black
        self.details_tv.isEditable=true;
        
       
     myData =   ["Extremely likely","Likely","Neither likely nor unlikely","Unlikely","Extremely unlikely","Dont Know"]
        
  myImages = ["icon_extremely_likely.png","icon_likely.png","icon_neither.png","icon_unhappy.png","icon_extremely_unlikely.png","icon_dont_know.png"]
        
        
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func logout_click(_ sender: Any) {
       
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        self.present(vc2, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func send_click(_ sender: Any) {
        
        patientName = self.txt_name.text!
        commentsForPractice = self.details_tv.text
        if  (selectedItem == "") || (commentsForPractice == ""){
            var alert = UIAlertView(title: "", message: "Please fill all the required fields", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "OK", otherButtonTitles: "")
            alert.show()
            return
        }
        
        
        sendData()
        
        
    }
    
    

    ///// ******************* TableView Delegate Methods ****************** //////////
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.myData.count;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
               var cell: FeedbackTableViewCell_Swift? = tableView.cellForRow(at: indexPath) as! FeedbackTableViewCell_Swift
        if cell?.accessoryType == UITableViewCellAccessoryType.none{
            cell?.accessoryType = .checkmark
            selectedItem = myData[indexPath.row] as! String
            print("selected item:\(selectedItem)")
        }
        else {
            cell?.accessoryType = UITableViewCellAccessoryType.none
        }
        tblView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           var cell2: FeedbackTableViewCell_Swift
        
        cell2 = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath) as! FeedbackTableViewCell_Swift

         cell2.lbl_name.text = myData[indexPath.row] as! String
        cell2.img_icon.image = UIImage(named:myImages[indexPath.row] as! String )
       
        
        if (selectedItem == myData[indexPath.row] as! String) {
            cell2.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        else {
            cell2.accessoryType = UITableViewCellAccessoryType.none
        }
 
        
        return cell2
    }

  //////////////
    
    
    
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
            
            
            
            let dic = ["satisfactionDescription":self.selectedItem,"commentsForPractice":details_tv.text!,"isAnonymous":ischecked,"patientName":ischecked] as [String : Any]
            
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
    
    
    ////////// ************** textView Methods *************/////////////
    
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


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

//extension UIViewController
//{
//    func hideKeyboard()
//    {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(UIViewController.dismissKeyboard))
//        
//        view.addGestureRecognizer(tap)
//    }
//    
//    func dismissKeyboard()
//    {
//        view.endEditing(true)
//    }
//}
