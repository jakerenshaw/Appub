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

enum LoginError: Int {
    case InvalidEmail = 17008
    case InvalidPassword = 17009
    case EmailNotFound = 17011
}

class PubLoginViewController: UIViewController {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    var pubRegisterViewController: PubRegisterViewController?
    
    weak var delegate: PubLoginViewControllerDelegate?
    
    lazy var activitySpinner: UIActivityIndicatorView = {
        let activitySpinner = UIActivityIndicatorView(style: .medium)
        activitySpinner.tintColor = .label
        return activitySpinner
    }()
    
    let firebaseAuth: FirebaseAuth
    
    var email: String {
        return self.emailTextField.text ?? ""
    }
    
    var password: String {
        return self.passwordTextField.text ?? ""
    }
    
    init(firebaseAuth: FirebaseAuth) {
        self.firebaseAuth = firebaseAuth
        super.init(nibName: "PubLoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func backButtonSelected(_ sender: Any) {
        self.removeError()
        self.delegate?.goToPreviewPage()
    }
    
    @IBAction func registerButtonSelected(_ sender: Any) {
        self.removeError()
        self.pubRegisterViewController = PubRegisterViewController(firebaseAuth: self.firebaseAuth)
        self.pubRegisterViewController?.delegate = self
        self.present(pubRegisterViewController!, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.login()
    }
    
    func login() {
        self.removeKeyboard()
        self.removeError()
        self.loginButton.isUserInteractionEnabled = false
        self.loginButton.setTitle("", for: .normal)
        self.addSpinner()
        self.validateLogin()
    }
    
    func validateLogin() {
        self.firebaseAuth.signInUser(email: self.email, password: self.password, completion: { error in
            if let error = error {
                self.loginFailed(error: (error as NSError))
            } else {
                self.delegate?.loginSucceeded()
            }
        })
    }

    func loginFailed(error: NSError?) {
        self.removeSpinner()
        self.loginButton.isUserInteractionEnabled = true
        self.loginButton.setTitle("Login", for: .normal)
        if let error = error {
            self.displayError(error: error)
        }
    }
    
    func displayError(error: NSError) {
        guard let loginError = LoginError(rawValue: error.code) else {
            errorLabel.text = "An error has occured. Please try again."
            return
        }
        switch loginError {
        case .InvalidEmail:
            errorLabel.text = "Please enter a valid email"
        case .EmailNotFound:
            errorLabel.text = "Email address not found"
        case .InvalidPassword:
            errorLabel.text = "Password is either invalid or incorrect"
        }
    }
    
    func removeError() {
        errorLabel.text = ""
    }
    
    @objc func removeKeyboard() {
        self.view.endEditing(true)
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
