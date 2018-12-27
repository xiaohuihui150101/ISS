//
//  ESAlert.swift
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

import UIKit

/**
 使用示例:
 
 1. ESAlert.API.mAlert(title: "提示", message: "看看")
 
 2. ESAlert.API.InputAlert(title: "提示", message: "输入金额", placeholder: "不大于1000", vc: self){(text) in
    print("输入：\(text)")
    }
 3.    ESAlert.API.OkAlert(title: "提示", message: "是否分享",vc:self){[weakSelf = self] in
 
 ESShareView.shareview.showInView(view: weakSelf.view, type: .GeneralShare, shareImageURL: "分享图片url" as AnyObject, shareContent: "分享内容", shareTitle: "分享标题", shareUrl: "分享链接")
 ESShareView.shareview.isShareSuccess = {(backMsg) in
 print("结果：\(backMsg)")
 }
 */

let MAIN_COLOR = UIColor(red: 52/255.0, green: 197/255.0, blue:
    170/255.0, alpha: 1.0)
let mScreenWidth    = UIScreen.main.bounds.width
let mScreenHeight   = UIScreen.main.bounds.height

class ESAlert: UIView {

   @objc static let API = ESAlert()
    
    fileprivate lazy var alertView: UIView = {[weak self] in
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5.0
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
        }()
    
    //更新约束override继承父类加每次add
    override func layoutSubviews() {
        super.layoutSubviews()
        //移动动画
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        
        alertView.center = CGPoint(x: mScreenWidth/2.0, y: mScreenHeight - CGFloat(300)/2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
            self.alertView.transform = CGAffineTransform.identity
        }, completion: nil)
        //  UIView.setAnimationCurve(UIViewAnimationCurve.easeIn) //设置动画相对速度
        UIView.commitAnimations()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
        self.addTap()
    }
    
    func showInView(view:UIView){
        ESAlert.API.frame = view.bounds
        view.addSubview(ESAlert.API)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
       // print("销毁")
    }

}

extension ESAlert {
    
    ///1.点击不响应提示框
    @objc func mAlert(title:String,message:String?,_ detail:String = "确定") {
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: detail)
        alert.show()
    }
    
    
    ///2.带确认的提示框
    @objc func OkAlert(title:String,message:String,_ detail:String = "确定",_ detail2:String = "取消",vc: UIViewController ,sure: @escaping ()->Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        // 设置2个UIAlertAction
        let cancelAction = UIAlertAction(title: detail2, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: detail, style: .default) { (UIAlertAction) in
            sure()
        }
        /**
          * 修改标题和提示信息的颜色，大小
          **/
        let titleStr = NSMutableAttributedString.init(string: title)
        titleStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSMakeRange(0, titleStr.length))
        titleStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, titleStr.length))
        alertController.setValue(titleStr, forKey: "attributedTitle")
        
        let messageStr = NSMutableAttributedString.init(string: message)
        messageStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSMakeRange(0, messageStr.length))
        messageStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, messageStr.length))
        alertController.setValue(messageStr, forKey: "attributedMessage")
        
        //更改字体颜色
        cancelAction.setValue(UIColor.black, forKey: "titleTextColor")
        okAction.setValue(UIColor.black, forKey: "titleTextColor")
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        // 弹出
        vc.present(alertController, animated: true, completion: nil)
    }
    
    ///2.带确认的提示框
    @objc func OkAlert2(title:String,message:String,_ detail:String = "确定",_ detail2:String = "取消",vc: UIViewController ,sure: @escaping ()->Void,cancel:@escaping ()->Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        // 设置2个UIAlertAction
        let cancelAction = UIAlertAction(title: detail2, style: .cancel){ (UIAlertAction) in
            cancel()
        }
        let okAction = UIAlertAction(title: detail, style: .default) { (UIAlertAction) in
            sure()
        }
    
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        // 弹出
        vc.present(alertController, animated: true, completion: nil)
    }
    
    
    
    ///3.带输入框提示框
    func InputAlert(title:String,message:String,placeholder:String,vc: UIViewController ,sure: @escaping (_ text:String)->Void) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { (textField:UITextField) in
            textField.placeholder = placeholder
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: UIAlertAction.Style.default) { (UIAlertAction) in
            let login = alertController.textFields![0]
            sure(login.text!)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        // 弹出
        vc.present(alertController, animated: true, completion: nil)
    }
    
}

//tap
extension ESAlert : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: self.alertView)
        if self.alertView.bounds.contains(touchPoint) {
            return false
        }
        return true
    }
}


extension ESAlert {
    fileprivate func setUpUI() {
//        addSubview(alertView)
//        alertView.snp.updateConstraints { (make) in
//            make.center.equalTo(self.center)
//            make.width.equalTo(150)
//            make.height.equalTo(150)}
    }
    
    fileprivate func addTap() {
        //创建点手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(showShareView))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func showShareView(){
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations:{[weak self] in
            // self.shareView.backgroundColor = UIColor.yellow
            self?.alertView.frame = CGRect(x: 0, y: mScreenHeight, width: mScreenWidth, height: 230)
          
        }, completion: {Void in
            self.removeFromSuperview()
        })
    }
}


// MARK: - 简化AlertController调用
extension UIAlertController {
    
    class func showIn(_ vc: UIViewController?,
                      title: String = "",
                      message: String = "",
                      cancelTitle: String = "取消",
                      confirmTitle: String? = nil,
                      cancelAction: ((UIAlertAction)->Void)? = nil,
                      confirmAction: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        alert.addAction(cancelAction)
        
        if let secondTitle = confirmTitle {
            let cancelAction = UIAlertAction(title: secondTitle, style: .default, handler: confirmAction)
            alert.addAction(cancelAction)
        }
        vc?.present(alert, animated: true, completion: nil)
    }
    
}
