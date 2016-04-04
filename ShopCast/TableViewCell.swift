//
//  TableViewCell.swift
//  ShopCast
//
//  Created by guma on 2016. 2. 6..
//  Copyright © 2016년 Guma. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var imageView1: UIImageView!
    
    var userName:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.titleImage.layer.cornerRadius = 20
        
        //self.titleNameButton.titleLabel?.text = self.userName
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
