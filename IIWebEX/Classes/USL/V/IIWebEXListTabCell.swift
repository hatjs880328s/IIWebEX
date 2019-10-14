//
//  ListTabCell.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class ListTabCell: UITableViewCell {
    
    var personImg: UIImageView = UIImageView()
    
    /// 时间段
    var timeLb: UILabel = UILabel()
    
    /// title
    var titleLb: UILabel = UILabel()
    
    /// 创建人
    var subTitleLb: UILabel = UILabel()
    
    var botLine = UIView()
    
    /// 狀態按鈕
    var stateBtn = UIButton()
    
    /// 开始时间-为了计时器处理
    var startDate: Date?
    
    /// 持续时间-为了计时器处理
    var duration: Int?
    
    /// 状态按钮文案-为了计时器处理
    var stateBtnTxt: String = ""
    
    /// 会议号-为了计时器处理
    var meetModel: IIWebEXVModel?
    
    var webBll = WebEXBLL()
    
    let uti = IIWebEX()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(self.each10SecReloadData), name: NSNotification.Name(IIWebEXInter.timerName), object: nil)
        createVw()
    }
    
    /// 监听通知搞一次狀態
    @objc func each10SecReloadData() {
        if startDate == nil || duration == nil { return }
        var result: Bool = false
        if startDate!.days == Date().days && startDate!.month == Date().month && startDate!.year == Date().year {
            result = true
        } else {
            result = false
        }
        let resultTime = startDate!.addMinutes(duration!).distances(to: Date()) < 0 ? true : false
        result = result && resultTime
        self.setState(isStart: result, startBtnTxt: stateBtnTxt)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 5 17 5 20 5 17 5 74
    func createVw() {
        self.addSubview(personImg)
        self.addSubview(timeLb)
        self.addSubview(titleLb)
        self.addSubview(subTitleLb)
        self.addSubview(botLine)
        //計時器控制的按鈕
        self.addSubview(stateBtn)
        stateBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(28)
        }
        stateBtn.titleLabel?.font = APPUIConfig.uiFont(with: 15)
        stateBtn.layer.cornerRadius = 15
        stateBtn.layer.masksToBounds = true
        stateBtn.tapActionsGesture {[weak self] in
            self?.joinMeeting()
        }
        personImg.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        personImg.layer.cornerRadius = 20
        personImg.layer.masksToBounds = true
        timeLb.snp.makeConstraints { (make) in
            make.left.equalTo(personImg.snp.right).offset(7)
            make.top.equalTo(5)
            make.height.equalTo(17)
            make.right.equalTo(-16)
        }
        timeLb.textColor = UIColor.gray
        timeLb.font = APPUIConfig.uiFont(with: 13)
        timeLb.text = "00:00 - 00:00"
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(timeLb.snp.left)
            make.top.equalTo(timeLb.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.right.equalTo(stateBtn.snp.left).offset(-8)
        }
        titleLb.textColor = APPUIConfig.mainCharColor
        titleLb.font = APPUIConfig.uiFont(with: 16)
        titleLb.text = "Sample Meeting"
        subTitleLb.snp.makeConstraints { (make) in
            make.left.equalTo(titleLb.snp.left)
            make.top.equalTo(titleLb.snp.bottom).offset(5)
            make.height.equalTo(17)
            make.right.equalTo(-16)
        }
        subTitleLb.textColor = UIColor.gray
        subTitleLb.font = APPUIConfig.uiFont(with: 13)
        subTitleLb.text = "Creator:"
        //线条
        botLine.snp.makeConstraints { (make) in
            make.left.equalTo(subTitleLb.snp.left)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
            make.right.equalTo(0)
        }
        botLine.backgroundColor = APPUIConfig.bgLightGray
        
    }
    
    // 设置文案
    func setData(info: IIWebEXVModel, isLast: Bool) {
        self.meetModel = info
        self.startDate = info.realTime
        self.timeLb.text = info.time
        self.titleLb.text = info.title
        self.subTitleLb.text = info.createPersonName
        self.personImg.sd_setImage(with: URL(string: info.imgUrl), placeholderImage: UIImage(named: "none_.png"), options: SDWebImageOptions.continueInBackground, completed: nil)
        self.botLine.isHidden = isLast
        self.stateBtnTxt = info.listMeetState.startBtnTxt
        self.duration = info.duration
        self.setState(isStart: info.listMeetState.isStart, startBtnTxt: info.listMeetState.startBtnTxt)
    }
    
    /// 設置狀態
    func setState(isStart: Bool, startBtnTxt: String) {
        if isStart {
            //可以开始
            self.alpha = 1
            self.stateBtn.isEnabled = true
            self.stateBtn.backgroundColor = APPUIConfig.cloudThemeColor
            self.stateBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
//            titleLb.snp.remakeConstraints { (make) in
//                make.left.equalTo(timeLb.snp.left)
//                make.top.equalTo(timeLb.snp.bottom).offset(5)
//                make.height.equalTo(20)
//                make.right.equalTo(stateBtn.snp.left).offset(-8)
//            }
        } else {
            //没开始
            stateBtn.alpha = 0
//            titleLb.snp.remakeConstraints { (make) in
//                make.left.equalTo(timeLb.snp.left)
//                make.top.equalTo(timeLb.snp.bottom).offset(5)
//                make.height.equalTo(20)
//                make.right.equalTo(-16)
//            }
        }
        self.stateBtn.setTitle(startBtnTxt, for: UIControl.State.normal)
    }
    
    /// 释放监听
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    ///加入会议
    func joinMeeting() {
        if meetModel == nil { return }
        ProgressHUD.shareInstance()?.showProgress(withMessage: "")
        self.webBll.progressOneMeetInfo(alert: true, id: meetModel?.meetNo) { [weak self](model) in
            let newmodel = IIWebEXVModel()
            newmodel.progressModel2VModel(model: model)
            self?.meetModel = newmodel
            self?.webBll.getSK { [weak self](model) in
                ProgressHUD.shareInstance()?.remove()
                self?.uti.progressURL(userid: self?.meetModel?.createPerson, mpw: self?.meetModel?.meetPwd, meetid: self?.meetModel?.meetNo, sk: model.tk)
                guard let boolValue = self?.meetModel?.hostKeyTuple.shouldShow else { return }
                if boolValue {
                    self?.uti.startMeeting()
                } else {
                    self?.uti.joinMeeting()
                }
            }
        }
    }
    
}
