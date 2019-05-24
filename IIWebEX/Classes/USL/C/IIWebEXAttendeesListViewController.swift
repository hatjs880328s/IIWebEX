//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IIWebEXAttendeesListViewController.swift
//
// Created by    Noah Shan on 2018/10/27
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import UIKit

/// 某个会议参会人列表vc
class IIWebEXAttendeesListViewController: BaseViewController {

    var tab: UITableView = UITableView(frame: CGRect.zero)

    var vm: IIWebAttendeesListVM = IIWebAttendeesListVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = IIWebEXInter().iiwebex_attendees
        self.view.backgroundColor = UIColor.white
        self.addNavLeftButtonNormalImage(UIImage(named: "back_before"), navLeftButtonSelectedImage: UIImage(named: "back_after"))
        createVw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createVw() {
        self.view.addSubview(tab)
        tab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
    }
}

extension IIWebEXAttendeesListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.tabDatasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = IIWebEXAttendeesListCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "IIWebEXAttendeesListViewControllerreusid")
        cell.setData(model: self.vm.tabDatasource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
