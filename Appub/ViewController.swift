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
    
    let spinner = UIActivityIndicatorView()
    
    @IBOutlet var tabContainerView: UIView!
    
    lazy var loginpageViewController: LoginPageViewController = {
        LoginPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
    }()
    
    lazy var tabViewController: TabViewController = {
        TabViewController(tabs: [.squad])
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSpinner()
        self.addLoginViewController()
        //self.addTabViewController()
    }
    
    func addSpinner() {
        spinner.tintColor = .label
        spinner.style = .large
        self.view.addSubview(self.spinner)
        self.spinner.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.spinner.startAnimating()
    }
    
    func addLoginViewController() {
        DispatchQueue.main.async {
            self.present(self.loginpageViewController, animated: true, completion: nil)
        }
    }

    func addTabViewController() {
        self.addChild(self.tabViewController)
        self.tabContainerView.addSubview(self.tabViewController.view)
    }


}

