//
//  LoginPageViewController.swift
//  Appub
//
//  Created by Jake Renshaw on 20/06/2020.
//  Copyright © 2020 Jake Renshaw. All rights reserved.
//

import UIKit

protocol LoginPageViewControllerDelegate: class {
    func pubLoginSucceeded()
}

class LoginPageViewController: UIPageViewController {
    
    lazy var userSelectionViewController: UserSelectionViewController = {
        let controller = UserSelectionViewController()
        controller.delegate = self
        return controller
    }()
    
    lazy var pubSelectionViewController: PubSelectionViewController = {
        let controller = PubSelectionViewController()
        controller.delegate = self
        return controller
    }()
    
    lazy var pubLoginViewController: PubLoginViewController = {
        let controller = PubLoginViewController()
        controller.delegate = self
        return controller
    }()
    
    weak var loginDelegate: LoginPageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        self.addUserSelectionController()
    }
    
    func addUserSelectionController() {
        DispatchQueue.main.async {
            self.setViewControllers([self.userSelectionViewController], direction: .forward, animated: true, completion: nil)
        }
    }

}

extension LoginPageViewController: UserSelectionViewControllerDelegate {
    func displayCustomerLoginViewController() {
        DispatchQueue.main.async {
            self.setViewControllers([self.pubSelectionViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func displayEmployeeLoginViewController() {
        DispatchQueue.main.async {
            self.setViewControllers([self.pubLoginViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

extension LoginPageViewController: PubSelectionViewControllerDelegate, PubLoginViewControllerDelegate {
    func loginSucceeded() {
        self.loginDelegate?.pubLoginSucceeded()
    }
    
    func goToPreviewPage() {
        self.setViewControllers([self.userSelectionViewController], direction: .reverse, animated: true, completion: nil)
    }
}
