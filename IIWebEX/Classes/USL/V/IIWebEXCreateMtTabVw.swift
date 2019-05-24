//
//  CreateMtTabVw.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

class CreateMtTabVw: UIView {
    
    var mainTab: UITableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    
    var cells: [IndexPath: CreateMtTabCell] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createVw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVw() {
        self.addSubview(mainTab)
        mainTab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        self.mainTab.delegate = self
        self.mainTab.dataSource = self
        self.mainTab.separatorStyle = .none
        self.mainTab.estimatedRowHeight = 0
        self.mainTab.estimatedSectionHeaderHeight = 0
        self.mainTab.estimatedSectionFooterHeight = 0
    }
    
    /// 返回父控制器
    func getFatherVc() -> CreateMeetingViewController? {
        if let vc = self.iiViewController() as? CreateMeetingViewController {
            return vc
        }
        return nil
    }
    
    /// 设置开始时间 & 持续时间
    func setStartTimeAndDuration(startTime: String?, duration: String?) {
        cells[IndexPath(item: 0, section: 1)]?.setData(title: nil, subTitle: startTime)
        cells[IndexPath(item: 1, section: 1)]?.setData(title: nil, subTitle: duration)
    }
    
    /// 设置手邀请者个数
    func setInvatorStr(str: String) {
        cells[IndexPath(item: 0, section: 2)]?.setData(title: nil, subTitle: str)
    }
}

extension CreateMtTabVw: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = self.getFatherVc()?.mainVm.getNumberOfSectionCount() else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.getFatherVc()?.mainVm.getNumberOfRowCount(with: section) else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = "CreateMtTabVwCellReuseID"
        let cell = CreateMtTabCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseID)
        guard let dataInfo = self.getFatherVc()?.mainVm.getData(with: indexPath) else {
            return cell
        }
        cell.setData(title: dataInfo.title, subTitle: dataInfo.subTitle)
        cell.addArrow(isHave: dataInfo.arrow)
        cell.setTopAndBottomLine(type: dataInfo.lineType)
        cell.setCouldEdit(could: dataInfo.couldeEdid)
        self.cells[indexPath] = cell
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.titleChangeAction = { [weak self] str in
                self?.getFatherVc()?.mainVm.models.confName = str
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //隐藏键盘
        if indexPath.section == 0 && indexPath.row == 0 {
            
        } else {
            (tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? CreateMtTabCell)?.titleLb.resignFirstResponder()
        }
        
        if let con = self.getFatherVc()?.mainVm.didRow(at: indexPath) {
            self.iiViewController()?.navigationController?.pushViewController(con, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
}
