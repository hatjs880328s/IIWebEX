//
//  IIWebEXInviteOutPersonViewController.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/16.
//  Copyright © 2018 Elliot. All rights reserved.
//

import UIKit

class IIWebEXInviteOutPersonViewController: BaseViewController {

    var bot: IIWebEXInvateOutBottomVw?
    
    var tab: IIWebEXInvateTabVw?
    
    /// 入参
    var mainVm: IIWEBEXInviteVM!
    
    //表頭
    var conTitle = IIWebEXInter().iiwebex_addOuterPersonTitle
    
    //保存
    var completed = IIWebEXInter().iiwebex_createSave
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createVw()
        createVm()
    }
    
    func createVw() {
        self.view.backgroundColor = APPUIConfig.bgLightGray
        self.title = conTitle
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: completed, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goCreatingMt))
        self.addNavLeftButtonNormalImage(UIImage(named: "back_before"), navLeftButtonSelectedImage: UIImage(named: "back_after"))
        self.tab = IIWebEXInvateTabVw(frame: CGRect.zero, fatherVw: self.view, itemCount: self.mainVm.getAllOutPerson().count)
        self.bot = IIWebEXInvateOutBottomVw(frame: CGRect.zero, fatherVw: self.view, topVw: self.tab!)
    }
    
    /// 完成
    @objc func goCreatingMt() {
//        if !self.mainVm.addSubPersons2MainPage() {
//        }else{
//        }
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 重写返回事件
    override func backButtonClicked(_ sender: Any!) {
        self.goCreatingMt()
    }
    
    func createVm() {
        self.mainVm.invateSubAction = { [weak self] in
            self?.tab?.tab.reloadData()
            self?.tab?.remakeVw()
            self?.bot?.remakeVw()
        }
        self.mainVm.outPersonChangeAction = { [weak self] str in
            self?.bot?.botEmail.text = str
        }
    }

}
