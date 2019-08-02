//
//  SignupViewController.swift
//  csr-chat
//
//  Created by Brandon Sugarman on 5/23/19.
//  Copyright © 2019 Brandon Sugarman. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    @IBAction func hideOrSHowPassword(_ sender: Any) {
        if(passwordTextField.isSecureTextEntry == false){
            passwordTextField.isSecureTextEntry = true
        }else{
            passwordTextField.isSecureTextEntry = false
        }
    }
    
    
    @IBAction func hideOrSHowConfirmPassword(_ sender: Any) {
        if(confirmPasswordTextField.isSecureTextEntry == false){
            confirmPasswordTextField.isSecureTextEntry = true
        }else{
            confirmPasswordTextField.isSecureTextEntry = false
        }
    }
    
    
    @IBAction func goHome(_ sender: Any) {
        CSRMethods.app.changeScreens(id: "home")
    }
    
    @IBAction func tryToMakeAccount(_ sender: Any) {
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
        
        if(confirmPasswordTextField.text == ""){
            CSRMethods.app.showAlert(titleMessage: "CSR Alert", messageString:"Please enter your password in the confirm text box for safety.")
            return
        }
        
        if(passwordTextField.text != confirmPasswordTextField.text){
            CSRMethods.app.showAlert(titleMessage: "CSR Alert", messageString:"Your password and confirmed password don't match.")
            return
        }
        
        //saves username as key so we can access it later and display username
        UserDefaults.standard.set(usernameTextField.text!, forKey: "username")
        
        CSRMethods.app.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
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
