//
//  PhNoVerificationController.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 08/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import ABOtpView
import Firebase
import FirebaseAuth

class PhNoVerificationController: UIViewController,ABOtpViewDelegate {
    
    var phoneString = ""
    func didEnterOTP(otp: String) {
      
        print(otp)
        print(phoneString)
        let sp = "\(phoneString)"
        let sp2 = sp.replacingOccurrences(of: " ", with: "")
        
        
        Auth.auth().settings!.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(sp2, uiDelegate:nil) {
            verificationID, error in
            if (error != nil) {
                // Handles error
                print("error varifying PhoneNumber: \(String(describing: error))")
                
                return
            }
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "",
                                                                     verificationCode: "\(otp)")
            Auth.auth().signInAndRetrieveData(with: credential) { authData, error in
                if ((error) != nil) {
                    // Handles error
                    print("error in otp : \(String(describing: error?.localizedDescription))")
                    return
                }
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(nextViewController, animated: false)
                
            }
        }
    }
    

    @IBOutlet var otpNumber: UIView!
    @IBOutlet var OtpView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let frm: CGRect = otpNumber.frame
       otpNumber = ABOtpView(frame: CGRect(x: frm.origin.x + 20, y: frm.origin.y + 20, width: frm.size.width, height: frm.size.height), numberOfDigits: 6,     borderType: .ROUND, borderColor: .gray,delegate:self)
        self.OtpView.addSubview(otpNumber)
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    
   

}
