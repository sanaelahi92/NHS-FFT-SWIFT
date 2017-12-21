//
//  PatientDetailsViewController_Swift.swift
//  FFT Form
//
//  Created by Welltime on 08/09/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class PatientDetailsViewController_Swift: UIViewController,UITableViewDataSource,
UITableViewDelegate,UITextFieldDelegate {
   // @available(iOS 2.0, *)
    

    var genderArray:NSArray = []
    var ageArray:NSArray = []
    var disabledPersonArray:NSArray = []
    
    var satisfactionDescription = ""
   var commentsForPractice = ""
   var isAnonymous = ""
   var user_name = ""
var user_email = ""
    var user_mobile = ""
   var patient_Type = ""
   var allowPublishing = ""
    
    
    
    var ethnicGroupArray0:NSArray = []
    var ethnicGroupArray1:NSArray = []
    var ethnicGroupArray3:NSArray = []
    var selectedGender = ""
    var selectedAge = ""
   var selectedDisability = ""
  var selectedEthinicGroup = ""
    
    
    
    @IBOutlet weak var tableView4: UITableView!
    
    @IBOutlet weak var tableView1: UITableView!
    
    
    @IBOutlet weak var tableView2: UITableView!
    
    @IBOutlet weak var tableView3: UITableView!
    
    
    var textEdited:Bool = false
    var tag = 0
    
    var alert : UIAlertView = UIAlertView(title:nil , message: "Sending message..." , delegate: nil, cancelButtonTitle: nil)
    
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderArray = ["Female","Male","Prefer not to say"]
        ageArray=["Under 16","16-19","20-25","26-34","35-44","45-54","55-64","65 plus","Prefer not to say"]
        
       ethnicGroupArray0 = ["Scotish","Other British","Irish","Write"]
        
    
       ethnicGroupArray1 = ["Indian","Pakistani","Bangladeshi","Chinese","Write"]
    ethnicGroupArray3=["African","Caribbean","Write"]
       
       disabledPersonArray=[
            "Yes","No","Prefer not to say"]
        
        
        
//         self.tableView3.register(SimpleTableCell_Swift.self, forCellReuseIdentifier:  "SimpleTableCell_Swift3")
//        
   //     self.tableView1.register(SimpleTableViewCell_Swift2.self, forCellReuseIdentifier: "Cell")
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    ///// ******************* TableView Delegate Methods ****************** //////////
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count=0;
        if (tableView.tag == 1) {
            count = 3;
        }
        else if (tableView.tag == 2) {
            count = 9;
        }
        else if (tableView.tag == 3) {
            
            switch (section) {
            case 0: return 4
            case 1: return 5
            case 2: return 1
            case 3: return 3
            case 4: return 1
            case 5: return 1
            default:
                break
            }
            
        }
        else if (tableView.tag == 4) {
            count=3
        }
        return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 3 {
            return 6
        }
        else {
            return 1
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        if tableView.tag == 1 {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "Question1",
                                                     for: indexPath) as! Question1TableViewCell
            cell.lbl_text.text = genderArray[indexPath.row] as! String
            if (selectedGender == genderArray[indexPath.row] as! String ) {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            
            return cell
        }
            
                    else if tableView.tag == 2 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "Question2",
                                                     for: indexPath) as! Question2TableViewCell
                        cell.lbl_text?.text = ageArray[indexPath.row] as! String
                        if (selectedAge == ageArray[indexPath.row] as! String) {
                            cell.accessoryType = UITableViewCellAccessoryType.checkmark
                        }
                        else {
                            cell.accessoryType = UITableViewCellAccessoryType.none
                        }
             return cell
                    }
                    else if tableView.tag == 4 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "Question4",
                                                     for: indexPath) as! Question4TableViewCell
                        cell.lbl_text?.text = disabledPersonArray[indexPath.row] as! String
                        if (selectedDisability == disabledPersonArray[indexPath.row]
                            as! String) {
                            cell.accessoryType = UITableViewCellAccessoryType.checkmark
                        }
                        else {
                            cell.accessoryType = UITableViewCellAccessoryType.none
                        }
            
             return cell
                    }
            
        
            
        else if (tableView.tag == 3)
        {
            if(indexPath.section==0)
            {
                
                if ((self.ethnicGroupArray0[indexPath.row] as! String) == "Write"){
                    
                    var cell2: Question3TableViewCell_2
                    
                    cell2 = tableView.dequeueReusableCell(withIdentifier: "Question3_2", for: indexPath) as! Question3TableViewCell_2
                    
                   
                    cell2.question3textfield?.tag = 6
                    cell2.question3textfield?.delegate = self as! UITextFieldDelegate
                    if textEdited && tag == 6 {
                        cell2.question3textfield?.text = selectedEthinicGroup
                    }
                    else {
                        cell2.question3textfield?.text = ""
                    }
                    cell2.accessoryType = UITableViewCellAccessoryType.none
                   
                    return cell2
                    
                    
                }
                    
                else
                {
                    
                    var cell: Question3TableViewCell
                    
                    cell = tableView.dequeueReusableCell(withIdentifier: "Question3", for: indexPath) as! Question3TableViewCell
                    cell.lbl_text.text = ethnicGroupArray0[indexPath.row] as! String
                    if (selectedEthinicGroup == ethnicGroupArray0[indexPath.row] as! String) && (!textEdited) {
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    }
                    else {
                        cell.accessoryType = UITableViewCellAccessoryType.none
                    }
                     return cell
                    
                }
                
                
            }
                
            else if(indexPath.section==1)
            {
                if((self.ethnicGroupArray1[indexPath.row] as! String) == "Write")
                { var cell2: Question3TableViewCell_2
                
                cell2 = tableView.dequeueReusableCell(withIdentifier: "Question3_2", for: indexPath) as! Question3TableViewCell_2
                    cell2.question3textfield?.tag = 1
                cell2.question3textfield?.delegate = self as! UITextFieldDelegate
                if textEdited && tag == 1{
                    cell2.question3textfield?.text = selectedEthinicGroup
                }
                else {
                    cell2.question3textfield?.text = ""
                }
                cell2.accessoryType = UITableViewCellAccessoryType.none
               
                    return cell2}
                
                else{
                
                    
                    var cell: Question3TableViewCell
                    
                    cell = tableView.dequeueReusableCell(withIdentifier: "Question3", for: indexPath) as! Question3TableViewCell
                    cell.lbl_text.text = ethnicGroupArray1[indexPath.row] as! String
                    if (selectedEthinicGroup == ethnicGroupArray1[indexPath.row] as! String) && (!textEdited) {
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    }
                    else {
                        cell.accessoryType = UITableViewCellAccessoryType.none
                    }
                    
                     return cell
   
                }
                
                
            }
                
            else if (indexPath.section==3)
            {
                if((self.ethnicGroupArray3[indexPath.row] as! String) == "Write")
                { var cell2: Question3TableViewCell_2
                    
                    cell2 = tableView.dequeueReusableCell(withIdentifier: "Question3_2", for: indexPath) as! Question3TableViewCell_2
                    cell2.question3textfield?.tag = 3
                    cell2.question3textfield?.delegate = self as! UITextFieldDelegate
                    if textEdited && tag == 3                                                                                                                                                   {
                        cell2.question3textfield?.text = selectedEthinicGroup
                    }
                    else {
                        cell2.question3textfield?.text = ""
                    }
                    cell2.accessoryType = UITableViewCellAccessoryType.none
                    
                    return cell2}
                    
                else{
                    
                    
                    var cell: Question3TableViewCell
                    
                    cell = tableView.dequeueReusableCell(withIdentifier: "Question3", for: indexPath) as! Question3TableViewCell
                    cell.lbl_text.text = ethnicGroupArray3[indexPath.row] as! String
                    if (selectedEthinicGroup == ethnicGroupArray3[indexPath.row] as! String) && (!textEdited) {
                        cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    }
                    else {
                        cell.accessoryType = UITableViewCellAccessoryType.none
                    }
                    
                     return cell
                    
                }
                
            
            
            
            }
             
            else if(indexPath.section==2)
            {
                var cell2: Question3TableViewCell_2
                
                cell2 = tableView.dequeueReusableCell(withIdentifier: "Question3_2", for: indexPath) as! Question3TableViewCell_2
                cell2.question3textfield?.tag = 2
                cell2.question3textfield?.delegate = self as! UITextFieldDelegate
                if textEdited && tag == 2   {
                    cell2.question3textfield?.text = selectedEthinicGroup
                }
                else {
                    cell2.question3textfield?.text = ""
                }
                cell2.accessoryType = UITableViewCellAccessoryType.none
                
                return cell2
                
            }

                
                
            else if(indexPath.section==4)
            {
                var cell2: Question3TableViewCell_2
                
                cell2 = tableView.dequeueReusableCell(withIdentifier: "Question3_2", for: indexPath) as! Question3TableViewCell_2
                
                
                cell2.question3textfield?.tag = 4
                cell2.question3textfield?.delegate = self as! UITextFieldDelegate
                if textEdited && tag == 4 {
                    cell2.question3textfield?.text = selectedEthinicGroup
                }
                else {
                    cell2.question3textfield?.text = ""
                }
                cell2.accessoryType = UITableViewCellAccessoryType.none
                
                return cell2
                
            }
            else if(indexPath.section==5)
            {
                var cell = tableView.dequeueReusableCell(withIdentifier: "Question3",
                                                         for: indexPath) as! Question3TableViewCell
                
                
                cell.lbl_text.text = "Prefer not to say"
                if (selectedEthinicGroup == "Prefer not to say") && (!textEdited) {
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.none
                }
                 return cell
                
                
            }
            
            //     cell.backgroundColor = color(withHexString: "F5F3E6")
            //     cell.contentView.backgroundColor = color(withHexString: "F5F3E6")
           
            
        }
        
       return UITableViewCell()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell: UITableViewCell? = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == UITableViewCellAccessoryType.none {
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
            if tableView.tag == 1 {
                selectedGender = genderArray[indexPath.row] as! String
            }
            else if tableView.tag == 2 {
                selectedAge = ageArray[indexPath.row] as! String
            }
            else if tableView.tag == 3 {
                if indexPath.section == 0 {
                    selectedEthinicGroup = ethnicGroupArray0[indexPath.row] as! String
                }
                else if indexPath.section == 1 {
                    selectedEthinicGroup = ethnicGroupArray1[indexPath.row] as! String
                }
                else if indexPath.section == 3 {
                    selectedEthinicGroup = ethnicGroupArray3[indexPath.row] as! String
                }
                else if indexPath.section == 5 {
                    selectedEthinicGroup = "Prefer not to say"
                }
            }
            else if tableView.tag == 4 {
                selectedDisability = disabledPersonArray[indexPath.row] as! String
                
                textEdited = false }
                
            else {
                cell?.accessoryType = UITableViewCellAccessoryType.none ;
                
            }
            print("selected gender \(selectedGender)")
            tableView.reloadData()
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerTitle: String = ""
        if tableView.tag == 3 {
            if section == 0 {
                headerTitle = "White"
            }
            else if section == 1 {
                headerTitle = "Asian"
            }
            else if section == 2 {
                headerTitle = "Multiple ethnic background"
            }
            else if section == 3 {
                headerTitle = "Black"
            }
            else if section == 4 {
                headerTitle = "Other background"
            }
            else if section == 5 {
                headerTitle = "Prefer not to say"
            }
        }
        else if tableView.tag == 1 {
            headerTitle = "Select an option"
        }
        else if tableView.tag == 2 {
            headerTitle = "Select an option"
        }
        else if tableView.tag == 4 {
            headerTitle = "Select an option"
        }
        
        return headerTitle
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 8, y: 3, width: 330, height: 15)
        myLabel.font = UIFont.boldSystemFont(ofSize: 14)
        myLabel.backgroundColor = UIColor(red: 93 / 256.0, green: 181 / 256.0, blue: 164 / 256.0, alpha: 1.0)
        myLabel.textColor = UIColor(red: 255 / 256.0, green: 255 / 256.0, blue: 255 / 256.0, alpha: 1.0)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        //myLabel.backgroundColor=[UIColor colorWithRed:255/256.0 green:182/256.0 blue:193/256.0 alpha:1.0];
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 93 / 256.0, green: 181 / 256.0, blue: 164 / 256.0, alpha: 1.0)
        headerView.addSubview(myLabel)
        return headerView
    }

    
    
    
    

        
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        selectedEthinicGroup = textField.text!
        tag = textField.tag
        textEdited = true
        tableView3.reloadData()
        textField.resignFirstResponder()
        print(selectedEthinicGroup)
        return true
    }

        
        
    @IBAction func send_click(_ sender: Any) {
        
        if (selectedGender == "") || (selectedDisability == "") || (selectedAge == "") || (selectedEthinicGroup == "") {
            var alert = UIAlertView(title: "Invalid Data", message: "Please provide feedback to all required questions...", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "OK", otherButtonTitles: "")
            alert.show()
            return
        }
        
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
        
        
        let postEndpoint: String = "http://onlineservices.patientconnections.co.uk/OnlineServices/RestServices.svc/InsertFFTAnswers"
        let url = URL(string: postEndpoint)!
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        
        
        
        var username =  UserDefaults.standard.value(forKey: "USERNAME") as! String
        
        var password =  UserDefaults.standard.value(forKey: "PASSWORD") as! String
        
        do {
            
            
            
            
            
            let dic = ["satisfactionDescription":self.satisfactionDescription,"commentsForPractice":commentsForPractice,"isAnonymous":isAnonymous,"allowPublishing":allowPublishing,"patientName":user_name,"age":self.selectedAge,"gender":self.selectedGender,"ethnicGroup":self.selectedEthinicGroup,"disabled":self.selectedDisability,"mobile":user_mobile,"email":user_email,"customerType":patient_Type] as [String : Any]
            
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            //  let jsonObject: AnyObject = json.object
            print(dic)
            
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
      
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error=\(error)")
//                return
//            }
//            
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//            }
//            
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
//            
//            if(responseString?.contains("true"))!
//            { self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
//            let alertview:UIAlertView = UIAlertView(title: "Inserted successfully!", message: "", delegate: self, cancelButtonTitle: "OK")
//                alertview.show()
//            return
//            }
//            
//             else
//            {
//                self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
//                let alertview:UIAlertView = UIAlertView(title: "Server down at the moment... Please try later ", message: "", delegate: self, cancelButtonTitle: "OK")
//                alertview.show()
//                 return
//            }
//            
//            
//            
//            
//        }
//        task.resume()
    }
    

    
    
        
        
    @IBAction func back_click(_ sender: Any) {
       
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "FeedbackVC")
        self.present(vc2, animated: true, completion: nil)
        
    }
    
}

    
   
