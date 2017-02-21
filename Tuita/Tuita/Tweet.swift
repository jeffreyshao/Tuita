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
    var isRT: Bool?
    var isFave: Bool?
    var tweetID: String?
    var timeString: String?
    
//    if let user =  dictionary["user"] as? NSDictionary {
//        name = user["name"] as? String
//        screenname = user["screen_name"] as? String
//        
//        let profileUrlString = user["profile_image_url_https"] as? String
//        profileUrl = URL(string: profileUrlString!)
//        self.user = user //explicity assigning to member variable called user
//    }
    
//    init(dictionary: NSDictionary) {
//        var user = dictionary["user"] as? NSDictionary //this is a local user var
//        if let user = user {
//            name = user["name"] as? String
//            screenname = user["screen_name"] as? String
//            
//            let profileUrlString = user["profile_image_url_https"] as? String
//            profileUrl = URL(string: profileUrlString!)
//        }
//        user = dictionary["user"] as? NSDictionary //here you are assigning  dictionary["user"] to the local var user above, so the self.user never gets initailized
//    }
    
    init(dictionary: NSDictionary){
        
        let userDictionary = dictionary["user"] as? NSDictionary
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        profileURL = userDictionary?["profile_image_url"] as? String
        handle = dictionary["screen_name"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int)!
        favoritesCount = (dictionary["favorite_count"] as? Int)!
        isRT = dictionary["retweeted"] as? Bool
        isFave = dictionary["favorited"] as? Bool
        tweetID = dictionary["id_str"] as? String
        
        
        //if this exists, use it
        retweetCount = (dictionary["retweet_Count"] as? Int) ?? 0    //otherwise, use 0
        
        //if this exists, use it
        favoritesCount = (dictionary["favourites_Count"] as? Int) ?? 0    //otherwise, use 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            formatter.locale = Locale.init(identifier: "en_GB")
            timeStamp = formatter.date(from: timeStampString)
        }
        else{
            timeString = "idk"
        }
        
        let timeElapsed = Int(0 - (timeStamp?.timeIntervalSinceNow)!)
        
        let secondsInMinute = 60
        let secondsInHour = secondsInMinute * 60
        let secondsInDay = secondsInHour * 24
        let secondsInMonth = secondsInDay * 30
        let monthsElapsed = timeElapsed/secondsInMonth
        let daysElapsed = timeElapsed/secondsInDay
        let hoursElapsed = timeElapsed/secondsInHour
        let minutesElapsed = timeElapsed/secondsInMinute
        let secondsElapsed = timeElapsed
        
        
        if monthsElapsed != 0 {
            timeString = "\(monthsElapsed)mon"
            
        } else if daysElapsed != 0 {
            timeString = "\(daysElapsed)d"
            
            
        } else if hoursElapsed != 0 {
            timeString = "\(hoursElapsed)h"
            
            
        } else if minutesElapsed != 0 {
            timeString = "\(minutesElapsed)m"
            
        } else {
            timeString = "\(secondsElapsed)s"
            
            
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

