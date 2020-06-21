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

enum RegisterError: Int {
    case NonMatchingEmail = 51
    case NonMatchingPassword = 52
    case InvalidPassword = 17026
    case NoEmailProvided = 17034
}

class PubRegisterViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var confirmEmailTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    
    let firebaseAuth: FirebaseAuth
    
    var email: String {
        return self.emailTextField.text ?? ""
    }
    
    var confirmEmail: String {
        return self.confirmEmailTextField.text ?? ""
    }
    
    var password: String {
        return self.passwordTextField.text ?? ""
    }
    
    var confirmPassword: String {
        return self.confirmPasswordTextField.text ?? ""
    }
    
    weak var delegate: PubRegisterViewControllerDelegate?
    lazy var activitySpinner: UIActivityIndicatorView = {
        let activitySpinner = UIActivityIndicatorView(style: .medium)
        activitySpinner.tintColor = .label
        return activitySpinner
    }()
    
    init(firebaseAuth: FirebaseAuth) {
        self.firebaseAuth = firebaseAuth
        super.init(nibName: "PubRegisterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        self.signUp()
    }
    
    func signUp() {
        self.removeKeyboard()
        self.removeError()
        self.signUpButton.isUserInteractionEnabled = false
        self.signUpButton.setTitle("", for: .normal)
        self.addSpinner()
        self.validateRegisteration()
    }
    
    func validateRegisteration() {
        if matchingEmails(), matchingPasswords() {
            self.firebaseAuth.createUser(email: self.email, password: self.password, completion: { error in
                if let error = error {
                    self.registrationFailed(error: (error as NSError))
                } else {
                    self.delegate?.registerPub(email: self.email, password: self.password)
                }
            })
        }
    }
    
    func registrationFailed(error: NSError?) {
        self.removeSpinner()
        self.signUpButton.isUserInteractionEnabled = true
        self.signUpButton.setTitle("Sign Up", for: .normal)
        if let error = error {
            self.displayError(error: error)
        }
    }
    
    func displayError(error: NSError) {
        guard let loginError = RegisterError(rawValue: error.code) else {
            errorLabel.text = "An error has occured. Please try again."
            return
        }
        switch loginError {
        case .NoEmailProvided:
            errorLabel.text = "An email address must be provided"
        case .InvalidPassword:
            errorLabel.text = "The password must be 6 characters long or more"
        case .NonMatchingEmail:
            errorLabel.text = "The email addresses entered do not match"
        case .NonMatchingPassword:
            errorLabel.text = "The passwords entered do not match"
        }
    }
    
    func removeError() {
        self.errorLabel.text = ""
    }
    
    @objc func removeKeyboard() {
        self.view.endEditing(true)
    }
    
    func matchingEmails() -> Bool {
        if self.email == self.confirmEmail {
            return true
        } else {
            self.registrationFailed(error: NSError(domain: "", code: 51, userInfo: nil))
            return false
        }
    }
    
    func matchingPasswords() -> Bool {
        if self.password == self.confirmPassword {
            return true
        } else {
            self.registrationFailed(error: NSError(domain: "", code: 52, userInfo: nil))
            return false
        }
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
