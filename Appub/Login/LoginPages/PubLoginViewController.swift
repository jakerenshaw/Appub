//
//  PubLoginViewController.swift
//  Appub
//
//  Created by Jake Renshaw on 20/06/2020.
//  Copyright © 2020 Jake Renshaw. All rights reserved.
//

import UIKit

protocol PubLoginViewControllerDelegate: class {
    func goToPreviewPage()
    func loginSucceeded()
}

class PubLoginViewController: UIViewController {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    
    var pubRegisterViewController: PubRegisterViewController?
    
    weak var delegate: PubLoginViewControllerDelegate?
    
    lazy var activitySpinner: UIActivityIndicatorView = {
        let activitySpinner = UIActivityIndicatorView(style: .medium)
        activitySpinner.tintColor = .label
        return activitySpinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonSelected(_ sender: Any) {
        self.delegate?.goToPreviewPage()
    }
    
    @IBAction func registerButtonSelected(_ sender: Any) {
        self.pubRegisterViewController = PubRegisterViewController()
        self.pubRegisterViewController?.delegate = self
        self.present(pubRegisterViewController!, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.login()
    }
    
    
    func login() {
        self.loginButton.isUserInteractionEnabled = false
        self.loginButton.setTitle("", for: .normal)
        self.addSpinner()
        self.validateLogin()
    }
    
    func validateLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.emailCheck(),
                self.passwordCheck() {
                self.delegate?.loginSucceeded()
            } else {
                self.removeSpinner()
                self.loginButton.isUserInteractionEnabled = true
                self.loginButton.setTitle("Login", for: .normal)
            }
        }
    }
    
    func addSpinner() {
        self.loginButton.addSubview(self.activitySpinner)
        self.activitySpinner.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        activitySpinner.startAnimating()
    }
    
    func removeSpinner() {
        self.activitySpinner.stopAnimating()
        self.activitySpinner.removeFromSuperview()
    }
    
    func emailCheck() -> Bool {
        return true
    }
    
    func passwordCheck() -> Bool {
        return true
    }
    
}

extension PubLoginViewController: PubRegisterViewControllerDelegate {
    func registerPub(email: String, password: String) {
        self.pubRegisterViewController?.dismiss(animated: true, completion: nil)
        self.pubRegisterViewController = nil
        self.emailTextField.text = email
        self.passwordTextField.text = password
        self.login()
    }
}
