//
//  TweetCell.swift
//  Tuita
//
//  Created by Jeffrey Shao on 2/14/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var avi: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var words: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var tweet: Tweet! {
        didSet{
            
            words.text = tweet.text
            avi.setImageWith((tweet.user?.profileURL)!)
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
