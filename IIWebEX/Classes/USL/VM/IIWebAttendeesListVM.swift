//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IIWebAttendeesListVM.swift
//
// Created by    Noah Shan on 2018/10/27
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation

class IIWebAttendeesListVM: NSObject {

    var tabDatasource = [IIWebEXAttendeesListVModel]() {
        didSet {
            if reloadAction == nil { return }
            reloadAction!()
        }
    }

    var reloadAction: (() -> Void)?

    override init() {
        super.init()
    }

    /// 数据初始化 - 从外部传递进来
    func initData(source: [IIWebEXAttendeesListVModel]) {
        self.tabDatasource = source
    }
}
