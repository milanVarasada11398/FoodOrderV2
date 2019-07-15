//
//  CheckOutViewController.swift
//  FoodOrder App
//
//  Created by milan on 14/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth


class CheckOutViewController: UIViewController,UITextFieldDelegate,PayPalPaymentDelegate {
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastGreenColor = UIColor(red: 0, green: 204/255, blue: 0/255, alpha: 1.0)
    
    var orderPrice:String = ""

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var AddressField: SkyFloatingLabelTextField!
    
    var emailbool : Bool = false
    var addressbool : Bool = false
    
    
    var paypalconfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var acceptCreditCards: Bool = true {
        didSet {
            paypalconfig.acceptCreditCards = acceptCreditCards
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddressField.placeholder = "Home Address"
        AddressField.title = "Your Home Address"
        AddressField.tintColor = UIColor.red
        AddressField.textColor = darkGreyColor
        AddressField.lineColor = lightGreyColor
        AddressField.selectedTitleColor = overcastGreenColor
        AddressField.selectedLineColor = UIColor.red
        AddressField.lineHeight = 1.0 // bottom line height in points
        AddressField.selectedLineHeight = 2.0
         AddressField.errorColor = UIColor.red
         addressView.layer.borderWidth = 2
         addressView.layer.borderColor = UIColor.red.cgColor
         AddressField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        emailField.placeholder = "Email"
        emailField.title = "Your Email Address"
        emailField.tintColor = UIColor.red
        emailField.textColor = darkGreyColor
        emailField.lineColor = lightGreyColor
        emailField.selectedTitleColor = overcastGreenColor
        emailField.selectedLineColor = UIColor.red
        emailField.lineHeight = 1.0 // bottom line height in points
        emailField.selectedLineHeight = 2.0
        emailField.errorColor = UIColor.red
        emailView.layer.borderWidth = 2
        emailView.layer.borderColor = UIColor.red.cgColor
        emailField.addTarget(self, action: #selector(textFieldDidChangeforEmail(_:)), for: .editingChanged)
        
        
        emailView.layer.cornerRadius = 10
        emailView.layer.masksToBounds = true
        
        addressView.layer.cornerRadius = 10
        addressView.layer.masksToBounds = true
        
        paymentButton.layer.cornerRadius = 8
        paymentButton.layer.masksToBounds = true
        
        
        
        //paypal
        paypalconfig.acceptCreditCards = acceptCreditCards;
        paypalconfig.merchantName = "Milan Patel Inc."
        paypalconfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.mmpatel.com/privacy.html") as URL?
        paypalconfig.merchantUserAgreementURL = NSURL(string: "https://www.mmpatel.com/useragreement.html") as URL?
        paypalconfig.languageOrLocale = NSLocale.preferredLanguages[0]
        paypalconfig.payPalShippingAddressOption = .payPal;
        
        PayPalMobile.preconnect(withEnvironment: environment)
       
    }
    
    @objc func textFieldDidChangeforEmail(_ textfield: UITextField)
    {
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                if(text.count < 3 || !text.contains("@") || !text.contains(".com")) {
                    floatingLabelTextField.errorMessage = "Invalid email"
                    emailView.layer.borderColor = UIColor.red.cgColor
                    emailImageView.image = UIImage()
                    emailbool = false
                }
                else {
                    // The error message will only disappear when we reset it to nil or empty string
                    floatingLabelTextField.errorMessage = ""
                    emailField.tintColor = overcastGreenColor
                    emailField.selectedLineColor = overcastGreenColor
                    
                    emailView.layer.borderColor = overcastGreenColor.cgColor
                    emailImageView.image = UIImage(named: "checkmark")
                    emailbool = true
                }
            }
        }
    }
    
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
               if text.count > 0 {
                 AddressField.tintColor = overcastGreenColor
                 AddressField.selectedLineColor = overcastGreenColor
               
                addressView.layer.borderColor = overcastGreenColor.cgColor
                imageview.image = UIImage(named: "checkmark")
                
                addressbool = true
                }
                else {
                    // The error message will only disappear when we reset it to nil or empty string
                    floatingLabelTextField.errorMessage = ""
                AddressField.tintColor = UIColor.red
                AddressField.selectedLineColor = UIColor.red
                addressView.layer.borderColor = UIColor.red.cgColor
                imageview.image = UIImage()
                
                addressbool = false
                }
            }
        }
    }
    
    //paypalDelegate
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        
        print("PayPal Payment Success !")
           Alertview.instance.showAlert(title: "Your Order is Sucessfully.", message: "You can track the Delivery in the \"Orders\" Sction.", alertType: .Sucess)
//        paymentViewController.dismiss(animated: true, completion: { () -> Void in
//            // send completed confirmaion to your server
//            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
//
//
//        })
    }
    
    
    @IBAction func payWithPaypal(_ sender: Any) {
       
        
        if emailbool == false || addressbool == false
        {
            let alert = UIAlertController(title: "Payment Error", message: "Please enter Correct email and Home Address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
         
        }
        else
        {
           
            guard let user = Auth.auth().currentUser?.email else {
                return
            }
        
        let item1 = PayPalItem(name: "Milan Varasada Test Item", withQuantity: 1, withPrice: NSDecimalNumber(string: "\(orderPrice)"), withCurrency: "USD", withSku: "MIlan-0001")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "\(user)", intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: paypalconfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            
            print("Payment not processalbe: \(payment)")
        }
    }
    }
    
    @IBAction func backToOrder(_ sender: Any) {
        navigationController?.popViewController(animated: true)
       
    }
    

    
}
