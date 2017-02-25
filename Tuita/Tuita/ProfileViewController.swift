//
//  ProfileViewController.swift
//  Tuita
//
//  Created by Jeffrey Shao on 2/20/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var headerImageURL: URL?
    var aviImageURL: URL?
    var followers: Int?
    var following: Int?
    var tweets: Int?
    
    var user: User?
    var tweet: Tweet!
    
    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var avi: UIImageView!
    @IBOutlet weak var tweetNo: UILabel!
    @IBOutlet weak var followingNo: UILabel!
    @IBOutlet weak var followerNo: UILabel!
    @IBOutlet weak var screenname: UILabel!
    @IBOutlet weak var handle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImageURL = user?.headerURL
        aviImageURL = user?.profileURL
        
        followers = user?.followerCount
        following = user?.followingCount
        tweets = user?.tweetCount
        screenname.text = (user?.name)!
        handle.text = "@\(user?.twitterHandle)"
        
        header.setImageWith(headerImageURL!)
        avi.setImageWith(aviImageURL!)
        tweetNo.text = "\(tweets!)"
        followingNo.text = "\(following!)"
        followerNo.text = "\(followers!)"
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
