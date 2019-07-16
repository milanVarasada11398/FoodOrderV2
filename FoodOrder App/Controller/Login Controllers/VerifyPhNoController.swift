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
        self.navigationController?.navigationBar.isHidden = true
        PhoneNumberTextField.layer.masksToBounds = true
        PhoneNumberTextField.layer.cornerRadius = 20
         PhoneNumberTextField.layer.borderWidth = 2
        PhoneNumberTextField.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func socialButton(_ sender: Any) {
       navigationController?.popViewController(animated: true)
    }
    @IBAction func nextButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PhNoVerificationController") as! PhNoVerificationController
        if PhoneNumberTextField.getRawPhoneNumber() != nil
        {
            nextViewController.phoneString = PhoneNumberTextField.getFormattedPhoneNumber(format: .E164)!
        }
        else
        {
            let alert = UIAlertController(title: "Sign Up", message: "Please enter the Valid Phone Number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
  
    @IBAction func backButton(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
}
