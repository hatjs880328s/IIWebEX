//
//  IIWebEXVModel.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/13.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

/// 参会人列表vmodel
class IIWebEXAttendeesListVModel: NSObject {
    var name: String = ""
    var email: String = ""
    var userType: String = ""
    var isHost: String = ""
    var imgUrl: String = ""

    init(with model: AttendeesModel) {
        self.email = (model.email ?? "")
        self.userType = model.personType == 0 ? IIWebEXInter().iiwebex_outerPerson : IIWebEXInter().iiwebex_innerPerson
        self.isHost = model.type ?? ""
        self.imgUrl = "https://emm.inspur.com/img/userhead/" + (model.email ?? "")
    }
}

/// 会议vmodel
class IIWebEXVModel: NSObject {
    
    ///开始时间date
    var realTime: Date = Date()
    
    ///持续时间分钟数值
    var duration: Int = 0
    
    ///列表显示时间
    var time: String = ""
    
    ///详情显示时间
    var contentTime: String = ""
    
    ///详情显示时间第二部分
    var contentTimeSecondPart: String = ""
    
    ///持续时间显示
    var showDuration: String = ""
    
    /// 列表中section头时间
    var listSectionTime: (String, String) = ("", "")
    
    ///标题
    var title: String = ""
    
    ///会议号
    var meetNo: String = ""
    
    ///会议密码
    var meetPwd: String = ""
    
    ///创建人id
    var createPerson: String = ""
    
    ///主持人名字
    var createPersonName: String = ""
    
    ///主持人keyinfo
    var hostKey: String = ""
    
    var inProgress: Bool = false

    var attendees: [IIWebEXAttendeesListVModel] = []
    
    ///主持人密鑰
    var hostKeyTuple: (shouldShow: Bool, keyInfo: String) {
        var infoText: String = ""
        var shouldShow: Bool = false
        if let emailInfo = WebEXModuleInitAction.impUserModel?.value(forKey: "email") as? String {
            shouldShow = emailInfo == createPerson ? true : false
            infoText = self.hostKey
        }
        return (shouldShow, infoText)
    }
    
    ///[詳情]已开始 ： 尚未开始
    var meetState: (isStart: Bool, startBtnTxt: String) {
        var result: Bool = realTime.addMinutes(duration).distance(to: Date()) < 0 ? true : false
        var infoText: String = ""
        if let emailInfo = WebEXModuleInitAction.impUserModel?.value(forKey: "email") as? String {
            //infoText = emailInfo == createPerson ? IIWebEXInter().iiwebex_startjoin : IIWebEXInter().iiwebex_joinstart
            if emailInfo == createPerson {
                infoText = IIWebEXInter().iiwebex_startjoin
            } else {
                infoText = IIWebEXInter().iiwebex_joinstart
                if !self.inProgress { result = false }
            }
        }
        return (result, infoText)
    }
    
    ///[列表]已開始:未開始按鈕 , 需要判定是否是今天的
    var listMeetState: (isStart: Bool, startBtnTxt: String) {
        var result: Bool = false
        if realTime.days == Date().days && realTime.month == Date().month && realTime.year == Date().year {
            result = true
        } else {
            result = false
        }
        let resultTime = realTime.addMinutes(duration).distance(to: Date()) < 0 ? true : false
        result = result && resultTime
        var infoText: String = ""
        if let emailInfo = WebEXModuleInitAction.impUserModel?.value(forKey: "email") as? String {
            //infoText = emailInfo == createPerson ? IIWebEXInter().iiwebex_startjoin : IIWebEXInter().iiwebex_joinstart
            if emailInfo == createPerson {
                infoText = IIWebEXInter().iiwebex_startjoin
            } else {
                infoText = IIWebEXInter().iiwebex_joinstart
                if !self.inProgress { result = false }
            }
        }
        return (result, infoText)
    }
    
    ///头像地址
    var imgUrl: String = ""
    
    func progressModel2VModel(model: IIWebEXModel) {
        if model.startDate != nil && model.duration != nil {
            self.realTime = model.startDate!
            self.showDuration = (model.duration! / 60 > 0 ? "\(model.duration! / 60)\(IIWebEXInter().iiwebex_hours)" : "") + (model.duration! % 60 == 0 ? "" : "\(model.duration! % 60)\(IIWebEXInter().iiwebex_mins)")
            let startProgressMins = model.startDate!.minutes > 10 ? "\(model.startDate!.minutes)" : "0\(model.startDate!.minutes)"
            self.time = "\(model.startDate!.hours) : \(startProgressMins)"
            let disTime = model.startDate!.addMinutes(model.duration!)
            let progressMins = disTime.minutes > 10 ? "\(disTime.minutes)" : "0\(disTime.minutes)"
            self.time += " - \(disTime.hours) : \(progressMins)"
            
            let weekInfo = (IIWebEXInter().iiwebex_mins != "mins") ? "星期\(model.startDate!.week)" : model.startDate!.weekEn
            let yearTxt = (IIWebEXInter().iiwebex_mins != "mins") ? IIWebEXInter().iiwebex_years : "-"
            let monthTxt = (IIWebEXInter().iiwebex_mins != "mins") ? IIWebEXInter().iiwebex_months : "-"
            let dayTxt = (IIWebEXInter().iiwebex_mins != "mins") ? IIWebEXInter().iiwebex_days : ""
            self.contentTime = "\(model.startDate!.year)\(yearTxt)\(model.startDate!.month)\(monthTxt)\(model.startDate!.days)\(dayTxt) \(weekInfo) \(model.startDate!.hours):\(startProgressMins)"
            self.contentTimeSecondPart = "\(showDuration)"
            let listSectionTimeFirst = "\(weekInfo) \(model.startDate!.month)\(monthTxt)\(model.startDate!.days)\(dayTxt) "
            var listSectionTimeSecond = ""
            if model.startDate!.month == Date().month && model.startDate!.days == Date().days && model.startDate!.year == Date().year {
                listSectionTimeSecond = IIWebEXInter().iiwebex_today
            }
            self.listSectionTime = (listSectionTimeFirst, listSectionTimeSecond)
        }
        //参会人赋值
        if let attendee = model.attendees {
            var resultAtt = [IIWebEXAttendeesListVModel]()
            for i in attendee {
                resultAtt.append(IIWebEXAttendeesListVModel(with: i))
            }
            self.attendees = resultAtt
        }
        self.inProgress = model.inProgress ?? false
        self.title = model.confName ?? ""
        self.createPerson = model.hostWebExID ?? ""
        self.meetNo = progressMeetNo(str: model.meetingID ?? "")
        self.meetPwd = model.meetingPassword ?? ""
        self.duration = model.duration ?? 0
        self.createPersonName = model.hostUserName ?? ""
        self.hostKey = model.hostKey ?? ""
        imgUrl = (BeeHive.shareInstance()?.createService(IIsuprIBLL.self) as? IIsuprIBLL)?.getUserImgURL(createPerson) ?? ""
        guard let userEmail = model.hostWebExID else { return }
        guard let impEmail = WebEXModuleInitAction.impUserModel?.value(forKey: "email") as? String else { return }
        if userEmail == impEmail {
            self.createPersonName = IIWebEXInter().iiwebex_mineTxt
        }
    }
    
    /// 处理会议号，每3位+一个空格
    func progressMeetNo(str: String) -> String {
        var result = ""
        for eachItem in 0 ..< str.length {
            if eachItem == 2 || eachItem == 5 || eachItem == 8 {
                result += (str[eachItem] + " ")//"\(str[eachItem]) "
            } else {
                result += str[eachItem]
            }
        }
        
        return result
    }
}
