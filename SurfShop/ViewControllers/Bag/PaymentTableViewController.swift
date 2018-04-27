//
//  PaymentTableViewController.swift
//  SurfShop3
//
//  Created by Ashley Carroll on 5/19/17.
//  Copyright © 2017 Ashley Carroll. All rights reserved.
//

import UIKit

class PaymentTableViewController: UITableViewController {
    
    fileprivate let orderConfirmationSegueId = "orderConfirmation"

    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var bag: Bag!
    private var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard bag != nil else {
            fatalError("\(type(of: self)) ended up without a bag item.")
        }
    
        updateViews()
    }

    private func updateViews() {
        subtotalLabel.text = String(bag.subtotal)
        taxLabel.text = String(bag.estimatedTax)
        totalLabel.text = String(bag.total)
    }

    @IBAction func orderConfirmationButtonTapped(_ sender: Any) {
        let loadingVC = LoadingViewController.create("Checking Out")
        present(loadingVC, animated: true, completion: nil)
        
        CheckoutController.shared.checkout(with: bag) { (order) in
            self.dismiss(animated: true) {
                if let order = order {
                    NotificationCenter.default.post(Notifications.checkoutCompleted)
                    self.order = order
                    self.performSegue(withIdentifier: self.orderConfirmationSegueId, sender: sender)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == orderConfirmationSegueId,
            let destination = segue.destination as? OrderDetailsTableViewController {
            
            destination.order = order
            destination.addDoneBarButtonItem()
            destination.navigationItem.hidesBackButton = true
        }
    }
    

}
