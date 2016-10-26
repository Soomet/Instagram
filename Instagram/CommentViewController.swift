//
//  CommentViewController.swift
//  Instagram
//
//  Created by Sumit Joshi on 10/25/16.
//  Copyright © 2016 soomet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CommentViewController: UIViewController {

    var postData: PostData!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(postData.id)
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する。
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(CommentViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }

    @IBAction func submitComment(sender: AnyObject) {
        // Firebaseに保存するデータの準備
        //現在のユーザーのユニークIDを取得
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            if let displayName = FIRAuth.auth()?.currentUser?.displayName {
                
                let new_comment = ["uid": uid, "name": displayName, "comment": commentTextField.text!]
                postData.comments.append(new_comment)
                let imageString = postData.imageString
                let name = postData.name
                let caption = postData.caption
                let time = (postData.date?.timeIntervalSinceReferenceDate)! as NSTimeInterval
                let likes = postData.likes
                let comments = postData.comments
                
                //辞書を作成してFirebaseに保存する
                let post = ["caption": caption!, "image": imageString!, "name": name!, "time": time, "likes": likes, "comments": comments]
                print(postData.comments)
                
                let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH)
                postRef.child(postData.id!).setValue(post)
            }
        }
        //commentViewControllerを閉じる
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        //キーボードを閉じる
        view.endEditing(true)
    }
}
