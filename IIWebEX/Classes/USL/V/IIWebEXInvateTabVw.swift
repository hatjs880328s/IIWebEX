//
//  IIWebEXInvateTabVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/16.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class IIWebEXInvateTabVw: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var fatherVw: UIView?
    var tab: UITableView = UITableView()
    var itemCount: Int = 0
    init(frame: CGRect, fatherVw: UIView, itemCount: Int) {
        super.init(frame: frame)
        self.itemCount = itemCount
        self.fatherVw = fatherVw
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error...")
    }
    
    func createVw() {
        self.fatherVw?.addSubview(self)
        var realHeight: CGFloat = 0
        if self.fatherVc() != nil {
            let heighMax = APPUIConfig.aHeight - APPUIConfig.naviHeight - 100
            realHeight = (44.0 * CGFloat(itemCount)) >= heighMax ? heighMax : (44.0 * CGFloat(itemCount))
        }
        if self.fatherVcs() != nil {
            let heighMax = APPUIConfig.aHeight - APPUIConfig.naviHeight - 90
            realHeight = (44.0 * CGFloat(itemCount)) >= heighMax ? heighMax : (44.0 * CGFloat(itemCount))
        }
        self.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(APPUIConfig.naviHeight)
            make.height.equalTo(realHeight)
        }
        //
        self.addSubview(tab)
        tab.snp.makeConstraints { (mk) in
            mk.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let con = self.fatherVc() {
            return con.mainVm.invateMainDatasource.count
        }
        if let con = self.fatherVcs() {
            return con.mainVm.getAllOutPerson().count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = InvatePersonSingleCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "IIWebEXInvateTabVw", fatherVw: self)
        if let con = self.fatherVc() {
            cell.setData(model: con.mainVm.invateMainDatasource[indexPath.row], isLast: indexPath.row == con.mainVm.invateMainDatasource.count - 1)
        }
        if let con = self.fatherVcs() {
            cell.setData(model: con.mainVm.getAllOutPerson()[indexPath.row], isLast: indexPath.row == con.mainVm.getAllOutPerson().count - 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func fatherVc() -> InvitePersonViewController? {
        if let con = self.iiViewController() as? InvitePersonViewController {
            return con
        }
        return nil
    }
    
    func fatherVcs() -> IIWebEXInviteOutPersonViewController? {
        if let con = self.iiViewController() as? IIWebEXInviteOutPersonViewController {
            return con
        }
        return nil
    }
    
    func remakeVw() {
        if let con = self.fatherVc() {
            let heighMax = APPUIConfig.aHeight - APPUIConfig.naviHeight - 100
            let realHeight = (44 * CGFloat(con.mainVm.invateMainDatasource.count)) >= heighMax ? heighMax : (44 * CGFloat(con.mainVm.invateMainDatasource.count))
            self.snp.remakeConstraints { (make) in
                make.left.equalTo(0)
                make.height.equalTo(realHeight)
                make.top.equalTo(APPUIConfig.naviHeight)
                make.right.equalTo(0)
            }
        }
        if let con = self.fatherVcs() {
            let heighMax = APPUIConfig.aHeight - APPUIConfig.naviHeight - 90
            let realHeight = (44 * CGFloat(con.mainVm.getAllOutPerson().count)) >= heighMax ? heighMax : (44 * CGFloat(con.mainVm.getAllOutPerson().count))
            self.snp.remakeConstraints { (make) in
                make.left.equalTo(0)
                make.height.equalTo(realHeight)
                make.top.equalTo(APPUIConfig.naviHeight)
                make.right.equalTo(0)
            }
        }
        
    }
}
