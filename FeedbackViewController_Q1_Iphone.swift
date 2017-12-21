//
//  FeedbackViewController_Q1_Iphone.swift
//  FFT Form
//
//  Created by Welltime on 18/09/2017.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class FeedbackViewController_Q1_Iphone: UIViewController,UITableViewDataSource,
UITableViewDelegate {

    
    var myData = NSMutableArray()
    var myImages = NSMutableArray()
    var selectedItem = ""
    
    
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          self.lbl1.font = UIFont.boldSystemFont(ofSize: self.lbl1.font.pointSize)
        
         self.lbl2.font = UIFont.boldSystemFont(ofSize: self.lbl2.font.pointSize)
        
        myData =   ["Extremely likely","Likely","Neither likely nor unlikely","Unlikely","Extremely unlikely","Dont Know"]
        
        
        
        myImages = ["icon_extremely_likely.png","icon_likely.png","icon_neither.png","icon_unhappy.png","icon_extremely_unlikely.png","icon_dont_know.png"]
        


        // Do any additional setup after loading the view.
    }

    
    @IBAction func logout_click(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Main_iphone", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "LoginIphoneVC")
        self.present(vc2, animated: true, completion: nil)
        
        
        
        
    }
    
    
    ///// ******************* TableView Delegate Methods ****************** //////////
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self.myData.count;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        var cell: FeedbackTableViewCell_Iphone? = tableView.cellForRow(at: indexPath) as! FeedbackTableViewCell_Iphone
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
        
               
        var cell2: FeedbackTableViewCell_Iphone
        
        cell2 = tableView.dequeueReusableCell(withIdentifier: "FeedbackIphoneCell", for: indexPath) as! FeedbackTableViewCell_Iphone
        
        cell2.lbl_name.text = myData[indexPath.row] as! String
        cell2.img_icon.image = UIImage(named:myImages[indexPath.row] as! String )
        
        
        if (self.selectedItem == myData[indexPath.row] as! String) {
            cell2.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        else {
            cell2.accessoryType = UITableViewCellAccessoryType.none
        }
        
        
        return cell2
    }
    
    //////////////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func next_click(_ sender: Any) {
        
        if (selectedItem == "")  {
            let alertview:UIAlertView = UIAlertView(title: nil, message: "Please provide your reviews", delegate: self, cancelButtonTitle: "OK")
            alertview.show()
            return
            
            // either textfield 1 or 2's text is empty
        }

        
        let storyboard = UIStoryboard(name: "Main_iphone", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FeedbackIphoneQ2VC") as! FeedbackViewController_Q2_Iphone
        
        vc.satisfactionDescription = selectedItem
       
        self.present(vc, animated: true, completion: nil)
        
        
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
