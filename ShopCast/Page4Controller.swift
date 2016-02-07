//
//  Page4Controller.swift
//  ShopCast
//
//  Created by guma on 2016. 2. 5..
//  Copyright © 2016년 Guma. All rights reserved.
//

import UIKit

class Page4Controller: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    var labels = [UILabel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for(var i:Int=0;i<100;i++){
            let temp = UILabel()
            temp.text = (i as NSNumber).stringValue
            stackView.addSubview(temp)
        }

        //stackView.addSubview(<#T##view: UIView##UIView#>)
        // Do any additional setup after loading the view.
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
