//
//  IIWebEX.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/9.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class IIWebEX: NSObject {

    var joinMeetingStr: String = ""

    var startMeetingStr: String = ""

    let appStoreAdd = "https://itunes.apple.com/cn/app/cisco-webex-meetings/id298844386?mt=8"

    //var uti = IIWebEXUtility()
    
    var alertAction: UIAlertController?

    override init() {
        super.init()
    }
    
    func progressURL(userid: String?, mpw: String?, meetid: String?, sk: String?) {
        if userid == nil || mpw == nil || meetid == nil || sk == nil { return }
        let realMno = meetid!.replace(find: " ", replaceStr: "")
        self.joinMeetingStr = "wbx://inspurcloud.webex.com.cn/inspurcloud?MK=\(realMno)&MPW=\(mpw!)"

        let realuserId = (userid! as NSString).urlEncoded()!
        let reslTK = (sk! as NSString).urlEncoded()!
        self.startMeetingStr = "wbx://inspurcloud.webex.com.cn/inspurcloud?MK=\(realMno)&MTGTK=&sitetype=TRAIN&r2sec=1&ST=1&UN=\(realuserId)&TK=\(reslTK)"
    }

    func startMeeting() {
        guard let createMeetingURL = URL(string: self.startMeetingStr) else {
            return
        }
        if !UIApplication.shared.canOpenURL(createMeetingURL) {
            goAppStore()
            return
        }
        UIApplication.shared.openURL(createMeetingURL)
    }

    func joinMeeting() {
        guard let joinMeetingURL = URL(string: self.joinMeetingStr) else {
            return
        }
        if !UIApplication.shared.canOpenURL(joinMeetingURL) {
            goAppStore()
            return
        }
        UIApplication.shared.openURL(joinMeetingURL)
    }

    /// 跳转到appstore-先提示
    func goAppStore() {
        /// 删除记录
        alertAction = UIAlertController(title: IIWebEXInter().iiwebex_deltip, message: IIWebEXInter().iiwebex_meetDownloadApp, preferredStyle: UIAlertController.Style.alert)
        let confirm = UIAlertAction(title: IIWebEXInter().iiwebex_meetDownloadConfirm, style: UIAlertAction.Style.default) { [weak self](_) in
            if self == nil { return }
            UIApplication.shared.openURL(URL(string: self!.appStoreAdd)!)
        }
        let cancel = UIAlertAction(title: IIWebEXInter().iiwebex_delcal, style: UIAlertAction.Style.cancel) { (_) in }
        alertAction?.addAction(confirm)
        alertAction?.addAction(cancel)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertAction!, animated: true, completion: nil)
    }
}
