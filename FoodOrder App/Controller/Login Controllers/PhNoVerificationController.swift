//
//  PhNoVerificationController.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 08/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import ABOtpView


class PhNoVerificationController: UIViewController,ABOtpViewDelegate {
    func didEnterOTP(otp: String) {
        print(otp)
    }
    

    @IBOutlet var otpNumber: UIView!
    @IBOutlet var OtpView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let frm: CGRect = otpNumber.frame
       otpNumber = ABOtpView(frame: CGRect(x: frm.origin.x + 20, y: frm.origin.y + 20, width: frm.size.width, height: frm.size.height), numberOfDigits: 4,     borderType: .ROUND, borderColor: .gray,delegate:self)
        self.OtpView.addSubview(otpNumber)
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    
   

}
