//
//  ViewController.swift
//  csr-chat
//
//  Created by Brandon Sugarman on 5/23/19.
//  Copyright © 2019 Brandon Sugarman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func goToLogin(_ sender: Any) {
        CSRMethods.app.changeScreens(id: "login")
    }
    
    
    @IBAction func goToSignUp(_ sender: Any) {
        CSRMethods.app.changeScreens(id: "signup")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

