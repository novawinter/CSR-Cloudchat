//
//  NewsfeedViewController.swift
//  csr-chat
//
//  Created by Brandon Sugarman on 5/23/19.
//  Copyright © 2019 Brandon Sugarman. All rights reserved.
//

import UIKit

import Firebase

class NewsfeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:DatabaseReference!
    var messages:Array<String>!
    
    @IBOutlet weak var newsfeed: UITableView!
    
    
    @IBAction func goHome(_ sender: Any) {
        CSRMethods.app.changeScreens(id: "home")
        
    }
    
    @IBAction func goToWritepost(_ sender: Any) {
        CSRMethods.app.changeScreens(id: "writepost")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(messages == nil){
            return 0
        }
        // write code here -- return the number of cells in the table
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // write code here -- let's create our individual cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        //cell.textLabel?.font = cell.textLabel?.font.withSize(30)
        cell.textLabel?.font = UIFont(name:"Chalkduster", size:30)
        cell.textLabel?.textColor = UIColor.darkGray
        // custom color: UIColor.init(red: /255, green: /255, blue: /255, alpha: 1/255)
        cell.textLabel?.text = messages[indexPath.item]
        
        return cell
        
    }
    
   
    
    var timer = Timer()
    func startRefreshTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: refreshMessages(_:) .self)
    }
    
    @IBAction func refreshMessages(_ sender: Any) {
        ref = Database.database().reference().child("posts")
        self.messages = []
        
        ref.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            for currPost in snapshot.children.allObjects as! [DataSnapshot]{
                let post = currPost.value as! String
                self.messages.append(post)
            }
            self.messages.reverse()
            self.newsfeed.reloadData()
        } )
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startRefreshTimer()
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
