//
//  IIWebEXInvateBottomVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/16.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class IIWebEXInvateBottomVw: UIView, SearchSelectDelegate {
    var fatherVw: UIView?
    
    var topVW: UIView?
    
    /// 说明label
    let titleLb = UILabel()
    
    init(frame: CGRect, fatherVw: UIView, topVw: UIView) {
        super.init(frame: frame)
        self.topVW = topVw
        self.fatherVw = fatherVw
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error...")
    }
    
    func remake() {
        self.snp.remakeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(topVW!.snp.bottom).offset(10)
            make.height.equalTo(75)
        }
    }
    
    func createVw() {
        self.backgroundColor = APPUIConfig.bgLightGray
        self.fatherVw!.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(topVW!.snp.bottom).offset(10)
            make.height.equalTo(75)
        }
        //左边
        let btnCell = UIView()
        btnCell.backgroundColor = UIColor.white
        self.addSubview(btnCell)
        btnCell.snp.makeConstraints { (make) in
            make.width.equalTo(APPUIConfig.aWeight / 2)
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        //左边按钮
        let letfBtn = UIButton()
        btnCell.addSubview(letfBtn)
        letfBtn.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalTo(btnCell.snp.centerY)
            make.width.equalTo(26)
            make.height.equalTo(26)
        }
        letfBtn.setImage(UIImage(named: "webex_noteaddperson"), for: UIControl.State.normal)
        letfBtn.tapActionsGesture { [weak self] in
            self?.jumpToSelectPersonVC()
        }
        //左边文字
        let addBtnSubLb = UILabel()
        btnCell.addSubview(addBtnSubLb)
        addBtnSubLb.snp.makeConstraints { (make) in
            make.left.equalTo(letfBtn.snp.right).offset(13)
            make.centerY.equalTo(btnCell.snp.centerY)
            make.right.equalTo(-16)
            make.height.equalTo(25)
        }
        addBtnSubLb.font = APPUIConfig.uiFont(with: 17)
        addBtnSubLb.textColor = APPUIConfig.mainCharColor
        addBtnSubLb.text = IIWebEXInter().iiwebex_innerPerson
        addBtnSubLb.tapActionsGesture { [weak self] in
            self?.jumpToSelectPersonVC()
        }
        //右边
        let rightCell = UIView()
        rightCell.backgroundColor = UIColor.white
        self.addSubview(rightCell)
        rightCell.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.width.equalTo(APPUIConfig.aWeight / 2)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        //右边按钮
        let rightBtn = UIButton()
        rightCell.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalTo(btnCell.snp.centerY)
            make.width.equalTo(26)
            make.height.equalTo(26)
        }
        rightBtn.setImage(UIImage(named: "webex_noteaddperson"), for: UIControl.State.normal)
        rightBtn.tapActionsGesture { [weak self] in
            self?.jumpSubCon()
        }
        //右边文字
        let rightSubLb = UILabel()
        rightCell.addSubview(rightSubLb)
        rightSubLb.snp.makeConstraints { (make) in
            make.left.equalTo(rightBtn.snp.right).offset(13)
            make.centerY.equalTo(btnCell.snp.centerY)
            make.right.equalTo(-16)
            make.height.equalTo(25)
        }
        rightSubLb.font = APPUIConfig.uiFont(with: 17)
        rightSubLb.textColor = APPUIConfig.mainCharColor
        rightSubLb.text = IIWebEXInter().iiwebex_outerPerson
        rightSubLb.tapActionsGesture { [weak self] in
            self?.jumpSubCon()
        }
        //中间线条
        let lineVw = UIView()
        self.addSubview(lineVw)
        lineVw.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(4)
            make.bottom.equalTo(btnCell.snp.bottom).offset(-4)
            make.width.equalTo(1)
        }
        lineVw.backgroundColor = APPUIConfig.lineLightGray
        //说明label
        self.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(rightCell.snp.bottom).offset(10)
            make.height.equalTo(17)
        }
        titleLb.text = self.fatherVc()?.mainVm.subtitleTxt
        titleLb.font = APPUIConfig.uiFont(with: 15)
        titleLb.textColor = UIColor.gray
    }
    
    func fatherVc() -> InvitePersonViewController? {
        if let con = self.iiViewController() as? InvitePersonViewController {
            return con
        }
        return nil
    }
    
    /// 跳轉到選人頁面
    func jumpToSelectPersonVC() {
        self.iiViewController()?.navigationController?.pushViewController(self.jumpController(), animated: true)
    }
    
    /// 跳转选人控制器
    func jumpController() -> UIViewController {
        var result = NSMutableArray()
        var maxCount = 0
        if let con = self.fatherVc() {
            result = con.mainVm.getAllSelectedPersons()
            maxCount = con.mainVm.couldSelectNum()
        }

        let service = (BeeHive.shareInstance()?.createService(PhoneBookIBLL.self) as? PhoneBookIBLL)
        let con = service?.jump?(toSearchSelectViewController: self, navTitle: IIWebEXInter().iiwebex_selectAttendees, selectOnlyPeopleArray: result, selectOnlyGroupArray: nil, selectOnlyChatArray: nil, selectNumFlag: 0, selectPageFlag: 0, selectContentFlag: 2, isGroupHidden: true, isFromTabbar: false, peopleMaxNum: maxCount, shareText: nil)
        return con ?? UIViewController()
    }
    
    /// 选人回调
    func getSelectPeople(_ peopleArray: NSMutableArray!, groupArray: NSMutableArray!, chatArray: NSMutableArray!) {
        var result = [InvateVModel]()
        for i in peopleArray {
            if let model = i as? NSObject {
                let modelEmailAdd = (model.value(forKey: "email") as? String) ?? ""
                let emailAdd = "https://emm.inspur.com/img/userhead/\(modelEmailAdd)"
                let modelName = (model.value(forKey: "realName") as? String) ?? ""
                let realModel = InvateVModel(showName: modelName, email: modelEmailAdd, imgUrl: emailAdd)
                result.append(realModel)
            }
        }
        self.fatherVc()?.mainVm.addInvateMainDataSource(model: result)
    }
    
    func jumpSubCon() {
        self.fatherVc()?.jumpSubVc()
    }
}
