//
// 
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// EventCollector.swift
//
// Created by    Noah Shan on 2018/3/13
// InspurEmail   shanwzh@inspur.com
// GithubAddress https://github.com/hatjs880328s
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// For the full copyright and license information, plz view the LICENSE(open source)
// File that was distributed with this source code.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
//

import Foundation

/*
    super class - events
 
*/

public class GodfatherEvent: NSObject {
    
    var triggerDate: String = ""
    
    var sourceName: String = ""
    
    var parametersJoinedCharacter: String = "|"
    
    var dateFormatStr: String = "yyyy-MM-dd HH:mm:ss"

    var userID: String = MMAPUserInfo.userID//IMPUserModel.activeInstance()?.exeofidString() ?? ""

    var userName: String = MMAPUserInfo.userName//IMPUserModel.activeInstance()?.userName() ?? ""

    var enterpriseID: Int32 = MMAPUserInfo.enterpriseID//IMPUserModel.activeInstance()?.enterprise?.id ?? 0

    var deviceType: String = MMAPUserInfo.deviceType//Utilities.getDeviceModel() ?? ""

    var osVersion: String = MMAPUserInfo.osVersion//Utilities.getDeviceiOSVersion() ?? ""

    var appVersion: String = MMAPUserInfo.appVersion//Utilities.getAPPCurrentVersion() ?? ""
    
    /// SET INFO
    ///
    /// - Parameters:
    ///   - eventSourceName: uicontrol name eg： BASEViewController\SmallBtn<uibutton>
    ///   - time: event trigger date
    open func setBaseInfo(eventSourceName: String, time: Date) {
        self.triggerDate = Date().dateToString(dateFormatStr)
        self.sourceName = eventSourceName
    }
    
    static func == (lhs: GodfatherEvent, ses: GodfatherEvent) -> Bool {
        return lhs.triggerDate == ses.triggerDate && lhs.sourceName == ses.sourceName
    }

    var superDescription: String {
        return parametersJoinedCharacter + userID + parametersJoinedCharacter + userName + parametersJoinedCharacter +
            enterpriseID.description
            + parametersJoinedCharacter + deviceType +
            parametersJoinedCharacter + osVersion + parametersJoinedCharacter + appVersion
    }
    
    deinit {
        //DEBUGPrintLog("aopevent - dealloc")
    }
}

/// viewcontroller-aop-acitons
class VCEvent: GodfatherEvent {
    
    var vceventType: VCEventType!
    
    open func setBaseInfo(eventSourceName: String, time: Date, type: VCEventType) {
        super.setBaseInfo(eventSourceName: eventSourceName, time: time)
        self.vceventType = type
    }
    
    override var description: String {
        return "E|" + sourceName + parametersJoinedCharacter + triggerDate.description +
            parametersJoinedCharacter + vceventType.rawValue + superDescription +
        "\n"
    }
}

/// tableview-aop-actions
class TBEvent: GodfatherEvent {
    
    var indexpath: IndexPath!
    
    open func setBaseInfo(eventSourceName: String, time: Date, index: IndexPath) {
        super.setBaseInfo(eventSourceName: eventSourceName, time: time)
        self.indexpath = index
    }
    
    override var description: String {
        return "E|" + sourceName + parametersJoinedCharacter + triggerDate.description +
            parametersJoinedCharacter + "(section:\(indexpath.section) row:\(indexpath.row))" + superDescription +
        "\n"
    }
}

/// uiapplication（uicontrol）-aop-sendActions
class SendActionEvent: GodfatherEvent {
    
    var controlType: IIAOPControlEventType!
    
    open func setBaseInfo(eventSourceName: String, time: Date, type: IIAOPControlEventType) {
        super.setBaseInfo(eventSourceName: eventSourceName, time: time)
        self.controlType = type
    }
    
    override var description: String {
        return "E|" + sourceName + parametersJoinedCharacter + triggerDate.description +
            parametersJoinedCharacter + controlType.rawValue + superDescription +
        "\n"
    }
}

/// api-event - opp-sendAction
public class APIEvent: GodfatherEvent {

    var requestType: Int = 0

    open func setBaseInfo(apiName: String, time: Date, requestType: Int) {
        super.setBaseInfo(eventSourceName: apiName, time: time)
        self.requestType = requestType
    }

    override public var description: String {
        return "A|" + sourceName + parametersJoinedCharacter + triggerDate.description +
            parametersJoinedCharacter + "\(requestType)" + superDescription +
        "\n"
    }
}

/// webview-loadDatatime - aop-sendAction
public class WebVWEvent: GodfatherEvent {

    var milSecs: Int = 0

    open func setBaseInfo(apiName: String, time: Date, milSecs: Int) {
        super.setBaseInfo(eventSourceName: apiName, time: time)
        self.milSecs = milSecs
    }

    override public var description: String {
        return "W|" + sourceName + parametersJoinedCharacter + triggerDate.description +
            parametersJoinedCharacter + "\(milSecs)" + superDescription +
        "\n"
    }
}

/// WCDB-warning & error - opp-sendAction
@objc public class WCDBEvent: GodfatherEvent {
    @objc open func setBaseInfo(errorInfo: String) {
        super.setBaseInfo(eventSourceName: errorInfo, time: Date())
        self.sourceName = errorInfo
    }

    override public var description: String {
        return "WCDB|" + sourceName + parametersJoinedCharacter + triggerDate.description +
            parametersJoinedCharacter + superDescription +
"\n"
    }
}

/// CustomInfo & opp-sendAction
@objc public class CustomEvent: GodfatherEvent {
    @objc open func setBaseInfo(info: String) {
        super.setBaseInfo(eventSourceName: info, time: Date())
        self.sourceName = info
    }

    override public var description: String {
        return "C|" + sourceName + parametersJoinedCharacter + triggerDate.description +
            parametersJoinedCharacter + superDescription +
        "\n"
    }
}
