//
//  WebEXDAL.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/12.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class WebEXDAL: NSObject {
    
    override init() {
        super.init()
    }
    
    /// 获取列表信息
    func getMeetList(alertInfo: Bool, success:@escaping (_ arr: NSArray) -> Void, failAction: @escaping () -> Void) {
        IIHTTPRequest.startRequest(showAlertInfo: alertInfo, method: IIHTTPMethod.get, url: WebEXModuleInitAction.webEXAPI, params: nil, header: WebEXModuleInitAction.webEXAPIHeader, timeOut: 30, successAction: { (responseArr) in
            if let arrInfo = responseArr.arrValue {
                success(arrInfo)
            } else {
                failAction()
            }
        }) { (_) in
            failAction()
        }
    }
    
    /// 获取某条信息 & 密码
    func getMeetBy(alertInfo: Bool, id: String, success:@escaping (_ arr: NSDictionary) -> Void, failAction: @escaping () -> Void) {
        let realID = id.replace(find: " ", replaceStr: "")
        IIHTTPRequest.startRequest(showAlertInfo: alertInfo, method: IIHTTPMethod.get, url: WebEXModuleInitAction.webEXOneItemAPI + "/\(realID)", params: nil, header: WebEXModuleInitAction.webEXAPIHeader, timeOut: 30, successAction: { (responseArr) in
            if let arrInfo = responseArr.dicValue {
                success(arrInfo)
            } else {
                failAction()
            }
        }) { (_) in
            failAction()
        }
    }
    
    /// 创建一个会议 * 安排一个会议
    func createMeeting(params: [String: Any], success:@escaping () -> Void, failAction: @escaping () -> Void) {
        IIHTTPRequest.startRequest(method: IIHTTPMethod.post, url: WebEXModuleInitAction.webEXAPICreate, params: params, header: WebEXModuleInitAction.webEXAPIHeader, timeOut: 30, successAction: { (response) in
            if let boolValue = response.anyValue as? Bool {
                if boolValue {
                    success()
                } else {
                    failAction()
                }
            } else {
                failAction()
            }
        }) { (_) in
            //toast 创建失败
            failAction()
        }
    }
    
    /// 获取session-ticket
    func getSK(success:@escaping (_ dic: NSDictionary) -> Void, failAction: @escaping () -> Void) {
        IIHTTPRequest.startRequest(method: IIHTTPMethod.get, url: WebEXModuleInitAction.webEXSKAPI, params: nil, header: WebEXModuleInitAction.webEXAPIHeader, timeOut: 30, successAction: { (response) in
            if let dic = response.dicValue {
                success(dic)
            } else {
                failAction()
            }
        }) { (_) in
            failAction()
        }
    }
    
    /// 删除某条记录
    func removeOneItem(with id: String, success:@escaping () -> Void, failAction: @escaping () -> Void) {
        let realID = id.replace(find: " ", replaceStr: "")
        IIHTTPRequest.startRequest(method: IIHTTPMethod.get, url: WebEXModuleInitAction.webEXRemoveAPI  + "/\(realID)", params: nil, header: WebEXModuleInitAction.webEXAPIHeader, timeOut: 30, successAction: { (response) in
            if let boolValue = response.anyValue as? Bool {
                if boolValue {
                    success()
                } else {
                    failAction()
                }
            } else {
                failAction()
            }
        }) { (_) in
            failAction()
        }
    }
}
