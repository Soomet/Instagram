
//
//  PostViewController.swift
//  Instagram
//
//  Created by Sumit Joshi on 10/20/16.
//  Copyright © 2016 soomet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class PostViewController: UIViewController {
    var image: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    //投稿ボタンをタップした時よばれるメソッド
    @IBAction func handlePostButton(sender: AnyObject) {
        
        let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH)
        
        // ImageViewから画像を取得する
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.5)
        
        // NSUserDfaultsから表示名を取得する
        let ud = NSUserDefaults.standardUserDefaults()
        let name = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        
        // 時間を取得する
        let time = NSDate.timeIntervalSinceReferenceDate()
        
        // 辞書を作成してFirebaseに保存する
        let postData = ["caption": textField.text!, "image": imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength), "name": name, "time": time]
        postRef.childByAutoId().setValue(postData)
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccessWithStatus("投稿しました")
        
        // 全てのモーダルを閉じる
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //キャンセルボタンをタップした時に呼ばれるメソッド
    @IBAction func handleCancelbutton(sender: AnyObject) {
        // 画面を閉じる
//        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 受け取った画像をImageViewに設定する
        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
