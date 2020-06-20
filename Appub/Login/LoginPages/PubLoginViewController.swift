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
}

class PubLoginViewController: UIViewController {
    
    @IBOutlet var backButton: UIButton!
    
    weak var delegate: PubLoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonSelected(_ sender: Any) {
        self.delegate?.goToPreviewPage()
    }
}
