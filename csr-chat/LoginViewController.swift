//
//  LoginViewController.swift
//  csr-chat
//
//  Created by Brandon Sugarman on 5/23/19.
//  Copyright © 2019 Brandon Sugarman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBAction func showOrHidePassword(_ sender: Any) {
        if(passwordTextField.isSecureTextEntry == false){
            passwordTextField.isSecureTextEntry = true
        }else{
            passwordTextField.isSecureTextEntry = false
        }
    }
    
    
    @IBAction func goToHome(_ sender: Any) {
        CSRMethods.app.changeScreens(id: "home")
    }
    
    
    @IBAction func tryLogin(_ sender: Any) {
        if(emailTextField.text == ""){
            CSRMethods.app.showAlert(titleMessage: "CSR Alert", messageString:"Please enter an email.")
            return
        }
        if(usernameTextField.text == ""){
            CSRMethods.app.showAlert(titleMessage: "CSR Alert", messageString:"Please enter a username.")
            return
        }
        if(passwordTextField.text == ""){
            CSRMethods.app.showAlert(titleMessage: "CSR Alert", messageString:"Please enter a password.")
            return
        }
        
        //saves username as key so we can access it later and display username
        UserDefaults.standard.set(usernameTextField.text!, forKey: "username")
        
        CSRMethods.app.login(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
