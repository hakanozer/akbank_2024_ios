//
//  ProductCell.swift
//  Product
//
//  Created by HAKAN ÖZER on 28.02.2024.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var r_img: UIImageView!
    @IBOutlet weak var r_title: UILabel!
    @IBOutlet weak var r_price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
