//
//  SignUpViewController.swift
//  Tinder
//
//  Created by TangWeichang on 8/28/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var interestedInWomen: UISwitch!
    
    @IBAction func signUp(sender: AnyObject) {
        PFUser.currentUser()?["interestedInWomen"] = interestedInWomen.on
        PFUser.currentUser()?.save()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Add users
        let urlArray = ["http://www.designfreebies.org/wp-content/uploads/2010/03/2010-vector-tutorials-illustrator-sexy-female-cartoon.jpg","http://static.vectorcharacters.net/uploads/2012/08/Cute_Girl_Vector_Character_Preview_Big.jpg","http://cliparts.co/cliparts/Acb/jre/AcbjreKc4.jpg","http://www.fanpop.com/clubs/mchopnpop/picks/results/722285/who-favorite-female-cartoon-characters-like-best","http://images4.fanpop.com/image/polls/722000/722285_1305869198524_full.png"]
        var counter = 1
        for url in urlArray {
            let nsUrl = NSURL(string:url)
            if let data = NSData(contentsOfURL: nsUrl!) {
                self.userImage.image = UIImage(data: data)
                let imageFile:PFFile = PFFile(data:data)
                var user:PFUser = PFUser()
                var username = "user\(counter)"
                user.username = username
                user.password = "pass"
                user["image"] = imageFile
                user["interestedInWomen"] = false
                user["gender"] = "female"
                counter++
                user.signUp()
            }
        }
        */
        let graphRequest = FBSDKGraphRequest(graphPath:"me", parameters:["fields": "id,name,gender,email"])
        graphRequest.startWithCompletionHandler ({
            (connection, result, error) -> Void in
            if error != nil {
                print(error)
            } else if let result = result {
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                PFUser.currentUser()?["email"] = result["email"]
                PFUser.currentUser()?.save()
                let userId = result["id"] as! String
                let facebookProfilePictureUrl = "https://graph.facebook.com/" + userId + "/picture?type=large"
                if let fbpicUrl = NSURL(string: facebookProfilePictureUrl) {
                    if let data = NSData(contentsOfURL: fbpicUrl) {
                        self.userImage.image = UIImage(data: data)
                        let imageFile:PFFile = PFFile(data:data)
                        PFUser.currentUser()?["image"] = imageFile
                        PFUser.currentUser()?.save()
                    }
                }
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
