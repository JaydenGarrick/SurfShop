//
//  OrderDetailsTableViewCell.swift
//  SurfShop
//
//  Created by James Pacheco on 2/7/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    static let kOrderDetailsTableViewCellId = "OrderDetailsTableViewCell"
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var order: Order? {
        didSet {
            configureView()
        }
    }
    
    private func configureView() {
        guard let order = order else {
            statusImageView.image = nil
            statusLabel.text = ""
            dateLabel.text = ""
            return
        }
        
        switch order.orderState {
        case .confirmed:
            statusLabel.text = "Confirmed"
            statusImageView.image = #imageLiteral(resourceName: "confirmed")
            
        case .processing:
            statusLabel.text = "Processing"
            statusImageView.image = #imageLiteral(resourceName: "processing")
            
        case .shipped:
            statusLabel.text = "Shipped"
            statusImageView.image = #imageLiteral(resourceName: "shipped")
            
        case .delivered:
            statusLabel.text = "Delivered"
            statusImageView.image = #imageLiteral(resourceName: "shipped")
        }
        
        dateLabel.text = "Order date: \(order.orderDate)"
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
