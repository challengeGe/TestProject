//
//  FirstViewController.swift
//  CLLocation
//
//  Created by 葛建军 on 17/6/27.
//  Copyright © 2017年 HANGZHOUTEAM. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.red
        let btn=UIButton(type: UIButtonType.custom)
        btn.frame=CGRect(x: 50, y: 200, width: 100, height: 100)
        btn.addTarget(self, action: #selector(旋转(_:)), for: UIControlEvents.touchUpInside)
        btn.setTitle("旋转", for: UIControlState.normal)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view.
    }
    func 旋转(_ sender: UIButton) {
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let oldState=UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.keyWindow?.rootViewController=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            UIView.setAnimationsEnabled(oldState)
        }) { (finished) in
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
