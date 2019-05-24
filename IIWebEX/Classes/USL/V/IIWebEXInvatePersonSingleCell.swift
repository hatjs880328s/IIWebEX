//
//  InvatePersonSingleVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/12.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class InvatePersonSingleCell: UITableViewCell {
    
    let img = UIImageView()
    
    let pwdVw = UILabel()
    
    let holderTxt = IIWebEXInter().iiwebex_addPersonEmail
    
    let realRightVw = UIButton()
    
    ///数据源email
    var emailData = ""
    
    weak var superVw: IIWebEXInvateTabVw?
    
    let lineVw: UIView = UIView()

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, fatherVw: IIWebEXInvateTabVw) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.superVw = fatherVw
        createVw()
    }
    
    func createVw() {
        self.addSubview(img)
        self.addSubview(pwdVw)
        self.addSubview(realRightVw)
        img.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(34)
            make.height.equalTo(34)
        }
        img.layer.cornerRadius = 17
        img.layer.masksToBounds = true
        pwdVw.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.right.equalTo(0)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(25)
        }
        pwdVw.font = APPUIConfig.uiFont(with: 17)
        //rightcontent view
        realRightVw.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.width.equalTo(20)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(20)
        }
        realRightVw.tapActionsGesture {[weak self] in
            self?.selectAction()
        }
        //line
        self.addSubview(lineVw)
        lineVw.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        lineVw.backgroundColor = APPUIConfig.bgLightGray
    }
    
    func setData(model: InvateVModel?, isLast: Bool) {
        if model == nil { return }
        emailData = model!.email
        self.img.sd_setImage(with: URL(string: model!.imgUrl), placeholderImage: UIImage(named: "none_"), options: SDWebImageOptions.continueInBackground, completed: nil)
        self.pwdVw.text = model!.showName
        self.realRightVw.setImage(UIImage(named: "webex_notedelperson"), for: UIControl.State.normal)
        if isLast {
            lineVw.alpha = 0
        } else {
            lineVw.alpha = 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeBtnImg() {
        self.realRightVw.isSelected = true
        let lastVi = UIView()
        lastVi.backgroundColor = APPUIConfig.lineLightGray
        self.addSubview(lastVi)
        lastVi.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(0)
            make.height.equalTo(0.5)
            make.bottom.equalTo(0)
        }
    }
    
    /// 删除当前项目
    func selectAction() {
        if let con = superVw?.fatherVc() {
            con.mainVm.removeItem(email: self.emailData)
        }
        if let con = superVw?.fatherVcs() {
            con.mainVm.removeItem(email: self.emailData)
        }
    }
    
}
