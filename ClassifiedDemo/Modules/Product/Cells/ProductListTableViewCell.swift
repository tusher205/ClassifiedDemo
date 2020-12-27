//
//  ProductListTableViewCell..swift
//  Classified Demo
//
//  Created by Takvir Hossain Tusher on 20/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var itemThumbnailImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
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
        return UINib(nibName: String(describing: ProductListTableViewCell.classForCoder()),
                     bundle: .main)
    }

    @objc
    class func reuseIdentifier() -> String {
        return String(describing: ProductListTableViewCell.classForCoder())
    }
}
