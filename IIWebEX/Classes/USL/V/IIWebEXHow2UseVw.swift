//
//  IIWebEXHow2UseVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/17.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class IIWebEXHow2UseVw: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error init the IIWebEXHow2UseVw")
    }
    
    func createVw() {
        self.backgroundColor = UIColor.black
        self.alpha = 0.8
        self.frame = UIScreen.main.bounds
        let img = UIImageView(frame: CGRect.zero)
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.top.equalTo(APPUIConfig.naviHeight + 15)
        }
        img.image = UIImage(named: "webex_alertTitle")
        let knowBtn = UIImageView()
        self.addSubview(knowBtn)
        knowBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(img.snp.centerX)
            make.top.equalTo(img.snp.bottom).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        knowBtn.image = UIImage(named: "webex_alertBtn")
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        knowBtn.tapActionsGesture { [weak self] in
            self?.hideSelf()
        }
    }
    
    func hideSelf() {
        self.removeFromSuperview()
    }
}
