//
//  MeetDetailContentVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class MeetDetailContentVw: UIView {
    
    //主持人
    var titleLb: UILabel = UILabel()
    
    var realTitlelb: UILabel = UILabel()
    
    //时间
    var timeLb: UILabel = UILabel()
    
    let durationTime = UILabel()
    
    var realTimeLb: UILabel = UILabel()
    
    //会议号
    var meetNoLb: UILabel = UILabel()
    
    var realmeetNoLb: UILabel = UILabel()
    
    //会议密码
    var meetPwdLb: UILabel = UILabel()
    
    var realmeetPwdLb: UILabel = UILabel()
    
    //主持人密码
    var hostKeylb: UILabel = UILabel()
    
    var realHostKeyLb: UILabel = UILabel()
    
    var topVw: UIView?
    
    var fatherVw: UIView?
    
    let lineFour = UIView()
    
    init(frame: CGRect, fatherVw: UIView, topVw: UIView) {
        super.init(frame: frame)
        self.fatherVw = fatherVw
        self.topVw = topVw
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init it error")
    }
    
    /// 72 * 5 = 360
    func createVw() {
        self.addSubview(titleLb)
        self.addSubview(realTitlelb)
        self.addSubview(timeLb)
        self.addSubview(realTimeLb)
        self.addSubview(meetNoLb)
        self.addSubview(realmeetNoLb)
        self.addSubview(meetPwdLb)
        self.addSubview(realmeetPwdLb)
        self.addSubview(hostKeylb)
        self.addSubview(realHostKeyLb)
        self.backgroundColor = UIColor.white
        self.fatherVw?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(self.topVw!.snp.bottom).offset(10)
            make.height.equalTo(360)
        }
        //主持人
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(20)
            make.top.equalTo(10)
        }
        titleLb.textColor = UIColor.gray
        titleLb.font = APPUIConfig.uiFont(with: 13)
        titleLb.text = IIWebEXInter().iiwebex_meetHost
        realTitlelb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(25)
            make.top.equalTo(titleLb.snp.bottom).offset(7)
        }
        realTitlelb.textColor = APPUIConfig.mainCharColor
        realTitlelb.font = APPUIConfig.uiFont(with: 17)
        let lineOne = UIView()
        self.addSubview(lineOne)
        lineOne.backgroundColor = APPUIConfig.bgLightGray
        lineOne.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(realTitlelb.snp.bottom).offset(10)
        }
        //时间
        timeLb.snp.makeConstraints { (make) in
            make.left.equalTo(titleLb.snp.left)
            make.right.equalTo(-16)
            make.height.equalTo(20)
            make.top.equalTo(lineOne.snp.bottom).offset(10)
        }
        timeLb.textColor = UIColor.gray
        timeLb.font = APPUIConfig.uiFont(with: 13)
        timeLb.text = IIWebEXInter().iiwebex_meetTime
        realTimeLb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(timeLb.snp.bottom).offset(7)
        }
        realTimeLb.numberOfLines = 0
        realTimeLb.textColor = APPUIConfig.mainCharColor
        realTimeLb.font = APPUIConfig.uiFont(with: 17)
        //---duration
        self.addSubview(durationTime)
        durationTime.snp.makeConstraints { (make) in
            make.centerY.equalTo(realTimeLb.snp.centerY)
            make.right.equalTo(-16)
            make.height.equalTo(25)
            make.width.equalTo(150)
        }
        durationTime.font = APPUIConfig.uiFont(with: 17)
        durationTime.textColor = APPUIConfig.cloudThemeColor
        durationTime.textAlignment = .right
        let lineTwo = UIView()
        self.addSubview(lineTwo)
        lineTwo.backgroundColor = APPUIConfig.bgLightGray
        lineTwo.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(realTimeLb.snp.bottom).offset(10)
        }
        //会议号
        meetNoLb.snp.makeConstraints { (make) in
            make.left.equalTo(titleLb.snp.left)
            make.right.equalTo(-16)
            make.height.equalTo(20)
            make.top.equalTo(lineTwo.snp.bottom).offset(10)
        }
        meetNoLb.textColor = UIColor.gray
        meetNoLb.font = APPUIConfig.uiFont(with: 13)
        meetNoLb.text = IIWebEXInter().iiwebex_meetNo
        realmeetNoLb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(meetNoLb.snp.bottom).offset(7)
            make.height.equalTo(25)
        }
        realmeetNoLb.textColor = APPUIConfig.mainCharColor
        realmeetNoLb.font = APPUIConfig.uiFont(with: 17)
        let lineThr = UIView()
        self.addSubview(lineThr)
        lineThr.backgroundColor = APPUIConfig.bgLightGray
        lineThr.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(realmeetNoLb.snp.bottom).offset(10)
        }
        //会议密码
        meetPwdLb.snp.makeConstraints { (make) in
            make.left.equalTo(titleLb.snp.left)
            make.right.equalTo(-16)
            make.height.equalTo(20)
            make.top.equalTo(lineThr.snp.bottom).offset(10)
        }
        meetPwdLb.textColor = UIColor.gray
        meetPwdLb.font = APPUIConfig.uiFont(with: 13)
        meetPwdLb.text = IIWebEXInter().iiwebex_meetPwd
        realmeetPwdLb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(meetPwdLb.snp.bottom).offset(7)
            make.height.equalTo(25)
        }
        realmeetPwdLb.textColor = APPUIConfig.mainCharColor
        realmeetPwdLb.font = APPUIConfig.uiFont(with: 17)
        self.addSubview(lineFour)
        lineFour.backgroundColor = APPUIConfig.bgLightGray
        lineFour.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(realmeetPwdLb.snp.bottom).offset(10)
        }
        //主持人密码
        hostKeylb.snp.makeConstraints { (make) in
            make.left.equalTo(titleLb.snp.left)
            make.right.equalTo(-16)
            make.height.equalTo(20)
            make.top.equalTo(lineFour.snp.bottom).offset(10)
        }
        hostKeylb.textColor = UIColor.gray
        hostKeylb.font = APPUIConfig.uiFont(with: 13)
        hostKeylb.text = IIWebEXInter().iiwebex_hostKey
        hostKeylb.alpha = 0
        realHostKeyLb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(hostKeylb.snp.bottom).offset(7)
            make.height.equalTo(25)
        }
        realHostKeyLb.textColor = APPUIConfig.mainCharColor
        realHostKeyLb.font = APPUIConfig.uiFont(with: 17)
        realHostKeyLb.alpha = 0
        
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        self.addGestureRecognizer(longPressGes)
    }
    
    /// 长按复制
    @objc func longPress() {
        if let con = self.iiViewController() as? WEBEXMeetingDetailViewController {
            con.getPasterStr()
        }
    }
    
    func setData(model: IIWebEXVModel) {
        self.realTitlelb.text = model.createPersonName
        self.realTimeLb.text = model.contentTime
        self.realmeetNoLb.text = model.meetNo
        self.realmeetPwdLb.text = model.meetPwd
        self.durationTime.text = model.contentTimeSecondPart
        if model.hostKeyTuple.shouldShow {
            hostKeylb.alpha = 1
            realHostKeyLb.alpha = 1
            lineFour.alpha = 1
            self.snp.remakeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(self.topVw!.snp.bottom).offset(10)
                make.height.equalTo(360)
            }
        } else {
            hostKeylb.alpha = 0
            realHostKeyLb.alpha = 0
            lineFour.alpha = 0
            self.snp.remakeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(self.topVw!.snp.bottom).offset(10)
                make.height.equalTo(288)
            }
        }
        realHostKeyLb.text = model.hostKeyTuple.keyInfo
    }
}
