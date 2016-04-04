//
//  CollectionViewController.swift
//  ShopCast
//
//  Created by guma on 2016. 2. 7..
//  Copyright © 2016년 Guma. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var userName:String = ""
    var refreshControl:UIRefreshControl = UIRefreshControl()
    
    var testGoods = ["734532882", "582355970", "639113464", "631165011", "768841236", "650163671", "769735943", "637204457", "716503407", "533484928"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        let cellWidth = calcCellWidth(self.view.frame.size)
        layout.itemSize = CGSizeMake(cellWidth, cellWidth)
        // Do any additional setup after loading the view.
        
        //self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "didRefresh", forControlEvents: .ValueChanged)
        self.collectionView?.addSubview(self.refreshControl)
        
        if self.userName.isEmpty{
            userName = "my_page"
        }
        self.title = userName.uppercaseString
    }
    
    func didRefresh(){
        sleep(1)
        var newGoods = [String]()
        for index in 1 ... self.testGoods.count {
            newGoods.append(self.testGoods[testGoods.count-index])
            //newGoods[index] = self.testGoods[0]
        }
        self.testGoods = newGoods
        self.collectionView?.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        let cellWidth = calcCellWidth(size)
        layout.itemSize = CGSizeMake(cellWidth, cellWidth)
    }
    
    func calcCellWidth(size: CGSize) -> CGFloat {
        let transitionToWide = size.width > size.height
        var cellWidth = (size.width-2) / 3
        
        if transitionToWide {
            cellWidth = (size.width-2) / 3
        }
        
        return cellWidth
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return testGoods.count
    }
    
    
    func getImageUrl(goodNo:String)->String{
        var result:String="http://gdimg1.gmarket.co.kr/goods_image2/shop_img/"
        
        result += (goodNo as NSString).substringToIndex(3)+"/"
        result += (goodNo as NSString).substringWithRange(NSRange(location: 3, length: 3))+"/"
        result += goodNo+".jpg"
        return result
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! CollectionViewCell
        /*
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor(colorLiteralRed: 100, green: 0, blue: 0, alpha: 100)
        } else if indexPath.row % 2 == 1{
            cell.backgroundColor = UIColor(colorLiteralRed: 0, green: 100, blue: 0, alpha: 100)
        } else {
            cell.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 100, alpha: 100)
        }*/
        cell.imageView?.downloadedFrom(link: getImageUrl(testGoods[indexPath.row]), contentMode:UIViewContentMode.ScaleAspectFill)
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSlider" {
            let index = (self.collectionView!.indexPathsForSelectedItems()![0] as NSIndexPath).row
            //_ = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let vc = segue.destinationViewController as! PageViewController
            vc.pageTitles = NSArray(objects: "hi", "hello")
            vc.imageFiles = NSArray(objects: getImageUrl(testGoods[index]), getImageUrl(testGoods[index == 0 ? index+1 :index-1]))
        }
    }

}
