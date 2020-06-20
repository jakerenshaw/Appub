//
//  UserSelectionViewController.swift
//  Appub
//
//  Created by Jake Renshaw on 20/06/2020.
//  Copyright © 2020 Jake Renshaw. All rights reserved.
//

import UIKit

protocol UserSelectionViewControllerDelegate: class {
    func displayCustomerLoginViewController()
    func displayEmployeeLoginViewController()
}

class UserSelectionViewController: UIViewController {
    
    @IBOutlet var customerLoginButton: UIButton!
    @IBOutlet var employeeLoginButton: UIButton!
    
    weak var delegate: UserSelectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func customerButtonSelected(_ sender: Any) {
        self.delegate?.displayCustomerLoginViewController()
    }
    
    @IBAction func employeeButtonSelected(_ sender: Any) {
        self.delegate?.displayEmployeeLoginViewController()
    }
    
}
