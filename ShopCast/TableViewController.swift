//
//  TableViewController.swift
//  ShopCast
//
//  Created by guma on 2016. 2. 6..
//  Copyright © 2016년 Guma. All rights reserved.
//

import UIKit

class PostInfo{
    var userId:Int
    var userName:String
    var userProfile:String
    var thumbnail:String
    var contents:String
    
    init(ui:Int, un:String, up:String, tn:String, ct:String){
        userId = ui
        userName = un
        userProfile = up
        thumbnail = tn
        contents = ct
    }
}

extension UIImageView {
    func downloadedFrom(link link:String, contentMode mode: UIViewContentMode) {
        guard
            let url = NSURL(string: link)
            else {return}
        contentMode = mode
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.image = image
            }
        }).resume()
    }
}

class TableViewController: UITableViewController{
    
    var testGoods = [101]
    
    func getImageUrl(goodNo:String)->String{
        var result:String="http://gdimg1.gmarket.co.kr/goods_image2/shop_img/"
        
        result += (goodNo as NSString).substringToIndex(3)+"/"
        result += (goodNo as NSString).substringWithRange(NSRange(location: 3, length: 3))+"/"
        result += goodNo+".jpg"
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.estimatedRowHeight = 74
        tableView.rowHeight = UITableViewAutomaticDimension

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "didRefreshList", forControlEvents: .ValueChanged)
        //var request:NSMutableURLRequest
        
        //var request:NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "http://127.0.0.1:8081")!)
        getPosts()
    }
    
    func getPosts(){
        let manager:RestApiManager = RestApiManager()
        manager.makeHTTPGetRequest("http://gumabae.iptime.org/posts", onCompletion:{ json, err in
            //NSLog(json["value"]![0] as! Int)
            self.testGoods = json["value"] as! [Int]
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        })
    }
    
    func getPostInfo(postId:Int, cell:TableViewCell, onCompletion:(postInfo:PostInfo, updateCell:TableViewCell)->Void){
        let manager:RestApiManager = RestApiManager()
        manager.makeHTTPGetRequest("http://gumabae.iptime.org/postinfo?id=\(postId)", onCompletion: {json, error in
            let userName = json["userName"] as! String
            let userId = json["userId"] as! Int
            let userProfile = json["userProfile"] as! String
            let thumbnail = json["thumbnail"] as! String
            let contents = json["contents"] as! String
            let postInfo = PostInfo(ui: userId, un: userName, up: userProfile, tn: thumbnail, ct: contents)
            onCompletion(postInfo: postInfo, updateCell: cell)
        })
    }
    
    func didRefreshList(){
        getPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return testGoods.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        let row = indexPath.row
        
        let postId = testGoods[row]
        //if(cell)
        getPostInfo(postId, cell: cell, onCompletion: {postInfo, updateCell2 in
            let updateCell = self.tableView.cellForRowAtIndexPath(indexPath) as? TableViewCell
            if(updateCell != nil){
                updateCell!.label1.text = (postInfo.userId as NSNumber).stringValue
                updateCell!.label2.text = postInfo.contents
                updateCell!.titleImage.downloadedFrom(link: postInfo.userProfile, contentMode: .ScaleAspectFill)
                updateCell!.titleLabel.text = postInfo.userName
                updateCell!.imageView1.downloadedFrom(link: postInfo.thumbnail, contentMode: .ScaleAspectFill)
                updateCell!.imageView1.heightAnchor
            }
        })
        
//        cell.label1?.text = (row as NSNumber).stringValue
//        var text = ""
//        for _ in 0...indexPath.row{
//            text += "동해물과 백두산이 마르고닳도록 하느님이 보우하사 우리나라만세 무궁화삼천리 화려강산 대한사람 대한으로 길이 보전하세"
//        }
//
//        cell.label2?.text = text
//        cell.titleImage?.image = UIImage(named: "user1")
        cell.titleImage?.layer.cornerRadius = 20
        cell.titleImage?.clipsToBounds = true
//        cell.label1.text = ""
//        cell.label2.text = ""
//        cell.titleLabel.text = ""
//
//        cell.titleLabel?.text = "user_"+(row as NSNumber).stringValue
//        
//        cell.imageView1.downloadedFrom(link: getImageUrl(testGoods[indexPath.row]), contentMode: UIViewContentMode.ScaleAspectFill)
//        
//        cell.imageView1?.heightAnchor
        
        //cell.
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showProfile" {
            let indexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let vc = segue.destinationViewController as! CollectionViewController
            vc.userName = "user_"+(indexPath.row as NSNumber).stringValue
        }
        else if segue.identifier == "showSlider" {
            //_ = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let vc = segue.destinationViewController as! PageViewController
            vc.pageTitles = NSArray(objects: "hi", "hello")
            vc.imageFiles = NSArray(objects: getImageUrl("716503407"),getImageUrl("695331907"))
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
