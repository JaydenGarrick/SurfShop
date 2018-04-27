//
//  ClothingBagTableViewCell.swift
//  SurfShop
//
//  Created by James Pacheco on 1/31/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import UIKit

class BagItemTableViewCell: UITableViewCell {
    
    static let kBagItemTableViewCellId = "BagItemTableViewCell"
    
    var productSelection: ProductSelection? {
        didSet {
            productImageView.image = productSelection?.product.image
            titleLabel.text = productSelection?.product.name ?? ""
            priceLabel.text = String(productSelection?.price ?? 0)
            descriptionLabel.text = productSelection?.description ?? ""
            quantityLabel.text = productSelection?.formattedQuantity ?? ""
        }
    }

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func prepareForReuse() {
        productSelection = nil
    }

}
