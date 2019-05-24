//
//  IIWebEXListEmptyVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/15.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class IIWebEXListEmptyVw: UIView {
    
    var createBtn = UIButton()
    
    var txtLb: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        let bgVw = UIView()
        self.addSubview(bgVw)
        bgVw.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-35)
            make.width.equalTo(APPUIConfig.aWeight)
            make.height.equalTo(110)
        }
        self.backgroundColor = UIColor.white
        bgVw.layer.cornerRadius = 5
        bgVw.layer.masksToBounds = true
        bgVw.addSubview(createBtn)
        bgVw.addSubview(txtLb)
        createBtn.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(61)
            make.height.equalTo(61)
        }
        createBtn.tapActionsGesture {
            (self.ViewController() as? WEBEXMeetingListViewController)?.goCreatingMt()
        }
        createBtn.setImage(UIImage(named: "webex_nocontent"), for: UIControl.State.normal)
        txtLb.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(createBtn.snp.bottom).offset(10)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        txtLb.font = APPUIConfig.uiFont(with: 14)
        txtLb.textColor = APPUIConfig.lineLightGray
        
        let monthTxt = (IIWebEXInter().iiwebex_mins != "mins") ? IIWebEXInter().iiwebex_months : "-"
        let dayTxt = (IIWebEXInter().iiwebex_mins != "mins") ? IIWebEXInter().iiwebex_days : ""
        let nowDate = Date()
        let txtInfo = "\(nowDate.month)\(monthTxt)\(nowDate.days)\(dayTxt)"
        let realTxt = IIWebEXInter().iiwebex_beforeNoMeet.replace(find: "{}", replaceStr: txtInfo)
        
        //NSAttributedStringKey
        let blackAtt = [NSAttributedString.Key.foregroundColor: APPUIConfig.mainCharColor]
        let range = (realTxt as NSString).range(of: txtInfo)
        let attributeStr = NSMutableAttributedString(string: realTxt)
        attributeStr.addAttributes(blackAtt, range: range)
        txtLb.attributedText = attributeStr
        
        txtLb.textAlignment = .center
        
    }
    
}
