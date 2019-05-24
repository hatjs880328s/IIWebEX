//
//  WebEXModule.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/13.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

/// 入参
public class WebEXModuleInitAction: NSObject {

    /// IIAPIStruct().webEXAPI 获取列表信息
    @objc static var webEXAPI: String {
        return webEXAPIAction?() ?? ""
    }

    @objc public static var webEXAPIAction: ( () -> String )?

    /// IIAPIStruct().webEXOneItemAPI 获取某条信息 & 密码
    @objc static var webEXOneItemAPI: String {
        return webEXOneItemAPIAction?() ?? ""
    }

    @objc public static var webEXOneItemAPIAction: ( () -> String )?

    /// IIAPIStruct().webEXAPICreate 创建一个会议 * 安排一个会议
    @objc static var webEXAPICreate: String {
        return webEXAPICreateAction?() ?? ""
    }

    @objc public static var webEXAPICreateAction: ( () -> String )?

    /// IIAPIStruct().webEXSKAPI 获取session-ticket
    @objc static var webEXSKAPI: String {
        return webEXSKAPIAction?() ?? ""
    }

    @objc public static var webEXSKAPIAction: ( () -> String )?

    /// IIAPIStruct().webEXRemoveAPI 删除某条记录
    @objc static var webEXRemoveAPI: String {
        return webEXRemoveAPIAction?() ?? ""
    }

    @objc public static var webEXRemoveAPIAction: ( () -> String )?

    /// impuserModel -> nsobject
    @objc public static var setIMPUserModel: (() -> NSObject)?

    @objc static var impUserModel: NSObject? {
        return setIMPUserModel?()
    }

    /// utilities toast
    @objc public static var showToastAction: ((_ str: String) -> Void)?

    /// utilities half date NSDate getCurrentDateAfterHalfHour
    @objc public static var getCurrentDateAfterHalfHour: (() -> Date)?

    /// IMPUserModel.activeInstance()?.userName() ?? ""
    @objc public static var getIMPUserName: (() -> String)?

}

class WebEXModule: NSObject, WebEXIBLL {
    
    func getDoorVC() -> UIViewController {
        let con = WEBEXMeetingListViewController()
        con.hidesBottomBarWhenPushed = true
        return con
    }
    
}
