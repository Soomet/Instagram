//
//  ViewController.swift
//  Instagram
//
//  Created by Sumit Joshi on 10/20/16.
//  Copyright © 2016 soomet. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    var estabBarController: ESTabBarController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // currentUserがnilならログインしていない
        if FIRAuth.auth()?.currentUser != nil {
            //ログインユーザーがnilでない場合は、ログインしている状態なので、setupTabメソッドを呼び出してタブを表示する
            
            setupTab()
        } else {
            
            // ログインしていなければログインの画面を表示する
            // viewDidAppear内でpresentViewControllerを呼び出しても表示されないためメソッドが終了してから呼ばれるようにする
            dispatch_async(dispatch_get_main_queue()) {
                let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(loginViewController!, animated: true, completion: nil)
            }
        }
    }
    
    func setupTab() {
        if estabBarController == nil {
            // 画像のファイル名を指定してESTabBarControllerを作成する
            estabBarController = ESTabBarController(tabIconNames: ["home", "camera", "setting"])
            
            // 背景色、選択時の色を設定する
            estabBarController.selectedColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
            estabBarController.buttonsBackgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
            
            // タブをタップした時に表示するViewControllerを設定する
            let homeViewController = storyboard?.instantiateViewControllerWithIdentifier("Home")
            let settingViewController = storyboard?.instantiateViewControllerWithIdentifier("Setting")
            
            estabBarController.setViewController(homeViewController, atIndex: 0)
            estabBarController.setViewController(settingViewController, atIndex: 2)
            
            // 真ん中のタブはボタンとして扱う
            estabBarController.highlightButtonAtIndex(1)
            estabBarController.setAction({
                
                // ボタンが押されたらImageViewControllerをモーダルで表示する
                let imageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ImageSelect")
                self.presentViewController(imageViewController!, animated: true, completion: nil)
                }, atIndex: 1)
            // 作成したESTabBarControllerを親のViewController（＝self）に追加する
            addChildViewController(estabBarController)
            view.addSubview(estabBarController.view)
            estabBarController.view.frame = view.bounds
            estabBarController.didMoveToParentViewController(self)
        }
    }
}

