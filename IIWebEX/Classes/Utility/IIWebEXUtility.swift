//
//  IIWebEXUtility.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/9.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class IIWebEXUtility: NSObject {

    let encoderPwdURL = "https://inspurcloud.webex.com.cn/inspurcloud/user.php"

    let ticketURL = "https://inspurcloud.webex.com.cn/inspurcloud/user.php"

    override init() {
        super.init()
        self.getEncoderPwd { (_) in

        }
        self.getEncoderTicket(withPwd: ".") { (_) in

        }
    }

    /// 创建会议urlStr创建
    ///
    /// - Parameters:
    ///   - meetingKey: mk
    ///   - userID: userid - webexid 需要使用urlencoder加密
    ///   - sessionTicket: sessionticket  需要使用urlencoder加密；验证你用户的 ticket ，可以通过 URL API，或者 XML API 获取
    /// - Returns: url
    func createCommonURL(meetingKey: String, userID: String, sessionTicket: String) -> String {
        let realUid = (userID as NSString).urlEncoded()!
        let realSessionTi = (sessionTicket as NSString).urlEncoded()!
        let urlStr = "wbx://inspurcloud.webex.com.cn/inspurcloud?MK=\(meetingKey)&UN=\(realUid)&SK=\(realSessionTi)"
        return urlStr
    }

    /// 异步获取加密的密码
    func getEncoderPwd(encoderPwd:@escaping (_ pwd: String) -> Void) {
        let params = ["AT": "GetAuthInfo",
                      "UN": "shanwzh@inspur.com",
                      "PW": "shan2308967",
                      "getEncryptedPwd": "true"] as [String: Any]
        let urls = URL(string: encoderPwdURL)!
        request(urls, method: HTTPMethod.post, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (data) in
            if data.result.isSuccess {

            } else {

            }
        }
    }

    /// 异步获取加密的ticket
    func getEncoderTicket(withPwd: String, encoderPwd:@escaping (_ ticket: String) -> Void) {
        let params = ["AT": "GetAuthInfo",
                      "UN": "shanwzh@inspur.com",
                      "EPW": "QUhFSwAAAAI55ACv3NzDXgborLml4IuVoeZKBENauLjkLbIm-Wchrwd_ifJCAAWLddBUC7P50-o034s9-Znun6FYQw7re3r3H5_ruJq2Ge_izjLc5jR9AmagkzK8CFDgM_UUaQjcc4Od4YW--5r30CNDWsMzquuv0",
                      "isUTF8": 1] as [String: Any]
        let urls = URL(string: encoderPwdURL)!
        request(urls, method: HTTPMethod.post, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (data) in
            if data.result.isSuccess {

            } else {

            }
            let responseData = data.result.value!
            guard let resultArr = RecognitionDoor.getInstance().recognition(with: responseData) else { return }
            for i in resultArr where i.type == RecognitionInsType.sessionTicket {
                //print(i)
                //<ts><ts/>
                return
            }
        }
    }
}
