//
//  Tweet.swift
//  Tuita
//
//  Created by Jeffrey Shao on 2/6/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var profileURL: String?
    var name: String?
    var handle: String?
    var text: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    
    
    init(dictionary: NSDictionary){
        
        let userDictionary = dictionary["user"] as? NSDictionary
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        profileURL = userDictionary?["profile_image_url"] as? String
        
        
        
        //if this exists, use it
        retweetCount = (dictionary["retweet_Count"] as? Int) ?? 0    //otherwise, use 0
        
        //if this exists, use it
        favoritesCount = (dictionary["favourites_Count"] as? Int) ?? 0    //otherwise, use 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString)
        }
        
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        
        return tweets
    }
    
}

