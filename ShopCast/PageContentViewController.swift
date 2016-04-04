//
//  PageContentViewController.swift
//  ShopCast
//
//  Created by guma on 2016. 2. 11..
//  Copyright © 2016년 Guma. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var pageIndex:Int!
    var titleText:String!
    var imageFile:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.titleText
        self.imageView.downloadedFrom(link: self.imageFile, contentMode: .ScaleAspectFit)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
