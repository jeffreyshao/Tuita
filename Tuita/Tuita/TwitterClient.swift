//
//  TwitterClient.swift
//  Tuita
//
//  Created by Jeffrey Shao on 2/12/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "bM4L68B6mJZBSBRocmJNVHMzp", consumerSecret: "f8P0vwJa4Pb3Ph5kx0tY8RZSBoBhvr9o8NYTuGn4dxmEFpHeTW")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping ()->(), failure: @escaping (Error) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "Tuita://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            
            let token: String = (requestToken?.token)!
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
            
            print("https://api.twitter.com/oauth/authorize?oauth_token=\(token)")
            
            UIApplication.shared.open(url)
            
            
            }, failure: { (error: Error?) in
                self.loginFailure?(error!)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) ->() , failure: @escaping (Error) -> () ){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()){
        
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
            success: { (task: URLSessionDataTask, response: Any?) in
            
            //print("account: \(response)")
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
            })
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) ->() in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) -> () in
                self.loginFailure?(error)
            })

        }, failure: { (error: Error?) in
            self.loginFailure?(error!)
        })
    }

}
