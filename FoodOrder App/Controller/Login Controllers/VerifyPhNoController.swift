//
//  VerifyPhNoController.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 08/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import Firebase
import FirebaseAuth

class VerifyPhNoController: UIViewController {

    
    @IBOutlet var PhoneNumberTextField: FPNTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        PhoneNumberTextField.layer.masksToBounds = true
        PhoneNumberTextField.layer.cornerRadius = 20
         PhoneNumberTextField.layer.borderWidth = 2
        PhoneNumberTextField.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func socialButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocialSigninController") as! SocialSigninController
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func nextButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PhNoVerificationController") as! PhNoVerificationController
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
  
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
