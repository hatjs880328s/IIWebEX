//
//  MeetingListViewController.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/11.
//  Copyright © 2018 Elliot. All rights reserved.
//

import UIKit

/// 会议列表
class WEBEXMeetingListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    var mainTab: UITableView = UITableView()
    
    var mainVm = ListTabVM()
    
    let titleTxt = IIWebEXInter().iiwebex_myMeet
    
    var each10SecTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVw()
        createVw()
        createVm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        each10SecTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.each10SecReloadData), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        each10SecTimer?.invalidate()
        each10SecTimer = nil
    }
    
    func initVw() {
        self.title = titleTxt
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "webex_meetingadd"), style: UIBarButtonItem.Style.done, target: self, action: #selector(self.goCreatingMt))
        self.addNavLeftButtonNormalImage(UIImage(named: "back_before"), navLeftButtonSelectedImage: UIImage(named: "back_after"))
    }
    
    /// 每30S搞一次狀態
    @objc func each10SecReloadData() {
        //NotificationCenter.default.post(name: NSNotification.Name.init(IIWebEXInter.timerName), object: nil, userInfo: nil)
        self.mainVm.initData(alert: false)
    }
    
    @objc func goCreatingMt() {
        let con = CreateMeetingViewController()
        con.createSuccessBackAction = { [weak self] in
            self?.createVm()
        }
        self.navigationController?.pushViewController(con, animated: true)
    }
    
    func createVw() {
        self.view.addSubview(mainTab)
        mainTab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        mainTab.delegate = self
        mainTab.dataSource = self
        mainTab.separatorStyle = .none
        self.mainTab.estimatedRowHeight = 0
        self.mainTab.estimatedSectionHeaderHeight = 0
        self.mainTab.estimatedSectionFooterHeight = 0
        mainTab.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            //头部刷新
            self?.mainVm.initData(alert: true)
        })
    }
    
    func createVm() {
        self.mainVm.reloadAction = {[weak self] in
            self?.mainTab.iiwebEXTabReload(isZeroCount: self?.mainVm.tabDatasource.count == 0)
            self?.mainTab.mj_header.endRefreshing()
        }
        self.mainVm.initData(alert: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainVm.tabDatasource[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mainVm.tabDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = "MeetingListViewControllerReuseID"
        let cell = ListTabCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseID)
        cell.setData(info: self.mainVm.tabDatasource[indexPath.section][indexPath.row], isLast: self.mainVm.isLastItemEachSection(index: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let con = WEBEXMeetingDetailViewController()
        con.delSuccessBackAction = { [weak self] in
            self?.mainVm.initData(alert: true)
        }
        con.meetModel = self.mainVm.tabDatasource[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(con, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vi = UIView()
        vi.frame = CGRect(x: 0, y: 0, width: APPUIConfig.aWeight, height: 35)
        //left week lb
        let titleLb = UILabel()
        titleLb.font = APPUIConfig.uiFont(with: 14)
        vi.addSubview(titleLb)
        vi.backgroundColor = APPUIConfig.bgLightGray
        titleLb.frame = CGRect(x: 16, y: 0, width: APPUIConfig.aWeight, height: 35)
        titleLb.text = self.mainVm.getTitleWith(section: section).0
        //mine lb
        let mineLb = UILabel()
        mineLb.font = APPUIConfig.uiFont(with: 14)
        vi.addSubview(mineLb)
        vi.backgroundColor = APPUIConfig.bgLightGray
        mineLb.frame = CGRect(x: 16, y: 0, width: APPUIConfig.aWeight - 32, height: 35)
        mineLb.textAlignment = .right
        mineLb.text = self.mainVm.getTitleWith(section: section).1
        return vi
    }
    
    deinit {
        print("iiwebex list vc deinit...")
    }

}

extension UITableView {
    func iiwebEXTabReload(isZeroCount: Bool) {
        if isZeroCount {
            let emptyVw = IIWebEXListEmptyVw(frame: CGRect.zero)
            emptyVw.frame.size = self.frame.size
            emptyVw.frame.origin = CGPoint(x: 0, y: 0)
            self.backgroundView = emptyVw
        } else {
            self.backgroundView = nil
        }
        self.reloadData()
    }
}
