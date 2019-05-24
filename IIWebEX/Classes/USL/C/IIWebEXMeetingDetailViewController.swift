//
//  JoinViewController.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/10.
//  Copyright © 2018 Elliot. All rights reserved.
//

import UIKit

/// 会议详情页面-从列表点进来
class WEBEXMeetingDetailViewController: BaseViewController, MoreTableProtocol {

    /// 标题
    var titleTxt: String = IIWebEXInter().iiwebex_meetDetailInfo
    
    var topVw: MeetDetailTopVw?
    
    var contentVw: MeetDetailContentVw?
    
    public var meetModel: IIWebEXVModel?
    
    var webBll = WebEXBLL()
    
    let uti = IIWebEX()
    
    /// 创建成功之后，返回上一级页面需要刷新页面
    var delSuccessBackAction: (() -> Void)?
    
    var alertListVw: MoreTableView?
    
    var each10SecTimer: Timer?

    /// 参会人员
    let attendeesTxt = IIWebEXInter().iiwebex_attendees

    /// 分享
    let shareTxt = IIWebEXInter().app_share_txt

    /// 删除
    let deleteTxt = IIWebEXInter().app_delete_txt

    override func viewDidLoad() {
        super.viewDidLoad()
        createInitVC()
        initVw()
        setData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        each10SecTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.each10SecReloadData), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.each10SecTimer?.invalidate()
        self.each10SecTimer = nil
    }
    
    /// 每10S搞一次狀態
    @objc func each10SecReloadData() {
        self.initData(alert: false)
    }

    func createInitVC() {
        self.view.backgroundColor = UIColor.white
        self.title = titleTxt
        self.addNavLeftButtonNormalImage(UIImage(named: "back_before"), navLeftButtonSelectedImage: UIImage(named: "back_after"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "meet_Detail_"), landscapeImagePhone: UIImage(named: "meet_Detail_"), style: UIBarButtonItem.Style.done, target: self, action: #selector(self.addAlertListVw))
    }
    
    @objc func addAlertListVw() {
        if alertListVw != nil {
            alertListVw?.hidenSelf()
        } else {
            var nameDataSource: NSMutableArray = NSMutableArray()
            var imgSource: NSMutableArray = NSMutableArray()
            guard let userEmail = self.meetModel?.createPerson else { return }
            guard let impEmail = WebEXModuleInitAction.impUserModel?.value(forKey: "email") as? String else { return }
            if userEmail == impEmail {
                nameDataSource = [attendeesTxt, shareTxt, deleteTxt]
                imgSource = ["webex_attendees", "webex_shareIcon", "webex_deleteItem"]
            } else {
                nameDataSource = [attendeesTxt, shareTxt]
                imgSource = ["webex_attendees", "webex_shareIcon"]
            }
            alertListVw = MoreTableView(frame: CGRect.zero, dataList: nameDataSource, imageList: imgSource)
            alertListVw?.frame.origin = CGPoint(x: APPUIConfig.aWeight - 150, y: APPUIConfig.naviHeight)
            self.view.addSubview(alertListVw!)
            alertListVw?.del = self
        }
        alertListVw?.showSelf()
    }

    func initVw() {
        self.view.backgroundColor = APPUIConfig.bgLightGray
        topVw = MeetDetailTopVw(frame: CGRect.zero, fatherVw: self.view)
        contentVw = MeetDetailContentVw(frame: CGRect.zero, fatherVw: self.view, topVw: topVw!)
    }
    
    func setData() {
        guard let models = meetModel else { return }
        self.topVw?.setData(model: models)
        self.contentVw?.setData(model: models)
        ProgressHUD.shareInstance()?.showProgress(withMessage: "")
        initData(alert: true)
    }
    
    /// 初始化數據調用 & 10S調用一次
    func initData(alert: Bool) {
        guard let models = meetModel else {
            ProgressHUD.shareInstance()?.remove()
            return
        }
        webBll.progressOneMeetInfo(alert: alert, id: models.meetNo) { [weak self](model) in
            let newmodel = IIWebEXVModel()
            newmodel.progressModel2VModel(model: model)
            self?.meetModel = newmodel
            self?.contentVw?.setData(model: newmodel)
            self?.topVw?.setData(model: newmodel)
            ProgressHUD.shareInstance()?.remove()
        }
    }
    
    ///加入会议
    func joinMeeting() {
        ProgressHUD.shareInstance()?.showProgress(withMessage: "")
        self.webBll.getSK { [weak self](model) in
            self?.uti.progressURL(userid: self?.meetModel?.createPerson, mpw: self?.meetModel?.meetPwd, meetid: self?.meetModel?.meetNo, sk: model.tk)
            guard let boolValue = self?.meetModel?.hostKeyTuple.shouldShow else { return }
            if boolValue {
                self?.uti.startMeeting()
            } else {
                self?.uti.joinMeeting()
            }
            
        }
    }
    
    /// 删除记录
    @objc func deleteOneItem() {
        let alertAction = UIAlertController(title: IIWebEXInter().iiwebex_deltip, message: IIWebEXInter().iiwebex_deltil, preferredStyle: UIAlertController.Style.alert)
        let confirm = UIAlertAction(title: IIWebEXInter().iiwebex_delfir, style: UIAlertAction.Style.default) { [weak self](_) in
            self?.realDelAction()
        }
        let cancel = UIAlertAction(title: IIWebEXInter().iiwebex_delcal, style: UIAlertAction.Style.cancel) { (_) in }
        alertAction.addAction(confirm)
        alertAction.addAction(cancel)
        self.present(alertAction, animated: true, completion: nil)
    }

    /// 分享
    @objc func share() {
        webBll.share(iimodel: meetModel) { (con) in
            self.navigationController?.pushViewController(con, animated: true)
        }
    }

    /// 参会人页面跳转
    @objc func attendeesVCJump() {
        let con = IIWebEXAttendeesListViewController()
        con.vm.initData(source: self.meetModel?.attendees ?? [])
        self.navigationController?.pushViewController(con, animated: true)
    }
    
    /// 代理回调函数
    func progress(index: Int) {
        switch index {
        case 0:
            attendeesVCJump()
        case 1:
            share()
        case 2:
            deleteOneItem()
        default:
            break
        }
    }
    
    /// 删除操作代码
    func realDelAction() {
        guard let realModelID = self.meetModel?.meetNo else { return }
        ProgressHUD.shareInstance()?.showProgress(withMessage: "")
        self.webBll.removeOntItem(with: realModelID) {[weak self] in
            ProgressHUD.shareInstance()?.remove()
            if self?.delSuccessBackAction != nil && self != nil {
                self!.delSuccessBackAction!()
            }
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    /// 复制到粘贴
    func getPasterStr() {
        let pas = UIPasteboard.general
        pas.string = webBll.getPastStr(iimodel: self.meetModel)
        WebEXModuleInitAction.showToastAction?(IIWebEXInter().iiwebex_setPasteInfo)
    }
    
    deinit {
        print("iiwebex detail vc deinit...")
    }

}
