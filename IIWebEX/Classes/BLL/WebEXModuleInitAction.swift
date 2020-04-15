//
//  *******************************************
//  
//  WebEXINITModule.swift
//  IIWebEX
//
//  Created by Noah_Shan on 2019/5/24.
//  Copyright © 2018 Inpur. All rights reserved.
//  
//  *******************************************
//

import UIKit

/// 入参
public class WebEXModuleInitAction: NSObject {

    /// IIAPIStruct().webEXAPI 获取列表信息
    @objc static var webEXAPI: String {
        return webEXAPIAction?() ?? ""
    }

    @objc public static var webEXAPIAction: ( () -> String )?

    /// IIAPIStruct().webEXAPIHeader 获取api默认header
    @objc static var webEXAPIHeader: [String: String] {
        return webEXAPIHeaderAction?() ?? [: ]
    }

    @objc public static var webEXAPIHeaderAction: ( () -> [String: String] )?

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

    /// datepicker进行初始化
    public static var datepickerVw: IIDatePickerIBLL!

    /// 服务自注册
    @objc public func registerService() {
        BeeHive.shareInstance()?.registerService(WebEXIBLL.self, service: WebEXModule.self)
    }

}
