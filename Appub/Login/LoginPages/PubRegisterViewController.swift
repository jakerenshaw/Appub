//
//  PubRegisterViewController.swift
//  Appub
//
//  Created by Jake Renshaw on 21/06/2020.
//  Copyright © 2020 Jake Renshaw. All rights reserved.
//

import UIKit

protocol PubRegisterViewControllerDelegate: class {
    func registerPub(email: String, password: String)
}

class PubRegisterViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var pubNameTextField: UITextField!
    @IBOutlet var postcodeTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    
    weak var delegate: PubRegisterViewControllerDelegate?
    lazy var activitySpinner: UIActivityIndicatorView = {
        let activitySpinner = UIActivityIndicatorView(style: .medium)
        activitySpinner.tintColor = .label
        return activitySpinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        self.signUpButton.isUserInteractionEnabled = false
        self.signUpButton.setTitle("", for: .normal)
        self.addSpinner()
        self.validateRegisteration()
    }
    
    func validateRegisteration() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let email = self.emailCheck(),
                let password = self.passwordCheck(),
                self.pubNameCheck(),
                self.postcodeCheck() {
                
                self.delegate?.registerPub(email: email, password: password)
            } else {
                self.removeSpinner()
                self.signUpButton.isUserInteractionEnabled = true
                self.signUpButton.setTitle("Sign Up", for: .normal)
            }
        }
    }
    
    func emailCheck() -> String? {
        if let text = self.emailTextField.text {
            return text
        } else {
            return nil
        }
    }
    
    func passwordCheck() -> String? {
        if let text = self.passwordTextField.text {
            return text
        } else {
            return nil
        }
    }
    
    func pubNameCheck() -> Bool {
        return true
    }
    
    func postcodeCheck() -> Bool {
        return true
    }
    
    func addSpinner() {
        self.signUpButton.addSubview(self.activitySpinner)
        self.activitySpinner.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        activitySpinner.startAnimating()
    }
    
    func removeSpinner() {
        self.activitySpinner.stopAnimating()
        self.activitySpinner.removeFromSuperview()
    }
}
