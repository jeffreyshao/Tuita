//
//  TweetsViewController.swift
//  Tuita
//
//  Created by Jeffrey Shao on 2/12/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            
            self.tweets = tweets
            self.tableView.reloadData()
            
            for tweet in tweets{
                print(tweet.text)
            }
            }, failure: { (error: (Error)) in
                print(error.localizedDescription)
        })
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance?.logout()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tweets != nil {
            return tweets!.count
        }
        else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath as IndexPath) as? TweetCell
        
        cell?.delegate = self
        cell?.tweet = tweets![indexPath.row]
        
        return cell!
    }
    
    func aviTap(cell: TweetCell, tweet: Tweet){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = mainStoryboard.instantiateViewController(withIdentifier: "profileViewController") as?
            ProfileViewController{
            vc.user = tweet.user
            self.navigationController?.pushViewController(vc, animated: true)
                
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let tag = (sender as AnyObject).tag ?? 0
        
        if(tag == 2) {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![(indexPath?.row)!]
            
            let profileViewController = segue.destination as! ProfileViewController
            
            profileViewController.user = User.currentUser
            profileViewController.tweet = tweet
            
        }
            
        else if(tag <= 0) {
            
            if(segue.identifier == "compose"){
                let navigationController = segue.destination as! UINavigationController
            }
                
            else if(segue.identifier == "DetailsControllerSegue"){
                let cell = sender as! UITableViewCell
                let indexPath = tableView.indexPath(for: cell)
                let tweet = tweets![(indexPath?.row)!]
                
                let nameController = segue.destination as! TweetDetailsController
                nameController.tweet = tweet
            }
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
