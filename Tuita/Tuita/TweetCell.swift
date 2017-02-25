//
//  TweetCell.swift
//  Tuita
//
//  Created by Jeffrey Shao on 2/14/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate{
    @objc optional func aviTap(cell: TweetCell, tweet: Tweet)
}

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var avi: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var words: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var faveButton: UIButton!
    @IBOutlet weak var retweets: UILabel!
    @IBOutlet weak var faves: UILabel!
    
    var tweetID: String?
    
    
    var tweet: Tweet! {
        didSet{
            
            words.text = tweet.text
            avi.setImageWith((tweet.user?.profileURL)!)
            self.avi.isUserInteractionEnabled = true
            let aviTapped = UITapGestureRecognizer(target: self, action: #selector(aviTap(gesture:)))
            self.avi.addGestureRecognizer(aviTapped)
            username.text = tweet.user?.name
            let handleText = (tweet.user?.twitterHandle)! as String
            handle.text = "@\(handleText)"
            retweets.text = String(tweet.retweetCount)
            faves.text = String(tweet.favoritesCount)
            tweetID = tweet.tweetID
            time.text = tweet.timeString
            
        }
    }
    
    weak var delegate: TweetCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    func aviTap(gesture: UITapGestureRecognizer){
        delegate?.aviTap!(cell: self, tweet: self.tweet)
    }


}
