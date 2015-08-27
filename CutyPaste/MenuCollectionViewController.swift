//
//  MenuCollectionViewController.swift
//  CutyPaste
//
//  Created by Catalina Balmaceda on 21-08-15.
//  Copyright (c) 2015 Catalina Balmaceda. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension String {
    var html2String:String {
        return NSAttributedString(data: dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil, error: nil)!.string
    }
}


let reuseIdentifier = "MainImage"

class MenuCollectionViewController: UICollectionViewController, SideBarDelegate, UIScrollViewDelegate {
    
    let postsController = PostInfoController()
    @IBOutlet var imageView: UIImageView!
    var sideBar:SideBar = SideBar()

    
    // reload data cuando llegue al 80% del scroll
    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        println("scroll view \(scrollView.contentOffset.y)")
        
//        if scrollView.contentOffset.y < -4000 {
//            reloadInputViews()
//        }
        
//        if (scrollView.contentOffset.y < -50) _metNegativePullDown = YES;
//        
//        if (fabs(scrollView.contentOffset.y) < 1 && _metNegativePullDown) {
//            //do your refresh here
//            _metNegativePullDown = NO;
//        }

    }

    
    @IBAction func openMenuButton(sender: AnyObject) {
        sideBar.showSideBar(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        
    // logo cutypaste in navigation controller
    var navBar:UINavigationBar? = self.navigationController!.navigationBar
    navBar?.backgroundColor =  UIColor.blackColor()
    let logo = UIImage(named: "logo-nuevo-01negro")
    let a = UIImageView(image: logo)
    a.contentMode = UIViewContentMode.ScaleAspectFit
    a.frame = CGRect(x: 0, y: 0, width: 40 , height: 30)
    self.navigationItem.titleView = a
    
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.setItemsPerRowInLayout(1)
        
        //add categories API
        sideBar = SideBar(sourceView: self.view)
        sideBar.delegate = self
        let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
    
        flowLayout.itemSize.height = self.view.bounds.height/2
        flowLayout.itemSize.width = self.view.bounds.width
        
        //**** Llama a la funcion que lee los posts y los agrega a la postsController
        read()

        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainImage")
        // Do any additional setup after loading the view.
    }

    
    func sideBarDidSelectButtonAtIndex(index: Int){
        
        imageView.backgroundColor = UIColor.clearColor()
        
    }
    
    
    func read() {
        
        Alamofire.request(.GET,"http://www.cutypaste.com/api/get_posts")
            .validate()
            .responseJSON { (_, _, json, _) -> Void in
                
                
                let data = JSON(json!)
                let infoPostsJson = data["posts"] as JSON
                self.postsController.addPosts(infoPostsJson)
             
            // Metodo verifica que haya informacion en el thread
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    println(self.postsController.listaPosts.count)
                    println(self.postsController.listaPosts[1].title)
                //  println(self.postsController.listaPosts[0].categories.listaCategories[0].title)
                    println(self.postsController.listaPosts[0].categories.listaCategories[0].title)
                    println("Post Title: \(self.postsController.listaPosts[0].title)")
                    for cat in self.postsController.listaPosts[0].categories.listaCategories{
                        println("Category Title \(cat.title)")
                    }
                    self.collectionView?.reloadData()
                })
        }
    }
    
    func setItemsPerRowInLayout(itemsPerRow: CGFloat){
        let flowlayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        if (self.collectionView != nil){
            var newItemSize:CGSize = flowlayout.itemSize;
            
            // Calculate the sum of the spacing between cells
            let totalSpacing:CGFloat = flowlayout.minimumInteritemSpacing * (itemsPerRow - 1.0);
            
            // Calculate how wide items should be
            newItemSize.width = (self.collectionView!.bounds.size.width - totalSpacing) / itemsPerRow;
            
            // Use the aspect ratio of the current item size to determine how tall the items should be
            if (flowlayout.itemSize.height > 0){
                let itemAspectRatio: CGFloat = flowlayout.itemSize.width / flowlayout.itemSize.height;
                newItemSize.height = newItemSize.width / itemAspectRatio;
            }
            
            // Set the new item size
            flowlayout.itemSize = newItemSize;
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        
        if (self.postsController.listaPosts.count>0)
        {
            return self.postsController.listaPosts.count
        }
        else
        {
            return 1
        }
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MenuCollectionViewCell
    
        // Print Article Title/Date in the Cell
        if (self.postsController.listaPosts.count>0)
        {
            
            //Prints the post title in the preview view.
            cell.MenuTitle.text = self.postsController.listaPosts[indexPath.row].title
            
            //Prints the author name in the preview view.
            cell.MenuBy.text =  self.postsController.listaPosts[indexPath.row].author.firstName + " " + self.postsController.listaPosts[indexPath.row].author.lastName
            
            //Do the difference in hours instead of the actual date of contribution
            cell.MenuDate.text = self.postsController.listaPosts[indexPath.row].date
            
            
            
        }
        else
        {
            cell.MenuTitle.text = "Loading..."
        }
        

        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
