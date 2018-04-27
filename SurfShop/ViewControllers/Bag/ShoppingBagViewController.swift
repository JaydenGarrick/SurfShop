//
//  ShoppingBagContainerViewController.swift
//  SurfShop3
//
//  Created by Ashley Carroll on 9/18/17.
//  Copyright © 2017 Ashley Carroll. All rights reserved.
//

import UIKit

class ShoppingBagViewController: UIViewController {
    
    fileprivate let checkoutSegueId = "checkoutSegue"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    private var footerView: UIView?
    
    private var bag: Bag?
    
    private var productSelections: [ProductSelection] = [] {
        didSet {
            tableView.tableFooterView?.isHidden = productSelections.count <= 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView?.isHidden = productSelections.count <= 0
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleCheckoutCompleted(notification:)), name: Notifications.checkoutCompleted.name, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CheckoutController.shared.getCurrentBag { (bag) in
            self.bag = bag
            self.updateViews()
        }
    }

    private func updateViews() {
        if let bag = bag {
            updateViews(for: bag)
            productSelections = bag.items
        } else {
            updateViewsForEmptyBag()
            productSelections = []
        }
        tableView.reloadData()
    }
    
    private func updateViews(for bag: Bag) {
        subtotalLabel.text = String(bag.subtotal)
        taxLabel.text = String(bag.estimatedTax)
        totalLabel.text = String(bag.total)
    }
    
    private func updateViewsForEmptyBag() {
        subtotalLabel.text = "$0.00"
        taxLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    
    @objc private func handleCheckoutCompleted(notification: Notification) {
        CheckoutController.shared.getCurrentBag { (bag) in
            self.bag = bag
            self.updateViews()
        }
    }
    
}

extension ShoppingBagViewController {
    
    @IBAction func emptyBagButtonTapped(_ sender: Any) {
        guard let bag = bag else {return}
        CheckoutController.shared.empty(bag: bag) { (bag) in
            self.bag = bag
            self.updateViews()
        }
    }

    @IBAction func checkoutButtonTapped(_ sender: Any) {
        if let bag = bag,
            bag.items.count > 0 {
            
            performSegue(withIdentifier: checkoutSegueId, sender: sender)
        } else {
            let alert = UIAlertController(title: "Nothing to checkout...", message: "You need to add some items to your bag before you can check out.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindFromCheckout(_ segue: UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
            let destination = navController.viewControllers.first as? PaymentTableViewController {
            destination.bag = bag
        }
    }

}

extension ShoppingBagViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(productSelections.count, 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if productSelections.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "EmptyBagCell", for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BagItemTableViewCell.kBagItemTableViewCellId, for: indexPath) as! BagItemTableViewCell
        
        let productSelection = productSelections[indexPath.row]
        cell.productSelection = productSelection
        
        return cell
    }
}

extension ShoppingBagViewController: UITableViewDelegate {

}
