//
//  InvitePersonViewController.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

/// 邀请人控制器
class InvitePersonViewController: BaseViewController, UITextFieldDelegate {

    let naviRightTxt = IIWebEXInter().iiwebex_completed
    
    let titleTxt = IIWebEXInter().iiwebex_addAttendees
    
    var editEndAction: ((_ pwd: [InvateVModel]) -> Void)?
    
    /// 入参【此vm有创建页面持有】
    var mainVm: IIWEBEXInviteVM!
    
    var tab: IIWebEXInvateTabVw?
    
    var bot: IIWebEXInvateBottomVw?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = APPUIConfig.bgLightGray
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = titleTxt
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: naviRightTxt, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goCreatingMt))
        self.addNavLeftButtonNormalImage(UIImage(named: "back_before"), navLeftButtonSelectedImage: UIImage(named: "back_after"))
        createVw()
        createVm()
    }
    
    /// 重写返回按钮事件
    override func backButtonClicked(_ sender: Any!) {
        //需要处理人数
        (IIAppExtension().getFatherVc(selfVc: self) as? CreateMeetingViewController)?.mainVm.invatePersonBackAction(arr: self.mainVm.invateMainDatasource)
        super.backButtonClicked(sender)
    }
    
    @objc func goCreatingMt() {
        if editEndAction == nil { return }
        editEndAction!(self.mainVm.invateMainDatasource)
        self.navigationController?.popViewController(animated: true)
    }
    
    func createVw() {
        tab = IIWebEXInvateTabVw(frame: CGRect.zero, fatherVw: self.view, itemCount: self.mainVm.invateMainDatasource.count)
        bot = IIWebEXInvateBottomVw(frame: CGRect.zero, fatherVw: self.view, topVw: tab!)
    }
    
    func createVm() {
        self.mainVm.invateMainAction = {[weak self] in
            self?.tab?.tab.reloadData()
            self?.tab?.remakeVw()
            self?.bot?.remake()
        }
        self.mainVm.countChangeAction = { [weak self] str in
            self?.bot?.titleLb.text = str
            
        }
    }
    
    /// 跳转到外部参会人页面
    func jumpSubVc() {
        let con = IIWebEXInviteOutPersonViewController()
        con.mainVm = self.mainVm
        self.navigationController?.pushViewController(con, animated: true)
    }
    
    deinit {
        print("iiwebex invateperson vc deinit...")
    }

}
