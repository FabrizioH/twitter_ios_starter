//
//  TweetViewController.swift
//  Twitter
//
//  Created by Fabrizio Herrera on 9/24/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        
        tweetTextView.text = "What's happening?"
        tweetTextView.textColor = UIColor.lightGray
        
        tweetTextView.becomeFirstResponder()
        
        tweetTextView.selectedTextRange = nil
        
    }
    

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { Error in
                print("Error posting tweet \(Error)")
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textView(_ tweetTextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let characterLimit = 140
        
        let currentText:String = tweetTextView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            
            tweetTextView.text = "What's happening?"
            tweetTextView.textColor = UIColor.lightGray
            
            tweetTextView.selectedTextRange = nil
            
            charCount.text = String(140)
        
        } else if tweetTextView.textColor == UIColor.lightGray && !text.isEmpty {
            
            tweetTextView.textColor = UIColor.black
            tweetTextView.text = text
            
            charCount.text = String(139)
            
        } else {
            if tweetTextView.textColor == UIColor.black {
                charCount.text = String(characterLimit - updatedText.count)
            }
            
            return true && (updatedText.count < characterLimit)
            
        }
        
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if tweetTextView.textColor == UIColor.lightGray {
                tweetTextView.selectedTextRange = nil
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
