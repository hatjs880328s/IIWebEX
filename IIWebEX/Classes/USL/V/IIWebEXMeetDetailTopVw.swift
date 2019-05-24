//
//  MeetDetailTopVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class MeetDetailTopVw: UIView {
    
    var headImg: UIImageView = UIImageView()
    
    var titleLb: UILabel = UILabel()
    
    var stateLb: UILabel = UILabel()
    
    var joinBtn: UIButton = UIButton()
    
    var botLine = UIView()
    
    var fatherVw: UIView?
    
    init(frame: CGRect, fatherVw: UIView) {
        super.init(frame: frame)
        self.fatherVw = fatherVw
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init it error")
    }
    
    /// 20 25 5 20 25 = 100
    func createVw() {
        self.backgroundColor = UIColor.white
        self.fatherVw?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(APPUIConfig.naviHeight)
            make.height.equalTo(70)
        }
        self.addSubview(headImg)
        self.addSubview(titleLb)
        self.addSubview(stateLb)
        self.addSubview(joinBtn)
        self.addSubview(botLine)
        //img
        headImg.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(14)
            make.width.equalTo(42)
            make.height.equalTo(42)
        }
        headImg.layer.cornerRadius = 21
        headImg.layer.masksToBounds = true
        headImg.image = UIImage(named: "none_.png")
        //加入按钮
        joinBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalTo(headImg.snp.centerY)
            make.height.equalTo(28)
            make.width.equalTo(60)
        }
        joinBtn.setTitleColor(APPUIConfig.cloudThemeColor, for: UIControl.State.normal)
        joinBtn.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        joinBtn.backgroundColor = APPUIConfig.lineLightGray
        joinBtn.titleLabel?.font = APPUIConfig.uiFont(with: 15)
        joinBtn.layer.cornerRadius = 15
        joinBtn.layer.masksToBounds = true
        joinBtn.tapActionsGesture {[weak self] in
            //
            self?.joinMeet()
        }
        //title
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).offset(10)
            make.centerY.equalTo(headImg.snp.centerY)
            make.height.equalTo(25)
            make.right.equalTo(joinBtn.snp.left).offset(-5)
        }
        titleLb.textColor = APPUIConfig.mainCharColor
        titleLb.font = APPUIConfig.uiFont(with: 17)
        titleLb.text = "Sample Meeting"
        //状态
        stateLb.snp.makeConstraints { (make) in
            make.left.equalTo(titleLb.snp.left)
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.right.equalTo(-16)
        }
        stateLb.textColor = UIColor.gray
        stateLb.font = APPUIConfig.uiFont(with: 15)
        stateLb.alpha = 0
        //线条
//        botLine.snp.makeConstraints { (make) in
//            make.left.equalTo(0)
//            make.bottom.equalTo(0)
//            make.height.equalTo(1)
//            make.right.equalTo(0)
//        }
//        botLine.backgroundColor = APPUIConfig.lineLightGray
    }
    
    func setData(model: IIWebEXVModel) {
        self.headImg.sd_setImage(with: URL(string: model.imgUrl), placeholderImage: UIImage(named: "none_.png"), options: SDWebImageOptions.continueInBackground, completed: nil)
        self.titleLb.text = model.title
        if model.meetState.isStart {
            //可以开始
            self.joinBtn.isEnabled = true
            self.joinBtn.backgroundColor = APPUIConfig.cloudThemeColor
            self.joinBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else {
            //没开始
            self.joinBtn.isEnabled = false
            self.joinBtn.backgroundColor = APPUIConfig.lineLightGray
            self.joinBtn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        }
        self.joinBtn.setTitle(model.meetState.startBtnTxt, for: UIControl.State.normal)
    }
    
    func joinMeet() {
        guard let con = self.iiViewController() as? WEBEXMeetingDetailViewController else { return }
        con.joinMeeting()
    }
}
