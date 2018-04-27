//
//  OrderItemsTableViewController.swift
//  SurfShop
//
//  Created by James Pacheco on 2/7/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import UIKit

class OrderDetailsTableViewController: UITableViewController {
    
    var order: Order! {
        didSet {
            productSelections = order.items
        }
    }
    
    private var productSelections: [ProductSelection] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch order.orderState {
        case .confirmed:
            self.title = "Order Confirmed"
        case .processing:
            self.title = "Order Processing"
        case .shipped:
            self.title = "Order Shipped"
        case .delivered:
            self.title = "Order Delivered"
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? productSelections.count : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return getOrderDetailsCell(tableView, indexPath: indexPath)
        case 1:
            return getItemCell(tableView, indexPath: indexPath)
        default:
            return getTotalsCell(tableView, indexPath: indexPath)
        }
    }
    
    private func getItemCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BagItemTableViewCell.kBagItemTableViewCellId, for: indexPath) as! BagItemTableViewCell
        
        let productSelection = productSelections[indexPath.row]
        cell.productSelection = productSelection
        
        return cell
    }
    
    private func getOrderDetailsCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailsTableViewCell.kOrderDetailsTableViewCellId, for: indexPath) as! OrderDetailsTableViewCell
        
        cell.order = order
        
        return cell
    }
    
    private func getTotalsCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTotalsTableViewCell.kOrderTotalsTableViewCellId, for: indexPath) as! OrderTotalsTableViewCell
        
        cell.order = order
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Status"
        case 1:
            return "Items"
        default:
            return "Totals"
        }
    }
    
    func addDoneBarButtonItem() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone(_:)))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc dynamic func didTapDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}
