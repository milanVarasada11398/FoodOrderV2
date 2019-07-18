//
//  HomeViewController.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 09/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SVProgressHUD
import BottomDrawer


 class HomeViewController: UIViewController {
    
    //firebase Variable
        let storage = Storage.storage()
        let db = Firestore.firestore()
    
    //outlets
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var collectionview: UICollectionView!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var seachCollectionView: UICollectionView!
    
    //Model array
    var RestDetails:[Restaurant] = []
    var CatDetails:[Category] = []
 
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollview.contentSize = CGSize(width:self.view.frame.width, height: self.view.frame.height + 100)
    }
    
    //Mark : - filter Data
    @IBAction func filterButton(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController

        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
    
    
}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionview
        {
        return RestDetails.count
        }
        if collectionView == categoryCollectionView{
            return CatDetails.count
        }
        else
        {
            return RestDetails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionView
        {
        let Id = RestDetails[indexPath.row].UID
        let restName = RestDetails[indexPath.row].RestName
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RestaurantDetailsController") as! RestaurantDetailsController
        nextViewController.RestUID = Id
        nextViewController.restaurantName = restName
        print(nextViewController.restaurantName)
        print(nextViewController.RestUID)
        navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == seachCollectionView
        {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PlaceCollectionViewCell
            {
                cell.deliveryLabel.layer.cornerRadius = 8
                cell.deliveryLabel.layer.masksToBounds = true
                cell.placeImage.layer.cornerRadius = 8
                cell.placeImage.layer.masksToBounds = true
                let index = RestDetails[indexPath.row]
                cell.placeImage.image = index.RestImage
                cell.placeNameLabel.text = index.RestName
                cell.AddressLabel.text = index.RestAddress
                cell.ratingLabel.text = index.RestRating
                return cell
            }
            else
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
            }
        }
        if collectionView == collectionview
        {
            
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PlaceCollectionViewCell
            {
                cell.deliveryLabel.layer.cornerRadius = 8
                cell.deliveryLabel.layer.masksToBounds = true
                cell.placeImage.layer.cornerRadius = 8
                cell.placeImage.layer.masksToBounds = true
                let index = RestDetails[indexPath.row]
                cell.placeImage.image = index.RestImage
                cell.placeNameLabel.text = index.RestName
                cell.AddressLabel.text = index.RestAddress
                cell.ratingLabel.text = index.RestRating
                return cell
        }
            else
       {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
        }
        }
         if collectionView == categoryCollectionView
        {
           if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCell
           {
              let index = CatDetails[indexPath.row]
            cell.CategoryImage.image = index.CatImage
            cell.imageview.center = cell.imageview.center
            cell.imageview.backgroundColor = UIColor.white
            cell.imageview.layer.shadowColor = UIColor.lightGray.cgColor
            cell.imageview.layer.shadowOpacity = 0.5
            cell.imageview.layer.shadowOffset = CGSize.zero
            cell.imageview.layer.shadowRadius = 5
            cell.CategoryImage.contentMode = .scaleAspectFit
            cell.CategoryNameLabel.text = index.CatName
            cell.CategoryPlacesLabel.text = index.CatPlaces
            
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

extension HomeViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionview
        {
            print("\(collectionview.frame.width/1.95)")
            print("\(collectionview.frame.height/1.10)")
            return CGSize(width: 213, height: 347)
        }
        if collectionView == categoryCollectionView
        {
             return CGSize(width: 100, height: 150)
        }
        else
        {
            return CGSize(width: 213, height: 347)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == collectionview
        {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        if collectionView == categoryCollectionView
        {
             return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        if collectionView == categoryCollectionView
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
            return 10
        }
        if collectionView == categoryCollectionView
        {
            return 10
        }
        else
        {
            return 10
        }
    }
   
}

extension HomeViewController
{
    fileprivate func initialization() {
        //deglegates and datasource
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        collectionview.delegate = self
        collectionview.dataSource = self
        
        seachCollectionView.delegate = self
        seachCollectionView.dataSource = self
        
        //searchbar
        searchBar.layer.borderWidth = 2
        searchBar.layer.cornerRadius = 24
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        
        let nib = UINib(nibName: "PlaceCollectionViewCell", bundle: nil)
        collectionview?.register(nib, forCellWithReuseIdentifier: "cell")
        
        let nib2 = UINib(nibName: "CategoryCell", bundle: nil)
        categoryCollectionView?.register(nib2, forCellWithReuseIdentifier: "cell")
        
        let nib3 = UINib(nibName: "PlaceCollectionViewCell", bundle: nil)
        seachCollectionView?.register(nib3, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(scrollview)
        
        collectionview.isHidden = false
        seachCollectionView.isHidden = true
        readData()
        readDataCategory()
    }
}

extension HomeViewController
{
    //Mark :- get data from firebase
    
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
                            
                            self.collectionview.reloadData()
                            
                        }
                    }
                }
            }
        }
        
    }
    
    //Mark :- category data
    
    func readDataCategory() {
        CatDetails = []
        db.collection("Categories").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let new = Category()
                    new.CatName = "\(document.data()["CatName"] as! String)"
                    new.CatPlaces = "\(document.data()["CatPlaces"] as! String)"
                    new.CatImageName = "\(document.documentID)"
                    let storageRef = Storage.storage().reference(withPath: "Images/\(document.documentID).png")
                    storageRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("error downloading image:\(error)")
                        } else {
                            
                            // Data for "images/island.jpg" is returned
                            new.CatImage = UIImage(data: data!)
                            
                            self.CatDetails.append(new)
                            
                            self.categoryCollectionView.reloadData()
                            
                        }
                    }
                }
            }
            
        }
        
    }
}

extension HomeViewController:UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        
       searchedData(for: searchBar.text!)
        seachCollectionView.reloadData()
        collectionview.reloadData()
        collectionview.isHidden = true
        seachCollectionView.isHidden = false
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            readData()
            collectionview.reloadData()
            seachCollectionView.isHidden = true
            self.collectionview.isHidden = false
            collectionview.isHidden = false
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    //MARK: - Fetching Data from Firebase for Search
    
    func searchedData(for text : String)
    {
        db.collection("RestaurantDetails").getDocuments { (querySnapshot, err) in
            self.RestDetails.removeAll()
            if let err = err{
                print("Error getting documents \(err)")
            }
            else{
                for document in querySnapshot!.documents{
                    let newItem = Restaurant()
                    newItem.RestName = "\(document.data()["RestName"] as! String)"
                    newItem.RestAddress = "\(document.data()["RestAddress"] as! String)"
                    newItem.RestRating = "\(document.data()["RestRating"] as! String)"
                    newItem.RestImageName = "\(document.documentID)"
                    newItem.DeliveryType = "\(document.data()["RestDeliveryType"] as! String)"
                    newItem.UID = Int("\(document.data()["RestUID"] as! String)")!
                    self.collectionview.reloadData()
                    let storageRef = Storage.storage().reference(withPath: "Images/\(document.documentID).png")
                    storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
                        if let error = error{
                            print("Error: \(error)")
                        }
                        if let data = data{
                            newItem.RestImage = UIImage(data: data)
                            self.seachCollectionView.reloadData()
                        }
                    }
                    if newItem.RestName.lowercased().contains(text.lowercased()) {
                        self.RestDetails.append(newItem)                    }
                }
//                self.productsLabel.text = "\(self.itemArray.count) products found for \(self.searchBar.text!)"
            }
        }
        seachCollectionView.reloadData()
        collectionview.reloadData()
    }
}
