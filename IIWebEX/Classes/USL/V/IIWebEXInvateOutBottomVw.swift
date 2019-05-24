//
//  IIWebEXInvateOutBottomVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/16.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class IIWebEXInvateOutBottomVw: UIView {
    var fatherVw: UIView?
    
    var top: UIView?
    
    var txtFd: UITextField = UITextField()
    
    let holderTxt = IIWebEXInter().iiwebex_addAttenderEmail
    
    var isEmail: Bool = false
    
    let btn = UIButton()
    
    // 选人数值说明
    let botEmail: UILabel = UILabel()
    
    //var selectedPersonAction:()
    
    init(frame: CGRect, fatherVw: UIView, topVw: UIView) {
        super.init(frame: frame)
        self.fatherVw = fatherVw
        self.top = topVw
        createVw()
        createRx()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error...")
    }
    
    func remakeVw() {
        self.snp.remakeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(self.top!.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
    }
    
    func createVw() {
        self.backgroundColor = UIColor.white
        self.fatherVw?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(self.top!.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
        self.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.width.equalTo(60)
            make.height.equalTo(28)
            make.centerY.equalTo(self.snp.centerY)
        }
        btn.setTitle(IIWebEXInter().iiwebex_addOuterPersonAdd, for: UIControl.State.normal)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = APPUIConfig.cloudThemeColor
        btn.layer.cornerRadius = 14
        btn.titleLabel?.font = APPUIConfig.uiFont(with: 15)
        btn.layer.masksToBounds = true
        btn.tapActionsGesture {[weak self] in
            self?.addOneItem()
        }
        self.addSubview(txtFd)
        txtFd.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(btn.snp.left).offset(-5)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(25)
        }
        txtFd.placeholder = holderTxt
        txtFd.font = APPUIConfig.uiFont(with: 15)
        txtFd.clearButtonMode = .whileEditing
        //
        self.addSubview(botEmail)
        botEmail.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(self.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        botEmail.text = (self.iiViewController() as? IIWebEXInviteOutPersonViewController)?.mainVm.subtitleTxt
        botEmail.textColor = UIColor.gray
        botEmail.font = APPUIConfig.uiFont(with: 14)
    }
    
    func fatherVc() -> IIWebEXInviteOutPersonViewController? {
        if let con = self.iiViewController() as? IIWebEXInviteOutPersonViewController {
            return con
        }
        return nil
    }
    
    ///
    func createRx() {
        _ = self.txtFd.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe { [weak self](events) in
                if self?.fatherVc() == nil || events.element == nil { return }
                if self!.fatherVc()!.mainVm.regexProgressEmail(str: events.element!).count == 1 {
                    //是邮箱
                    self!.isEmail = true
                } else {
                    //不是
                    self?.isEmail = false
                    if events.element?.length == 0 { return }
                }
            }
        
    }
    
    func addOneItem() {
        if self.isEmail || self.txtFd.text == nil {
            let model = InvateVModel(showName: self.txtFd.text!, email: self.txtFd.text!, imgUrl: "")
            guard let vc = self.fatherVc() else { return }
            vc.mainVm.addInvateSubDatasource(model: model)
            self.txtFd.text = ""
        } else {
            //不是邮箱
            WebEXModuleInitAction.showToastAction?(IIWebEXInter().iiwebex_emailError)
        }
        self.isEmail = false
    }
}
