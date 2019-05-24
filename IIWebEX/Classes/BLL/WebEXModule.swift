//
//  WebEXModule.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/13.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

@objc public class WebEXModule: NSObject, WebEXIBLL {
    
    @objc public func getDoorVC() -> UIViewController {
        let con = WEBEXMeetingListViewController()
        con.hidesBottomBarWhenPushed = true
        return con
    }
    
}
