//
//  SocialSigninController.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 08/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SocialSigninController: UIViewController {
    
//Mark :- outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
  //Mark :- login User
    
    @IBAction func loginUser(_ sender: Any) {
        
        if emailText.text == "" && passwordText.text == "" {
            let alert = UIAlertController(title: "Sign Up", message: "Please Enter Email and Password.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (passwordText.text?.count)! < 6 {
            let alert = UIAlertController(title: "Sign Up", message: "Password Sholud be Equal or Greater than 6 characters..", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if (!(emailText.text?.contains("@"))! || !(emailText.text?.contains(".com"))!)
        {
            let alert = UIAlertController(title: "Sign Up", message: "Please enter the Valid Email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else
        {
        let email = emailText.text!
        let password = passwordText.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error as Any)
            } else {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! ViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        }
    }
    
    @IBAction func loginWithPhoneNumber(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VerifyPhNoController") as! VerifyPhNoController
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    //Mark :- back button
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension SocialSigninController
{
    fileprivate func initialization() {
        emailText.layer.cornerRadius = 24
        emailText.layer.masksToBounds = true
        
        passwordText.layer.cornerRadius = 24
        passwordText.layer.masksToBounds = true
        
        loginButton.layer.cornerRadius = 24
    }
    
}
