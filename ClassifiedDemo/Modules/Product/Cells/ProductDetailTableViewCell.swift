//
//  ProductDetailTableViewCell.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Class Methods
    @objc
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: ProductDetailTableViewCell.classForCoder()),
                     bundle: .main)
    }

    @objc
    class func reuseIdentifier() -> String {
        return String(describing: ProductDetailTableViewCell.classForCoder())
    }
}
