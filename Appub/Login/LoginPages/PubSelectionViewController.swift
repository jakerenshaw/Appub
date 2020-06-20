//
//  PubSelectionViewController.swift
//  Appub
//
//  Created by Jake Renshaw on 20/06/2020.
//  Copyright © 2020 Jake Renshaw. All rights reserved.
//

import UIKit

protocol PubSelectionViewControllerDelegate: class {
    func goToPreviewPage()
}

class PubSelectionViewController: UIViewController {
    
    @IBOutlet var backButton: UIButton!
    
    weak var delegate: PubSelectionViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonSelected(_ sender: Any) {
        self.delegate?.goToPreviewPage()
    }
    

}
