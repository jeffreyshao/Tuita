//
//  TweetDetailsController.swift
//  Tuita
//
//  Created by Jeffrey Shao on 2/19/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit

class TweetDetailsController: UIViewController {
    
    @IBOutlet weak var avi: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var words: UILabel!
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var retweets: UILabel!
    @IBOutlet weak var faveButton: UIButton!
    @IBOutlet weak var faves: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var tweetID: String?
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(tweet.timeCreated)
        
        words.text = tweet.text
        let handleText = (tweet.user?.twitterHandle)! as String
        handle.text = "@\(handleText)"
        name.text = tweet.user?.name
        avi.setImageWith((tweet.user?.profileURL)!)
        retweets.text = String(tweet.retweetCount)
        faves.text = String(tweet.favoritesCount)
        tweetID = tweet.tweetID
        timeLabel.text = tweet.timeCreated
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRT(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.retweet(id: tweetID!, success: {
            self.retweets.text = "\((self.tweet?.retweetCount)! + 1)"
            }, failure: { (error: Error) in
                print(error.localizedDescription)
        })
    }

    @IBAction func onFave(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.favorite(id: tweetID!, success: {
            self.faves.text = "\((self.tweet?.favoritesCount)! + 1)"
            }, failure: { (error: Error) in
                print(error.localizedDescription)
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "compose"){
            let navigationController = segue.destination as! UINavigationController
        }

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
