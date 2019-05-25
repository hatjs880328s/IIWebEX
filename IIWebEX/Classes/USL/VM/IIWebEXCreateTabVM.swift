//
//  CreateTabVM.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class CreateTabVM: NSObject {
    
    var personInvateVm: IIWEBEXInviteVM = IIWEBEXInviteVM()
    
    var reloadAction: (() -> Void)?
    
    var tabDataSource: [[[String: String]]] = [[[:]]] {
        didSet {
            if reloadAction == nil { return }
            reloadAction!()
        }
    }
    
    var infoAction: ((_ startTime: String?, _ duration: String?) -> Void)?
    
    /// 邀请者修改action
    var invatorsChangeAction: ((_ str: String) -> Void)?
    
    /// 创建会议成功事件
    var creatingOverBackAction:(() -> Void)?
    
    var models: IIWebEXModel = IIWebEXModel().createMeetInitSelf()
    
    var bll = WebEXBLL()
    
    override init() {
        super.init()
    }
    
    /// init data
    public func initData() {
        
        var innerData: [[[String: String]]] = []
        
        let personName = WebEXModuleInitAction.getIMPUserName?() ?? ""//IMPUserModel.activeInstance()?.userName() ?? ""

        let groupOne = [["\(personName)\(IIWebEXInter().iiwebex_whoseMeet)": ""]]
        innerData.append(groupOne)
        
        let groupTwo = [[IIWebEXInter().iiwebex_starttime: models.startDate!.dateToString("yyyy-MM-dd HH:mm")], [IIWebEXInter().iiwebex_durationtime: "1\(IIWebEXInter().iiwebex_hours)"]]
        innerData.append(groupTwo)
        
        let groupThree = [[IIWebEXInter().iiwebex_attendees: IIWebEXInter().iiwebex_none], [IIWebEXInter().iiwebex_pwd: IIWebEXInter().iiwebex_setting]]
        innerData.append(groupThree)
        
        self.tabDataSource = innerData
    }
    
    public func getNumberOfSectionCount() -> Int {
        return self.tabDataSource.count
    }
    
    public func getNumberOfRowCount(with index: Int) -> Int {
        return self.tabDataSource[index].count
    }
    
    /// cell get data
    public func getData(with index: IndexPath) ->
        (title: String,
        couldeEdid: Bool,
        subTitle: String,
        lineType: IIWebTabCellEnum,
        arrow: Bool) {
        
            let title = self.tabDataSource[index.section][index.row].keys.first!
            let subTitle = self.tabDataSource[index.section][index.row].values.first!
            var lineType = IIWebTabCellEnum.topNormalBottomShort
            var couldeEdid = false
            if index.section == 0 {
                couldeEdid = true
            }
            if index.section == 0 {
                lineType = IIWebTabCellEnum.topAndBottomHave
            } else {
                if index.row == 0 {
                    lineType = IIWebTabCellEnum.onlyTop
                } else {
                    lineType = IIWebTabCellEnum.bottomNormalTopShort
                }
            }
            var arrow = false
            if index.section == 2 {
                arrow = true
            }
            
            return (title, couldeEdid, subTitle, lineType, arrow)
    }
    
    /// row did selected
    func didRow(at index: IndexPath) -> UIViewController? {
        switch index {
        case let indexs where indexs.row == 0 && indexs.section == 1:
            let middleDate = WebEXModuleInitAction.getCurrentDateAfterHalfHour?() ?? Date()//Utilities.getCurrentDateAfterHalfHour()
            WebEXModuleInitAction.datepickerVw.initSelf(haveMinDate: true, each10MinsProgress: false, scrollDate: middleDate, type: 0) { (date) in
                if date == nil { return }
                self.models.startDate = date!
                self.modelChange(startTime: date!.dateToString("yyyy-MM-dd HH:mm"), duration: nil)
            }
            WebEXModuleInitAction.datepickerVw.show()
            return nil
        case let indexs where indexs.row == 1 && indexs.section == 1:
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            let scrollDate = dateFormater.date(from: "01:00")
            WebEXModuleInitAction.datepickerVw.initSelf(haveMinDate: false, each10MinsProgress: true, scrollDate: scrollDate, type: 5) { (date) in
                if date == nil { return }
                let hours = "\(date!.hours)\(IIWebEXInter().iiwebex_hours)"
                let mins = date!.minutes == 0 ? "" : "\(date!.minutes)\(IIWebEXInter().iiwebex_mins)"
                self.models.duration = date!.hours * 60 + date!.minutes
                self.modelChange(startTime: nil, duration: hours + mins)
            }
            WebEXModuleInitAction.datepickerVw.show()
            return nil
        case let indexs where indexs.row == 1 && indexs.section == 2 :
            let con = SetPwdViewController()
            con.realPwd = self.models.meetingPassword!
            con.editEndAction = { str in
                self.models.meetingPassword = str
            }
            return con
        case let indexs where indexs.row == 0 && indexs.section == 2 :
            let con = InvitePersonViewController()
            con.mainVm = personInvateVm
            con.editEndAction = { strArr in
                self.invatePersonBackAction(arr: strArr)
            }
            return con
        default:
            return nil
        }
    }
    
    /// 选人页面点击完成 & 选人页面返回
    func invatePersonBackAction(arr: [InvateVModel]) {
        self.models.attendees?.removeAll()
        self.models.attendees?.append(contentsOf: self.progressVModel2Emal(models: arr))
        self.changeInvators()
    }
    
    /// 开始时间 & 持续时间ui修改
    func modelChange(startTime: String? = nil, duration: String? = nil) {
        if self.infoAction == nil { return }
        if startTime != nil {
            self.infoAction!(startTime!, nil)
        }
        if duration != nil {
            self.infoAction!(nil, duration!)
        }
    }
    
    /// 邀请人变更
    func changeInvators() {
        if self.models.attendees == nil || self.invatorsChangeAction == nil || self.models.attendees!.count == 0 { return }
        self.invatorsChangeAction!("\(self.models.attendees!.count)\(IIWebEXInter().iiwebex_person)")
    }
    
    /// 创建会议
    func createMeeting() {
        if self.models.confName == "" {
            WebEXModuleInitAction.showToastAction?(IIWebEXInter().iiwebex_meettitleAlert)
            return
        }
        ProgressHUD.shareInstance()?.showProgress(withMessage: "")
        self.bll.createMeeting(with: self.models) { [weak self] in
            ProgressHUD.shareInstance()?.remove()
            if self == nil || self?.creatingOverBackAction == nil { return }
            self!.creatingOverBackAction!()
        }
    }
    
    /// 将对象转为  email数组
    func progressVModel2Emal(models: [InvateVModel]) -> [AttendeesModel] {
        var result = [AttendeesModel]()
        for i in models {
            result.append(AttendeesModel(with: i))
        }
        return result
    }
}
