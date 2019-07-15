//
//  RestaurantsController.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 10/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SVProgressHUD

class RestaurantsController: UIViewController {
    
    let storage = Storage.storage()
    let db = Firestore.firestore()

    //outlets
    @IBOutlet var collectionview: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var RestDisplayCollectionView: UICollectionView!
    
    //timer for auto change image
    var timer = Timer()
    var counter = 0
    
    //Model array
    var RestDetails:[Restaurant] = []
    
    //static array for image
    var imgArray = [UIImage(named: "firstSlideImage"),UIImage(named: "secondSlideImage"),UIImage(named: "thirdSlideImage")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Initialization()
    }
}

extension RestaurantsController:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionview
        {
            return imgArray.count
        }
        if collectionView == RestDisplayCollectionView
        {
            return RestDetails.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionview
        {
          if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RestarantsCell
          {
            cell.imageOfRest.image = imgArray[indexPath.row]
            return cell
          }
            else
          {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
            }
        }
        if collectionView == RestDisplayCollectionView
        {
            
           if let cell = RestDisplayCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RestarantDisplayCell
           {
            let index = RestDetails[indexPath.row]
            cell.ratingLabel.text = index.RestRating
            cell.restarantImage.image = index.RestImage
            cell.RestAddLabel.text = index.RestAddress
            cell.RestNameLabel.text = index.RestName
            
            cell.FreeDeliveryLabel.layer.cornerRadius = 8
            cell.FreeDeliveryLabel.layer.masksToBounds = true
            
            cell.contentView.layer.cornerRadius = 15
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            return cell
            }
            else
           {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
            }
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    
    
}

extension RestaurantsController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionview
        {
            return CGSize(width: self.view.frame.width, height: self.view.frame.height / 1.96)
        }
        if collectionView == RestDisplayCollectionView
        {
             return CGSize(width: 350, height: 130)
        }
        else
        {
             return CGSize(width: self.view.frame.width, height: self.view.frame.height / 1.96)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == collectionview
        {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        if collectionView == RestDisplayCollectionView
        {
            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        }
        else
        {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == collectionview
        {
            return 0
        }
        if collectionView == RestDisplayCollectionView
        {
            return 0
        }
        else
        {
            return 0
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == collectionview
        {
            return 0
        }
        if collectionView == RestDisplayCollectionView
        {
            return 15
        }
        else
        {
            return 0
        }
    }
    
}

extension RestaurantsController
{
    fileprivate func Initialization() {
        //pagecontrol
        pageControl.numberOfPages = imgArray.count
        pageControl.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        RestDisplayCollectionView.delegate = self
        RestDisplayCollectionView.dataSource = self
        
        let nib = UINib(nibName: "RestarantDisplayCell", bundle: nil)
        RestDisplayCollectionView?.register(nib, forCellWithReuseIdentifier: "cell")
        
        readData()
    }
    
    @objc func changeImage()
    {
        if counter < imgArray.count
        {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter = counter + 1
        }
        else
        {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
        }
    }
}

extension RestaurantsController
{
    //Mark :- read data from database
    func readData() {
        RestDetails = []
        db.collection("RestaurantDetails").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let new = Restaurant()
                    new.RestName = "\(document.data()["RestName"] as! String)"
                    new.RestAddress = "\(document.data()["RestAddress"] as! String)"
                    new.RestRating = "\(document.data()["RestRating"] as! String)"
                    new.RestImageName = "\(document.documentID)"
                    new.DeliveryType = "\(document.data()["RestDeliveryType"] as! String)"
                    new.UID = Int("\(document.data()["RestUID"] as! String)")!
                    let storageRef = Storage.storage().reference(withPath: "Images/\(document.documentID).png")
                    storageRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("error downloading image:\(error)")
                        } else {
                            
                            // Data for "images/island.jpg" is returned
                            new.RestImage = UIImage(data: data!)
                            
                            self.RestDetails.append(new)
                            
                            self.RestDisplayCollectionView.reloadData()
                            
                        }
                    }
                }
            }
        }
        
    }
}
