//
//  OrderTotalsTableViewCell.swift
//  SurfShop
//
//  Created by James Pacheco on 2/7/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import UIKit

class OrderTotalsTableViewCell: UITableViewCell {

    static let kOrderTotalsTableViewCellId = "OrderTotalTableViewCell"
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var order: Order? {
        didSet {
            configureView()
        }
    }
    
    private func configureView() {
        subtotalLabel.text = String(order?.subtotal ?? 0)
        taxLabel.text = String(order?.tax ?? 0)
        totalLabel.text = String(order?.total ?? 0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        order = nil
    }

}
