//
//  ForgotPasswordController.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 15/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordController: UIViewController {

    @IBOutlet var sendButton: UIButton!
    @IBOutlet var emailText: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    

   
    @IBAction func sendButton(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailText.text!) { error in
            DispatchQueue.main.async {
                if self.emailText.text?.isEmpty==true || error != nil {
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }
                if error == nil && self.emailText.text?.isEmpty==false{
                    let resetEmailAlertSent = UIAlertController(title: "Reset Email Sent", message: "Reset email has been sent to your login email, please follow the instructions in the mail to reset your password", preferredStyle: .alert)
                    resetEmailAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailAlertSent, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ForgotPasswordController
{
    fileprivate func initialization() {
        emailText.layer.cornerRadius = 24
        emailText.layer.masksToBounds = true
        
        sendButton.layer.cornerRadius = 24
        sendButton.layer.masksToBounds = true
    }
    
}
