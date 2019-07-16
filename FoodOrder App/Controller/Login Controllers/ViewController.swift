//
//  ViewController.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 08/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    //outlets
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var loginUser: UIButton!
    @IBOutlet var forgotPassword: UIButton!
    @IBOutlet var signUpUser: UIButton!
    
    //timer for auto change image
    var timer = Timer()
    var counter = 0
    
    //static array for image
    var imgArray = [UIImage(named: "firstSlideImage"),UIImage(named: "secondSlideImage"),UIImage(named: "thirdSlideImage")]
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Initialization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(true, animated: animated)
        if(Auth.auth().currentUser?.uid != nil)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    //userLogin Button
    @IBAction func loginUser(_ sender: Any) {
        
        if emailText.text == "" && passwordText.text == "" {
            let alert = UIAlertController(title: "Sign In", message: "Please Enter Email or Password.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        let email = emailText.text!
        let password = passwordText.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if error != nil {
                print(error as Any)
                print(strongSelf)
                let alert = UIAlertController(title: "Sign In", message: "Please Enter Correct Email or Password.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self!.present(alert, animated: true, completion: nil)
                
            } else {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self!.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
    
    //forgot Password Button
    @IBAction func forgotPassword(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordController") as! ForgotPasswordController
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //signUp User
    @IBAction func signUpUser(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocialSigninController") as! SocialSigninController
      navigationController?.pushViewController(nextViewController, animated: true)
    }
}


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource
    {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WelcomeImageCell
       {
        cell.welcomePageImage.image = imgArray[indexPath.row]
        
        return cell
       }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: self.view.frame.height / 1.96)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension ViewController
{
    
    fileprivate func Initialization() {
        //page Control Stuff
        pageControl.numberOfPages = imgArray.count
        pageControl.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        //view Changes
        bottomView.layer.cornerRadius = 16
        emailText.layer.masksToBounds = true
        passwordText.layer.masksToBounds = true
        emailText.layer.cornerRadius = 24
        passwordText.layer.cornerRadius = 24
        emailText.layer.borderWidth = 2
        passwordText.layer.borderWidth = 2
        emailText.layer.borderColor = UIColor.clear.cgColor
        passwordText.layer.borderColor = UIColor.clear.cgColor
        loginUser.layer.borderWidth = 2
        loginUser.layer.borderColor = UIColor.clear.cgColor
        loginUser.layer.cornerRadius = 24
    }
    
    //auto change Image
    @objc func changeImage() {
        if counter < imgArray.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter = counter + 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
        }
    }
}
