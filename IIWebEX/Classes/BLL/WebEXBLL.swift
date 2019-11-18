//
//  WebEXBLL.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/12.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation
import HandyJSON

class WebEXBLL: NSObject {
    
    var dal = WebEXDAL()
    
    override init() {
        super.init()
    }
    
    /// 获取列表信息
    func progressListData(alert: Bool, action: @escaping (_ arr: [[IIWebEXModel]]) -> Void, failAction: @escaping () -> Void) {
        dal.getMeetList(alertInfo: alert, success: { (arr) in
            self.list2Models.removeAll()
            for eachItem in arr {
                guard let dicValue = eachItem as? NSDictionary else {
                    continue
                }
                if let obj = IIWebEXModel.deserialize(from: dicValue) {
                    self.progress2List(model: obj)
                }
            }
            action(self.list2Models)
        }) {
            //err
            failAction()
        }
    }
    
    /// 获取单条数据 & 密码
    func progressOneMeetInfo(alert: Bool, id: String?, action: @escaping (_ arr: IIWebEXModel) -> Void) {
        if id == nil { return }
        dal.getMeetBy(alertInfo: alert, id: id!, success: { (dic) in
            if let obj = IIWebEXModel.deserialize(from: dic) {
                action(obj)
            } else {
                //error
                ProgressHUD.shareInstance()?.remove()
            }
        }) {
            //error
            ProgressHUD.shareInstance()?.remove()
        }
    }
    
    /// 安排会议
    func createMeeting(with model: IIWebEXModel, successAction:@escaping () -> Void) {
        guard let params = model.toJSON() else { return }
        dal.createMeeting(params: params, success: {
            //success
            //WebEXModuleInitAction.showToastAction?(IIWebEXInter().iiwebex_createSuccess)
            successAction()
        }) {
            //err
            ProgressHUD.shareInstance()?.remove()
        }
    }
    
    /// 获取tk
    func getSK(successAction:@escaping (_ model: IIWebEXSKModel) -> Void) {
        dal.getSK(success: { (dicValue) in
            if let model = IIWebEXSKModel.deserialize(from: dicValue) {
                successAction(model)
            } else {
                //error
                ProgressHUD.shareInstance()?.remove()
            }
        }) {
            //error
            ProgressHUD.shareInstance()?.remove()
        }
    }
    
    /// 删除一条记录
    func removeOntItem(with id: String, successAction:@escaping () -> Void) {
        dal.removeOneItem(with: id, success: {
            //success
            successAction()
        }) {
            //error dothing...
            ProgressHUD.shareInstance()?.remove()
        }
    }
    
    /// 二位數組
    var list2Models = [[IIWebEXModel]]()
    
    /// 处理二位数组
    func progress2List(model: IIWebEXModel) {
        var flag = false
        for i in 0 ..< self.list2Models.count {
            if list2Models[i].first!.startDate!.year == model.startDate!.year &&
            list2Models[i].first!.startDate!.month == model.startDate!.month &&
            list2Models[i].first!.startDate!.days == model.startDate!.days {
                //有相同的就添加进去
                list2Models[i].append(model)
                flag = true
                break
            }
        }
        //没人收留它
        if !flag {
            let groupNew = [model]
            list2Models.append(groupNew)
        }
    }
    
    /// 分享
    func share(iimodel: IIWebEXVModel?, pushAction:@escaping (_ con: UIViewController) -> Void) {
        let shareStr = self.getPastStr(iimodel: iimodel) ?? ""
        guard let vc = WebEXModuleInitAction.innerShare?(shareStr) else { return }
        pushAction(vc)
    }
    
    /// 分享内容
    func getPastStr(iimodel: IIWebEXVModel?) -> String? {
        if iimodel == nil { return nil }
        let title = iimodel?.title ?? ""
        
        let time = iimodel?.contentTime ?? ""
        
        let meetNo = iimodel?.meetNo ?? ""
        
        let pwd = iimodel?.meetPwd ?? ""
        
        let shareStr = """
        \(title)
        \(IIWebEXInter().iiwebex_meetTime):\(time)
        \(IIWebEXInter().iiwebex_meetNo):\(meetNo)
        \(IIWebEXInter().iiwebex_meetPwd):\(pwd)
        """
        
        return shareStr
    }
}
