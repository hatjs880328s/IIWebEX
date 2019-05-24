//
//  IIWEBEXInviteVM.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/12.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa

class IIWEBEXInviteVM: NSObject {
    
    var searchFdInput: PublishSubject<String> = PublishSubject<String>()
    
    var searchFdOutput: Observable<Bool>!
    
    /// 最多字符个数，目前没有验证
    let maxCharCount = 500
    
    /// 最大可邀请人数值
    let maxCount = 20
    
    /// 匹配完成的个数
    var complexCount = 0 {
        didSet {
            if self.countChangeAction == nil { return }
            let result = IIWebEXInter().iiwebex_invateCount.replace(find: "{}", replaceStr: "\(complexCount)").replace(find: "[]", replaceStr: "\(maxCount - complexCount)")
            countChangeAction!(result)
            if self.outPersonChangeAction == nil { return }
            outPersonChangeAction!(result)
        }
    }
    
    /// 个数更改action
    var countChangeAction: ((_ str: String) -> Void)?
    
    /// 外部选人个数更改action
    var outPersonChangeAction: ((_ str: String) -> Void)?
    
    var subtitleTxt: String {
        get {
            return IIWebEXInter().iiwebex_invateCount.replace(find: "{}", replaceStr: "\(complexCount)").replace(find: "[]", replaceStr: "\(maxCount - complexCount)")
        }
    }
    
    /// 主页数据源
    var invateMainDatasource: [InvateVModel] = [] {
        didSet {
            if self.invateMainAction == nil { return }
            self.complexCount = self.invateMainDatasource.count
            self.invateMainAction!()
            if self.invateSubAction == nil { return }
            self.invateSubAction!()
        }
    }
    
    /// 主页action
    var invateMainAction: (() -> Void)?
    
    /// 外部联系人action
    var invateSubAction: (() -> Void)?
    
    override init() {
        super.init()
        self.searchFdOutput = self.searchFdInput.asObservable().map({ [weak self](strInfo) -> Bool in
            //验证字符个数 & 正则处理
            if self?.regexProgressEmail(str: strInfo).count == 1 {
                return true
            }
            return false
        })
    }
    
    /// 正则判定有效邮箱[贼LOW的法子]
    @discardableResult
    func regexProgressEmail(str: String) -> [String] {
        var result = [String]()
        if let results = RecognitionDoor.getInstance().recognition(with: str) {
            for eachItem in results where eachItem.type == .email {
                result.append(eachItem.rangeInfo)
            }
        }
        return result
    }
    
    /// 主页数据源添加信息
    func addInvateMainDataSource(model: [InvateVModel]) {
        ///这里需要先将原来的内部人员地址删除掉
        var i = self.invateMainDatasource.count - 1
        let realInnerPerson = self.getAllSelectedPerson()
        while i >= 0 {
            LOOP:for eachItem in realInnerPerson {
                if eachItem.email == self.invateMainDatasource[i].email {
                    self.invateMainDatasource.remove(at: i)
                    break LOOP
                }
            }
            i -= 1
        }
        //然后再加入
        var data = self.invateMainDatasource
        data.append(contentsOf: model)
        self.invateMainDatasource = data
    }
    
    /// 根据邮箱获取所有的person-model【內部聯系人数组[PhoneBookModel]】
    func getAllSelectedPersons() -> NSMutableArray {
        let result = NSMutableArray()
        for i in self.invateMainDatasource {
            if let obj = (BeeHive.shareInstance()?.createService(PhoneBookIBLL.self) as? PhoneBookIBLL)?.bll_getPhoneBookUserModel?(byMail: i.email) {
                result.add(obj)
            }
        }
        return result
    }
    
    /// 根据邮箱获取所有的person-model【內部聯系人数组[InvateVModel]】
    func getAllSelectedPerson() -> [InvateVModel] {
        var result = [InvateVModel]()
        for i in self.invateMainDatasource {
            if (BeeHive.shareInstance()?.createService(PhoneBookIBLL.self) as? PhoneBookIBLL)?.bll_getPhoneBookUserModel?(byMail: i.email) != nil  {
                result.append(i)
            }
        }
        return result
    }
    
    /// 手动输入的外部联系人数据源[]
    func getAllOutPerson() -> [InvateVModel] {
        var result = [InvateVModel]()
        for i in self.invateMainDatasource {
            if i.email == i.showName {
                result.append(i)
            }
        }
        return result
    }
    
    /// sub联系人添加信息
    @discardableResult
    func addInvateSubDatasource(model: InvateVModel) -> Bool {
        if self.invateMainDatasource.count >= maxCount {
            WebEXModuleInitAction.showToastAction?(IIWebEXInter().iiwebex_moreThan20Person)
            return false
        }
        
        //排重
        let models = self.progressMultiData(allImtes: self.invateMainDatasource, items: [model])
        if models.count == 0 {
            WebEXModuleInitAction.showToastAction?(IIWebEXInter().iiwebex_outPersonisExists)
            return false
        }
        var data = self.invateMainDatasource
        data.append(contentsOf: models)
        self.invateMainDatasource = data
        return true
    }
    
    /// 排重   allitem: 总数组  items: 需要比较的数组
    func progressMultiData(allImtes: [InvateVModel], items: [InvateVModel]) -> [InvateVModel] {
        var result = [InvateVModel]()
        for item in items {
            var flag = false
            LOOP:for i in allImtes {
                if i == item {
                    flag = true
                    break LOOP
                }
            }
            if !flag {
                result.append(item)
            }
        }
        return result
    }
    
    /// [main sub相同]页面删除一个联系人
    func removeItem(email: String) {
        for i in 0 ..< self.invateMainDatasource.count {
            if invateMainDatasource[i].email == email {
                self.invateMainDatasource.remove(at: i)
                let data = self.invateMainDatasource
                self.invateMainDatasource = data
                break
            }
        }
    }
    
    /// 内部选人时，可以选择最大人数
    func couldSelectNum() -> Int {
        let innerCount = getAllSelectedPersons().count
        let outCount = self.invateMainDatasource.count - innerCount
        return maxCount - outCount
    }
}
