//
//  AboutViewController.swift
//  ft-ios
//
//  Created by Martin on 25/1/17.
//  Copyright © 2017 Martin. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onGithubButtonPressed(_ sender: UIButton) {
        self.goToURL(named: "https://www.github.com/martincarrera/")
    }
    
    @IBAction func onLinkedInButtonPressed(_ sender: UIButton) {
        self.goToURL(named: "https://www.linkedin.com/in/carreramartin/")
    }
    
    @IBAction func onWebsiteButtonPressed(_ sender: UIButton) {
        self.goToURL(named: "http://www.martincarrera.xyz/")
    }
    
    @IBAction func onFacebookButtonPressed(_ sender: UIButton) {
        self.goToURL(named: "https://www.facebook.com/martinc.92")
    }
    
    func goToURL(named: String) {
        let url = URL(string: named)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
