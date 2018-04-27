//
//  ProductDetailViewControllerTableViewController.swift
//  SurfShop3
//
//  Created by Ashley Carroll on 5/18/17.
//  Copyright © 2017 Ashley Carroll. All rights reserved.
//

import UIKit

class ProductDetailViewController: UITableViewController {
    
    private enum ProductDetailRow: Int {
        case size = 1
        case sizePicker = 2
        case color = 3
        case colorPicker = 4
        case descriptionTitle = 6
        case description = 7
        case specsTitle = 8
        case specs = 9
    }
    
    private let standardRowHeight: CGFloat = 44
    private let pickerRowHeight: CGFloat = 100
    
    private var showSizePicker = false
    private var showColorPicker = false
    private var showDescription = false
    private var showSpecs = false
    
    var product: Product!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var specsLabel: UILabel!
    
    @IBOutlet weak var selectedSizeLabel: UILabel!
    @IBOutlet weak var selectedColorLabel: UILabel!
    @IBOutlet weak var sizePicker: UIPickerView!
    @IBOutlet weak var colorPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard product != nil else {fatalError("\(type(of: self)) exists without a product.")}
        
        configureView()
    }
    
    private func configureView() {
        nameLabel.text = product.name
        priceLabel.text = String(product.price)
        descriptionLabel.text = product.description
        specsLabel.text = product.specs.reduce("") {$0 + $1 + "\n"}.trimmingCharacters(in: .whitespaces)
        showDescription = false
        selectedSizeLabel.text = product.sizes?.first
        selectedColorLabel.text = product.colors?.first
        showSpecs = false
    }
    
    @IBAction func addToBagButtonTapped(_ sender: Any) {
        let loadingVC = LoadingViewController.create("Adding to bag")
        
        var productSelection = ProductSelection(product: product, size: nil, color: nil, quantity: 1)
        
        if let size = selectedSizeLabel.text, size.count > 0 {
            productSelection.size = size
        }
        
        if let color = selectedColorLabel.text, color.count > 0 {
            productSelection.color = color
        }
        
        present(loadingVC, animated: true) {
            CheckoutController.shared.addToBag(productSelection: productSelection) { bag in
                self.dismiss(animated: true, completion: {
                    guard bag != nil else {
                        self.presentErrorAlert()
                        return
                    }
                    
                    self.presentItemAddedAlert()
                })
                
            }
        }
    }
    
    private func presentItemAddedAlert() {
        let alert = UIAlertController(title: "Item added", message: "\(self.product.name) was added to your bag.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func presentErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "There was a problem adding \(self.product.name) to your bag. Please try again later.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = ProductDetailRow(rawValue: indexPath.row) else {
            return standardRowHeight
        }
        
        switch row {
        case .size:
            return product.sizes != nil ? standardRowHeight : 0
        case .sizePicker:
            return showSizePicker ? sizePicker.frame.height : 0
        case .color:
            return product.colors != nil ? standardRowHeight : 0
        case .colorPicker:
            return showColorPicker ? colorPicker.frame.height : 0
        case .description:
            return showDescription ? pickerRowHeight : 0
        case .specs:
            return showSpecs ? pickerRowHeight : 0
        default:
            return standardRowHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = ProductDetailRow(rawValue: indexPath.row) else {
            return UITableViewAutomaticDimension
        }
        
        switch row {
        case .size:
            return product.sizes != nil ? standardRowHeight : 0
        case .sizePicker:
            return showSizePicker ? sizePicker.frame.height : 0
        case .color:
            return product.colors != nil ? standardRowHeight : 0
        case .colorPicker:
            return showColorPicker ? colorPicker.frame.height : 0
        case .description:
            return showDescription ? descriptionLabel.frame.height : 0
        case .specs:
            return showSpecs ? specsLabel.frame.height : 0
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var rowToScrollTo: IndexPath?
        
        if let row = ProductDetailRow(rawValue: indexPath.row) {
            switch row {
            case .size:
                showSizePicker = !showSizePicker
                rowToScrollTo = showSizePicker ? IndexPath(item: ProductDetailRow.size.rawValue + 1, section: 0) : nil
            case .color:
                showColorPicker = !showColorPicker
                rowToScrollTo = showColorPicker ? IndexPath(item: ProductDetailRow.color.rawValue + 1, section: 0) : nil
            case .descriptionTitle:
                showDescription = !showDescription
                rowToScrollTo = showDescription ? IndexPath(item: ProductDetailRow.description.rawValue, section: 0) : nil
            case .specsTitle:
                showSpecs = !showSpecs
                rowToScrollTo = showSpecs ? IndexPath(item: ProductDetailRow.specs.rawValue, section: 0) : nil
            default:
                break
            }
        }
        
        tableView.performBatchUpdates(nil) { (_) in
            if let indexPath = rowToScrollTo {
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    private func viewsUpdated() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}

extension ProductDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case sizePicker, colorPicker:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case sizePicker:
            return product.sizes?.count ?? 0
        case colorPicker:
            return product.colors?.count ?? 0
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case sizePicker:
            return product.sizes?[row]
        case colorPicker:
            return product.colors?[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sizePicker:
            selectedSizeLabel.text = product.sizes?[row]
        case colorPicker:
            selectedColorLabel.text = product.colors?[row]
        default:
            break
        }
    }
}

