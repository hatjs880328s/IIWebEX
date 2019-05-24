//
//  SetPwdViewController.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import UIKit

/// 设置密码控制器
class SetPwdViewController: BaseViewController {

    /// 入参
    var realPwd = ""
    
    let pwdVw = UITextField()
    
    let rightVw = UIButton()
    
    let naviRightTxt = IIWebEXInter().iiwebex_completed
    
    let titleTxt = IIWebEXInter().iiwebex_setPwdTxt
    
    var editEndAction: ((_ pwd: String) -> Void)?
    
    /// 說明lb
    var titleLb: UILabel = UILabel()
    
    /// 說明文案
    var subTitle: String = IIWebEXInter().iiwebex_pwdsuggectTitle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = titleTxt
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: naviRightTxt, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goCreatingMt))
        self.addNavLeftButtonNormalImage(UIImage(named: "back_before"), navLeftButtonSelectedImage: UIImage(named: "back_after"))
        createVw()
        createRx()
    }
    
    /// 檢測 字母&數字  還有長度
    @objc func goCreatingMt() {
        if editEndAction == nil || self.pwdVw.text == nil {
            return
        }
        var flag = false
        if let results = RecognitionDoor.getInstance().recognition(with: self.pwdVw.text!) {
            for i in results {
                if i.type == .pwdCheck {
                    flag = true
                }
            }
        }
        if flag {
            WebEXModuleInitAction.showToastAction?(IIWebEXInter().iiwebex_pwdCharError)
            return
        }
        if self.pwdVw.text!.length >= 6 && self.pwdVw.text!.length <= 10 {
            self.navigationController?.popViewController(animated: true)
            editEndAction!(self.pwdVw.text!)
        } else {
            WebEXModuleInitAction.showToastAction?(IIWebEXInter().iiwebex_pwderrorInfo)
        }
    }
    
    func createVw() {
        self.view.addSubview(pwdVw)
        pwdVw.text = realPwd
        pwdVw.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(APPUIConfig.naviHeight + 20)
            make.height.equalTo(45)
        }
        pwdVw.layer.borderColor = APPUIConfig.lineLightGray.cgColor
        pwdVw.layer.borderWidth = 1
        pwdVw.isSecureTextEntry = true
        pwdVw.clearButtonMode = .whileEditing
        pwdVw.font = APPUIConfig.uiFont(with: 14)
        pwdVw.setValue(16, forKey: "paddingLeft")
        //rightvw
        let rightContentVw = UIView()
        rightContentVw.frame.size = CGSize(width: 50, height: 45)
        rightVw.frame.size = CGSize(width: 25, height: 25)
        rightVw.setImage(UIImage(named: "eye_close_"), for: UIControl.State.normal)
        rightVw.setImage(UIImage(named: "eye_open_"), for: UIControl.State.selected)
        rightVw.tapActionsGesture {[weak self] in
            self?.selectBtn()
        }
        rightVw.frame.origin = CGPoint(x: 10, y: 10)
        rightContentVw.addSubview(rightVw)
        pwdVw.rightView = rightContentVw
        pwdVw.rightViewMode = .always
        //底部說明框
        self.view.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(pwdVw.snp.bottom).offset(10)
            make.height.equalTo(17)
        }
        titleLb.text = subTitle
        titleLb.font = APPUIConfig.uiFont(with: 14)
        titleLb.textColor = UIColor.gray
    }
    
    func selectBtn() {
        if rightVw.isSelected {
            rightVw.isSelected = false
            pwdVw.isSecureTextEntry = true
        } else {
            rightVw.isSelected = true
            pwdVw.isSecureTextEntry = false
        }
    }
    
    func createRx() {
        _ = self.pwdVw.rx.text.orEmpty.subscribe { (event) in
            if event.element == nil { return }
            if event.element!.length >= 10 {
                self.pwdVw.text = event.element?.substringToIndex(9)
            }
        }
    }
    
    deinit {
        print("iiwebex pwd vc deinit...")
    }

}
