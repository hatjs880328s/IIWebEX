//
//  ListTabVM.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class ListTabVM: NSObject {
    
    var tabDatasource: [[IIWebEXVModel]] = [] {
        didSet {
            self.isFistGetData = false
            ProgressHUD.shareInstance()?.remove()
            if self.reloadAction == nil { return }
            self.reloadAction!()
        }
    }
    
    var reloadAction: (() -> Void)?
    
    var bll = WebEXBLL()
    
    /// 只有第一次加载数据需要progressHUD
    var isFistGetData: Bool = true
    
    override init() {
        super.init()
    }
    
    func initData(alert: Bool) {
        listFirstShow()
        var result: [[IIWebEXVModel]] = []
        if isFistGetData {
            ProgressHUD.shareInstance()?.showProgress(withMessage: "")
        }
        self.bll.progressListData(alert: alert, action: { (webData) in
            //self.tabDatasource.removeAll()
            for eachItem in webData {
                var eachGroup = [IIWebEXVModel]()
                for item in eachItem {
                    let model = IIWebEXVModel()
                    model.progressModel2VModel(model: item)
                    eachGroup.append(model)
                }
                result.append(eachGroup)
            }
            self.tabDatasource = result
        }) {
            //为了endrefresh
            self.tabDatasource = self.tabDatasource
        }
    }
    
    /// 第一次访问添加教程vw
    func listFirstShow() {
        if !IICacheManager.getInstance().isContains(key: IICacheStorage().iiwebexFirstCreateMeet) {
            IICacheManager.getInstance().saveObj(key: IICacheStorage().iiwebexFirstCreateMeet, someThing: ("1" as NSString))
            _ = IIWebEXHow2UseVw(frame: CGRect.zero)
        }
    }
    
    /// section - title
    func getTitleWith(section: Int) -> (String, String) {
        if let item = self.tabDatasource[section].first {
            return item.listSectionTime
        }
        return ("", "")
    }
    
    /// 是否是每一个section的最后一个
    func isLastItemEachSection(index: IndexPath) -> Bool {
        if index.row == self.tabDatasource[index.section].count - 1 && index.section != self.tabDatasource.count - 1 {
            return true
        }
        return false
    }
}
