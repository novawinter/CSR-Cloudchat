//
// CSRMethods.swift
//  Created by Brandon Sugarman on 5/18/19.
//

import Foundation
import Firebase
import FirebaseAuth

class CSRMethods {
    var usernames = Array<String>()
    var ref: DatabaseReference!
    static var app: CSRMethods = {
        return CSRMethods()
    }()
    
    func signUp(username: String, email: String, password: String)  {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            (User, error) in
            if error != nil {
                
                // Handle the error (i.e notify the user of the error)
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    
                    switch errCode {
                    case .invalidEmail:
                        self.showAlert(titleMessage: "CSR Alert", messageString: "Invalid email")
                        return
                        
                    case .emailAlreadyInUse:
                        self.showAlert(titleMessage: "CSR Alert", messageString: "Email already in use")
                        return
                        
                    case .weakPassword:
                        self.showAlert(titleMessage: "CSR Alert", messageString: "Weak password")
                        return
                        
                    default:
                        self.showAlert(titleMessage: "CSR Alert", messageString: "Other error")
                        return
                        
                    }
                }
            } else {
                self.changeScreens(id: "newsfeed")
                self.addUserToFirebase(username: username, password: password, email: email)
                
                self.showAlert(titleMessage: "CSR Alert", messageString: "Welcome to CSR Alert " + email + "! Enjoy chatting with your friends :)")
                
            }
            
        }
        
    }
    
    
    
    func addUserToFirebase(username: String, password: String, email: String){
        let newUser = [
            "username": username,
            "email" : email
        ]
        
        self.ref =  Database.database().reference().child("users").child(username)
        ref.updateChildValues(newUser)
    }
    
    
    
    
    func login(username: String, email: String, password: String){
        
        
        Auth.auth().signIn(withEmail: email, password: password) {(Auth, error) in
            if (error == nil){
                self.changeScreens(id: "newsfeed")
                self.showAlert(titleMessage: "CSR Alert" ,messageString: "Welcome back " + email + "!")
                
            } else{
                self.showAlert(titleMessage: "CSR Alert", messageString: "Please try again. ")
            }
        }
        
    }
    
    func changeScreens(id: String){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var newsfeed = storyBoard.instantiateViewController(withIdentifier: id) as? NewsfeedViewController
        var appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        var login = storyBoard.instantiateViewController(withIdentifier: id) as?
        LoginViewController
        var signup = storyBoard.instantiateViewController(withIdentifier: id) as?
        SignupViewController
        var home = storyBoard.instantiateViewController(withIdentifier: id) as?
        ViewController
        var writepost = storyBoard.instantiateViewController(withIdentifier: id) as?
        WritePostViewController
        
        
        if (id == "newsfeed"){
            appDelegate?.window?.rootViewController = newsfeed
            
        } else if (id == "login") {
            appDelegate?.window?.rootViewController = login
            
        } else if (id == "signup") {
            appDelegate?.window?.rootViewController = signup
            
        } else if (id == "home"){
            appDelegate?.window?.rootViewController = home
            
        } else if (id == "writepost"){
            appDelegate?.window?.rootViewController = writepost
            
        }
        // //set storyboard ID to viewController.
        
        // viewController.present(viewController, animated: false, completion: nil)
        
    }
    
    
    func showAlert(titleMessage: String, messageString: String) {
        let alert = UIAlertController(title: titleMessage, message: messageString, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in return }
        alert.addAction(action)
        UIApplication.topViewController()?.present(alert, animated: false, completion: nil)
        
    }
}




extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}



