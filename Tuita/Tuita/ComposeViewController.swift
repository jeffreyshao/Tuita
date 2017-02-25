//
//  ComposeViewController.swift
//  Tuita
//
//  Created by Jeffrey Shao on 2/25/17.
//  Copyright © 2017 Jeffrey Shao. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var textField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onGo(_ sender: AnyObject) {
        if let text = self.textField.text{
            let encoded = text.replacingOccurrences(of: " ", with: "%20")
            
            TwitterClient.sharedInstance?.sendTweet(message: encoded, success: {
                print("ok")
                }, failure: { (error: Error) in
                    print(error.localizedDescription)
            })
        }
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onChange(_ sender: AnyObject) {
        let temp = textField.text
        let numTemp = temp?.characters.count
        charCount.text = "\(140 - numTemp!)"
        if (Int(charCount.text!)! <= 0) {
            textField.text = String(textField.text!.characters.dropLast())
        }
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
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
