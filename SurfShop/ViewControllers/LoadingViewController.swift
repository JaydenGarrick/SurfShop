//
//  LoadingViewController.swift
//  SurfShop
//
//  Created by James Pacheco on 2/5/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    static let storyboardId = "LoadingViewController"
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    static func create(_ message: String?) -> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: storyboardId) as! LoadingViewController
        vc.message = message
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        return vc
    }
    
    private var message: String?

    override func viewWillAppear(_ animated: Bool) {
        if let message = message {
            messageLabel.text = message
            messageLabel.isHidden = false
        } else {
            messageLabel.isHidden = true
        }
        
        loadingIndicator.startAnimating()
    }

    override func viewDidDisappear(_ animated: Bool) {
        loadingIndicator.stopAnimating()
    }
}
