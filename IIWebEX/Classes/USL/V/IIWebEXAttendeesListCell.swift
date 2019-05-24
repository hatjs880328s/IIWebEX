//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IIWebEXAttendeesListCell.swift
//
// Created by    Noah Shan on 2018/10/27
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation

class IIWebEXAttendeesListCell: UITableViewCell {

    var img: UIImageView = UIImageView()

    var email: UILabel = UILabel()

    var personType: UILabel = UILabel()

    var type: UILabel = UILabel()

    var line: UIView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createVw()
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 100
    func createVw() {
        self.addSubview(img)
        self.addSubview(email)
        self.addSubview(personType)
        self.addSubview(type)
        self.addSubview(line)
        //头像
        img.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        img.layer.cornerRadius = 22.5
        img.layer.masksToBounds = true
        //邮件地址
        email.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.top.equalTo(10)
            make.right.equalTo(-16)
            make.height.equalTo(20)
        }
        email.font = APPUIConfig.uiFont(with: 15)
        email.textColor = APPUIConfig.mainCharColor
        //参会人类型- 内部  & 外部
        personType.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.top.equalTo(email.snp.bottom).offset(10)
            make.right.equalTo(-16)
            make.height.equalTo(20)
        }
        personType.font = APPUIConfig.uiFont(with: 14)
        personType.textColor = UIColor.gray
        //是否是主持人
        type.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.top.equalTo(personType.snp.bottom).offset(10)
            make.right.equalTo(-16)
            make.height.equalTo(20)
        }
        type.font = APPUIConfig.uiFont(with: 14)
        type.textColor = UIColor.gray
        //底部线条
        line.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.height.equalTo(1)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        line.backgroundColor = APPUIConfig.bgLightGray
    }

    func setData(model: IIWebEXAttendeesListVModel) {
        self.img.sd_setImage(with: URL(string: model.imgUrl), placeholderImage: UIImage(named: "none_"), options: SDWebImageOptions.continueInBackground, completed: nil)
        self.email.text = model.email
        self.personType.text = model.userType
        self.type.text = model.isHost
    }
}
