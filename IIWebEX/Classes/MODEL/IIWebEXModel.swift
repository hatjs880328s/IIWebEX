//
//  IIWebEXModel.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation
import HandyJSON
@_exported import SnapKit
@_exported import IISwiftBaseUti
@_exported import IIUIAndBizConfig
@_exported import IIBLL
@_exported import IIComponents
@_exported import IIAOPNBP
@_exported import IIHTTPRequest
@_exported import IIOCUtis
@_exported import IIBaseComponents

/// 添加單條手動輸入的聯系人提示信息
@objc enum SinglePersonAdd: Int {
    case moreThan20
    case isExist
    case normal
}

/// 邀请人vmodel
class InvateVModel: Equatable {
    
    var showName: String = ""
    var email: String = ""
    var imgUrl: String = ""
    init(showName: String, email: String, imgUrl: String) {
        self.imgUrl = imgUrl
        self.showName = showName
        self.email = email
    }
    
    static func == (lhs: InvateVModel, rhs: InvateVModel) -> Bool {
        return lhs.email == rhs.email
    }
}

/// 参会人model
class AttendeesModel: HandyJSON {
    /// 邮箱
    var email: String?

    /// 用户类型 0 - 外部 1 - 内部
    var personType: Int?

    /// 类型： visitor & hoster
    var type: String?

    public required init() {}

    /// 选择联系人转为参会人model时，只需要处理邮箱
    init(with model: InvateVModel) {
        self.email = model.email
        //self.personType = (model.showName == model.email ? 0 : 1)
        //self.type = "VISITOR"
    }
}

/// cell顶部和底部线条种类枚举
@objc enum IIWebTabCellEnum: Int {
    /// 都正常
    case topAndBottomHave
    /// 只有顶部有
    case onlyTop
    /// 只有底部有
    case onlyBottom
    /// 顶部正常-底部短
    case topNormalBottomShort
    /// 底部正常-顶部短
    case bottomNormalTopShort
}

/// sk-Model
class IIWebEXSKModel: HandyJSON {
    
    var tk: String?
    
    public required init() {}
}

class IIWebEXModel: HandyJSON {
    /// 开始时间
    var startDate: Date?
    /// 分钟为单位
    var duration: Int?
    /// 参会人员
    var attendees: [AttendeesModel]?
    /// 密码
    var meetingPassword: String?
    /// 会议标题
    var confName: String?
    /// 会议状态[local]
    var meetState: String?
    /// 会议ID
    var meetingID: String?
    /// 议事日程
    var agenda: String?
    /// 主持人id
    var hostWebExID: String?
    /// 主持人名称
    var hostUserName: String?
    /// 主持人密钥
    var hostKey: String?
    /// 會議狀態
    var inProgress: Bool?
    
    public required init() {}
    
    /// init data
    public func createMeetInitSelf() -> IIWebEXModel {
        self.startDate = WebEXModuleInitAction.getCurrentDateAfterHalfHour?()//Utilities.getCurrentDateAfterHalfHour()
        self.duration = 60
        self.attendees = []
        self.meetingID = ""
        self.meetingPassword = String.randomStr(len: 6)
        let personName = WebEXModuleInitAction.getIMPUserName?() ?? ""//IMPUserModel.activeInstance()?.userName() ?? ""
        self.confName = "\(personName)\(IIWebEXInter().iiwebex_whoseMeet)"
        self.agenda = ""
        self.meetState = ""
        return self
    }
    
    /// 时间格式需要与S端返回的对应起来
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            startDate <-- CustomDateFormatTransform(formatString: "yyyy/MM/dd HH:mm:ss")
    }
}
