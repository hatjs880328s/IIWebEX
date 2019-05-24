//
//  CreateMtTabCell.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CreateMtTabCell: UITableViewCell {
    
    /// title
    var titleLb: UITextField = UITextField()
    
    /// subtitle
    var subTitleLb: UILabel = UILabel()
    
    /// arrow
    var arrowBtn: UIImageView = UIImageView()
    
    /// topline
    var topLineVw: UIView = UIView()
    
    /// bottomline
    var bottomLineVw: UIView = UIView()
    
    /// titlechange action[只有第一个cell如此]
    var titleChangeAction: ((_ str: String) -> Void)?
    
    let maxCount: Int = 31
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createVw()
        createRx()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(titleLb)
        self.addSubview(subTitleLb)
        self.addSubview(topLineVw)
        self.addSubview(bottomLineVw)
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
            make.right.equalTo(-16)
        }
        titleLb.textColor = APPUIConfig.mainCharColor
        titleLb.font = APPUIConfig.uiFont(with: 16)
        subTitleLb.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
            make.right.equalTo(-16)
        }
        subTitleLb.textColor = APPUIConfig.subCharColor
        subTitleLb.font = APPUIConfig.uiFont(with: 14)
        subTitleLb.textAlignment = .right
        //line
        topLineVw.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(0.5)
            make.right.equalTo(0)
        }
        bottomLineVw.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.equalTo(0.8)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        bottomLineVw.backgroundColor = APPUIConfig.lineLightGray
        topLineVw.backgroundColor = APPUIConfig.lineLightGray
    }
    
    // 添加箭头
    func addArrow(isHave: Bool) {
        if !isHave { return }
        self.addSubview(arrowBtn)
        arrowBtn.image = UIImage(named: "arrow right_")
        arrowBtn.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.right.equalTo(-16)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(12)
        }
        subTitleLb.snp.remakeConstraints { (make) in
            make.right.equalTo(self.arrowBtn.snp.left).offset(-5)
            make.left.equalTo(16)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
        }
    }
    
    // 设置文案
    func setData(title: String?, subTitle: String? ) {
        if let titleTxt = title {
            self.titleLb.text = titleTxt
        }
        if let subtitleTxt = subTitle {
            self.subTitleLb.text = subtitleTxt
        }
    }
    
    /// 缩短线条
    func setTopAndBottomLine(type: IIWebTabCellEnum) {
        switch type {
        case .topAndBottomHave:
            break
        case .onlyTop:
            self.bottomLineVw.snp.updateConstraints { (make) in
                make.left.equalTo(APPUIConfig.aWeight)
            }
        case .onlyBottom:
            self.topLineVw.snp.updateConstraints { (make) in
                make.left.equalTo(APPUIConfig.aWeight)
            }
        case .topNormalBottomShort:
            self.bottomLineVw.snp.updateConstraints { (make) in
                make.left.equalTo(16)
            }
        case .bottomNormalTopShort:
            self.topLineVw.snp.updateConstraints { (make) in
                make.left.equalTo(16)
            }
        }
    }
    
    func setCouldEdit(could: Bool) {
        self.titleLb.isEnabled = could
        self.titleLb.clearButtonMode = .whileEditing
    }
    
    func createRx() {
        _ = self.titleLb.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe { [weak self](events) in
                if events.element == nil || self?.titleChangeAction == nil { return }
                if events.element!.length >= self!.maxCount {
                    self?.titleLb.text = events.element!.substringToIndex(self!.maxCount - 1)
                    self?.titleChangeAction!(events.element!.substringToIndex(self!.maxCount - 1))
                } else {
                    self?.titleChangeAction!(events.element!)
                }
            }
    }
    
}
