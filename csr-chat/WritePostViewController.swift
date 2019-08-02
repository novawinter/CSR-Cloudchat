//
//  WritePostViewController.swift
//  csr-chat
//
//  Created by Brandon Sugarman on 5/23/19.
//  Copyright © 2019 Brandon Sugarman. All rights reserved.
//

import UIKit

import Firebase

class WritePostViewController: UIViewController {
    
    var ref:DatabaseReference!
    var post:String!
    
    @IBOutlet weak var postText: UITextView!
    
    @IBAction func goBack(_ sender: Any) {
        CSRMethods.app.changeScreens(id: "newsfeed")
        
    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
        ref = Database.database().reference().child("posts")
        let key = self.ref.childByAutoId().key
        //post = postText.text!
        let username = UserDefaults.standard.string(forKey: "username")
        post = username! + ": " + postText.text
        let newPost = [key: post!]
        ref.updateChildValues(newPost)
        
        CSRMethods.app.changeScreens(id: "newsfeed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.postText.text 
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
