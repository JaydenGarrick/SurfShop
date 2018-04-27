
import UIKit

class ProductTableViewController: UITableViewController {
    
    var category: Category?
    var products: [Product] = []
    
    override func viewDidLoad() {
        guard let category = category else {fatalError("\(type(of: self)) ended up without a category)")}
        self.title = category.name
        ProductController.shared.getProducts(for: category) { (products) in
            self.products = products
            self.tableView.reloadData()
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if traitCollection.horizontalSizeClass == .regular {
            let destinationController = segue.destination as! ProductDetailViewController
            destinationController.modalPresentationStyle = .formSheet
            
            let sourceVC = segue.source as! ProductTableViewController
            sourceVC.modalPresentationStyle = .formSheet
        }
        
        guard let destination = segue.destination as? ProductDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("\(type(of: self)) attempting to segue to something other than `ProductDetailViewController`.")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        destination.product = products[indexPath.row]
    }
}
