//
//  ViewController.swift
//  Appub
//
//  Created by Jake Renshaw on 20/06/2020.
//  Copyright © 2020 Jake Renshaw. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var activitySpinner: UIActivityIndicatorView = {
        let activitySpinner = UIActivityIndicatorView(style: .large)
        activitySpinner.tintColor = .label
        return activitySpinner
    }()
    
    @IBOutlet var tabContainerView: UIView!
    
    lazy var loginPageViewController: LoginPageViewController = {
        let loginPage = LoginPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            firebaseAuth: self.firebaseAuth
        )
        loginPage.loginDelegate = self
        return loginPage
    }()
    
    lazy var tabViewController: TabViewController = {
        TabViewController(tabs: [.squad])
    }()
    
    lazy var firebaseAuth: FirebaseAuth = {
        FirebaseAuth()
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSpinner()
        self.addLoginViewController()
        //self.addTabViewController()
    }
    
    func addSpinner() {
        self.view.addSubview(self.activitySpinner)
        self.activitySpinner.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.activitySpinner.startAnimating()
    }
    
    func removeSpinner() {
        self.activitySpinner.stopAnimating()
        self.activitySpinner.removeFromSuperview()
    }
    
    func addLoginViewController() {
        DispatchQueue.main.async {
            self.present(self.loginPageViewController, animated: true, completion: nil)
        }
    }

    func addTabViewController() {
        self.addChild(self.tabViewController)
        self.tabContainerView.addSubview(self.tabViewController.view)
    }
}

extension ViewController: LoginPageViewControllerDelegate {
    func pubLoginSucceeded() {
        self.loginPageViewController.dismiss(animated: true, completion: nil)
        self.removeSpinner()
    }
}

