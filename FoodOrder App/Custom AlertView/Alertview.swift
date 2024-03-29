//
//  Alertview.swift
//  CustomAlertView
//
//  Created by Milan Varasada on 04/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import Foundation
import UIKit

protocol clickOnButton {
   func clickContinueShoppingButton()
}

class Alertview : UIView
{
    static let instance = Alertview()
    
    @IBOutlet var subView: UIView!
    @IBOutlet var parentView: UIView!
    @IBOutlet var alertView: UIView!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var titleofAlert: UILabel!
    @IBOutlet var messageOfAlert: UILabel!
    
    var delegate:clickOnButton?
    let Pinkcolor = UIColor(red: 221/255, green: 55/255, blue: 91/255, alpha: 1.0)

    override init(frame: CGRect) {
        super.init(frame:frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commanInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
      
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commanInitialization()
    {
        subView.layer.cornerRadius = 20
        doneButton.layer.cornerRadius = 10
     
   
        
        iconImage.layer.cornerRadius = iconImage.frame.width / 2
        iconImage.layer.borderWidth = 2
        iconImage.layer.borderColor = UIColor.white.cgColor
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        parentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    enum AlertType
    {
        case Sucess
        case Failure
        case Warning
    }
    
    func showAlert(title:String,message:String,alertType:AlertType)
    {
        titleofAlert.text = title
        messageOfAlert.text = message
        switch alertType {
        case .Sucess:
            
            iconImage.image = UIImage(named: "alertCheckmark")
             doneButton.backgroundColor = Pinkcolor
            doneButton.setTitle("Continue Shopping", for: .normal)
        case .Failure:
            doneButton.setTitle("Ok", for: .normal)
            iconImage.image = UIImage(named: "fail")
            doneButton.backgroundColor = Pinkcolor
        case .Warning:
            titleofAlert.textColor = UIColor.orange
            doneButton.backgroundColor = UIColor.orange
            iconImage.image = UIImage(named: "warning")
        }
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    
    @IBAction func buttonOfAction(_ sender: Any) {
       
        
            delegate?.clickContinueShoppingButton()
             Alertview.instance.parentView.removeFromSuperview()
    }
  
}

