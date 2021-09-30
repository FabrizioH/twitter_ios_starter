//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Fabrizio Herrera on 9/28/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var numTweets: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadProfile()
    }
    @objc func loadProfile() {
        let myUrl = "https://api.twitter.com/1.1/account/verify_credentials.json"

        TwitterAPICaller.client?.getUserInfo(url: myUrl, success: { (profileInfo: NSDictionary) in
            let screen_name = profileInfo["screen_name"] as! String
            let friends_count = profileInfo["friends_count"] as! Int
            let followers_count = profileInfo["followers_count"] as! Int
            let statuses_count = profileInfo["statuses_count"] as! Int
            
            self.handleLabel.text = "@\(screen_name)"
            self.numFollowing.text = "\(friends_count)"
            self.numFollowers.text = "\(followers_count)"
            self.numTweets.text = "\(statuses_count)"
            
            let profilePicUrl = URL(string: profileInfo["profile_image_url_https"] as! String)
            
            let urlData = try? Data(contentsOf: profilePicUrl!)
                
            if let data = urlData {
                self.profilePictureImageView.image = UIImage(data: data)
            }
            
        }, failure: { Error in
            print("Could not retrieve profile information")
        })
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
