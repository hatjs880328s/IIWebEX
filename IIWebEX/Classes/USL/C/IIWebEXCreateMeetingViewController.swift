//
//  CreateMeetingViewController.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import UIKit

/// webex creating meeting vc
class CreateMeetingViewController: BaseViewController {

    let naviRightTxt = IIWebEXInter().iiwebex_createSave
    
    let titleTxt = IIWebEXInter().iiwebex_arrange
    
    let mainVm = CreateTabVM()
    
    let mainVw = CreateMtTabVw()
    
    /// 创建成功之后，返回上一级页面需要刷新页面
    var createSuccessBackAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        initVw()
        createVw()
        initVM()
    }

    func initVw() {
        self.title = titleTxt
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: naviRightTxt, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goCreatingMt))
        self.addNavLeftButtonNormalImage(UIImage(named: "back_before"), navLeftButtonSelectedImage: UIImage(named: "back_after"))
    }

    /// tab-create
    func createVw() {
        self.view.addSubview(mainVw)
        self.mainVw.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    func initVM() {
        self.mainVm.reloadAction = { [weak self] in
            self?.mainVw.mainTab.reloadData()
        }
        self.mainVm.infoAction = { [weak self](startTime, duration) in
            self?.mainVw.setStartTimeAndDuration(startTime: startTime, duration: duration)
        }
        self.mainVm.invatorsChangeAction = { [weak self] str in
            self?.mainVw.setInvatorStr(str: str)
        }
        self.mainVm.creatingOverBackAction = { [weak self] in
            if self?.createSuccessBackAction != nil {
                self?.createSuccessBackAction!()
            }
            self?.navigationController?.popViewController(animated: true)
        }
        self.mainVm.initData()
    }

    @objc func goCreatingMt() {
        self.mainVm.createMeeting()
    }
    
    deinit {
        print("iiwebex create vc deinit...")
    }
}
