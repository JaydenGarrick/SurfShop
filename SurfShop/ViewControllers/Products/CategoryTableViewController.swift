
import UIKit
import SafariServices

class CategoryTableViewController: UITableViewController {
    
    private var categories: [Category] = []
    
    override func viewDidLoad() {
        getCategories()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    func presentRetryAlert() {
        let alertController = UIAlertController(title: "Uh oh...", message: "Looks like something went wrong trying to get product categories from the internet. This means you won't be able to do any shopping! If this keeps happenning, please give us a call so we can help fix the problem.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default) { (_) in
            self.getCategories()
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func getCategories() {
        ProductController.shared.getCategories { (categories) in
            if categories.count == 0 {
                self.presentRetryAlert()
            } else {
                self.categories = categories
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ProductTableViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("\(type(of: self)) attempting to segue to something other than `ProductTableViewController`.")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        destination.category = categories[indexPath.row]
    }

}
