//
//  User.swift
//  Tuita
//
//  Created by Jeffrey Shao on 2/6/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    //var screenname: String?
    var profileURL: URL?
    var headerURL: URL?
    var describer: String?
    var twitterHandle: String?
    var followingCount: Int?
    var followerCount: Int?
    var tweetCount: Int?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        //screenname = dictionary["screenname"] as? String
        twitterHandle = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileURL = URL(string: profileUrlString)
        }
        
        let headerUrlString = dictionary["profile_background_image_url_https"] as? String
        if let headerUrlString = headerUrlString {
            headerURL = URL(string: headerUrlString)
        }
        
        describer = dictionary["description"] as? String
        tweetCount = dictionary["statuses_count"] as? Int
        
        followingCount = dictionary["friends_count"] as? Int
        followerCount = dictionary["followers_count"] as? Int
        
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User?{
        get {
            if _currentUser == nil{
                let defaults = UserDefaults.standard
            
                let userData = defaults.object(forKey: "currentUserData") as? Data
            
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user){
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            }
            else{
                
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
}
