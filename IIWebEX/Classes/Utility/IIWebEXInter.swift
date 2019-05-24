//
//  IIWebEXInter.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/10/13.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

/// webex-国际化处理
class IIWebEXInter {
    /*
     iiwebex_whoseMeet  的会议
     iiwebex_starttime  开始时间
     iiwebex_durationtime 持续时间
     iiwebex_attendees 受邀请者
     iiwebex_pwd 密码
     iiwebex_setting 设置
     iiwebex_hours 小时
     iiwebex_mins 分钟
     iiwebex_person 人
     iiwebex_startjoin 开始
     iiwebex_joinstart 加入
     iiwebex_years 年
     iiwebex_months 月
     iiwebex_days 日
     iiwebex_invateCount 你可一次邀请人
     iiwebex_arrange 安排
     iiwebex_completed 完成
     iiwebex_setPwdTxt 设置密码
     iiwebex_addAttendees 添加受邀者
     iiwebex_addAttenderEmail 添加参加者的邮件地址
     iiwebex_myMeet 我的会议
     iiwebex_meetDetailInfo 会议信息
     iiwebex_meetHost 主持人
     iiwebex_meetTime 时间
     iiwebex_meetNo 会议号
     iiwebex_meetPwd 会议密码
     iiwebex_addPersonEmail 输入或选择参加者的邮件地址
     iiwebex_createSuccess 创建成功
     */
    
    static let timerName = "WEBEXMeetingListViewControllerTimerCreate"
    
    lazy var iiwebex_whoseMeet = getI18NStr(key: III18NEnum.iiwebex_whoseMeet.rawValue)
    lazy var iiwebex_starttime = getI18NStr(key: III18NEnum.iiwebex_starttime.rawValue)
    lazy var iiwebex_durationtime = getI18NStr(key: III18NEnum.iiwebex_durationtime.rawValue)
    lazy var iiwebex_attendees = getI18NStr(key: III18NEnum.iiwebex_attendees.rawValue)
    lazy var iiwebex_pwd = getI18NStr(key: III18NEnum.iiwebex_pwd.rawValue)
    lazy var iiwebex_setting = getI18NStr(key: III18NEnum.iiwebex_setting.rawValue)
    lazy var iiwebex_hours = getI18NStr(key: III18NEnum.iiwebex_hours.rawValue)
    lazy var iiwebex_mins = getI18NStr(key: III18NEnum.iiwebex_mins.rawValue)
    lazy var iiwebex_person = getI18NStr(key: III18NEnum.iiwebex_person.rawValue)
    lazy var iiwebex_startjoin = getI18NStr(key: III18NEnum.iiwebex_startjoin.rawValue)
    lazy var iiwebex_joinstart = getI18NStr(key: III18NEnum.iiwebex_joinstart.rawValue)
    lazy var iiwebex_years = getI18NStr(key: III18NEnum.iiwebex_years.rawValue)
    lazy var iiwebex_months = getI18NStr(key: III18NEnum.iiwebex_months.rawValue)
    lazy var iiwebex_days = getI18NStr(key: III18NEnum.iiwebex_days.rawValue)
    lazy var iiwebex_invateCount = getI18NStr(key: III18NEnum.iiwebex_invateCount.rawValue)
    lazy var iiwebex_arrange = getI18NStr(key: III18NEnum.iiwebex_arrange.rawValue)
    lazy var iiwebex_completed = getI18NStr(key: III18NEnum.iiwebex_completed.rawValue)
    lazy var iiwebex_setPwdTxt = getI18NStr(key: III18NEnum.iiwebex_setPwdTxt.rawValue)
    lazy var iiwebex_addAttendees = getI18NStr(key: III18NEnum.iiwebex_addAttendees.rawValue)
    lazy var iiwebex_addAttenderEmail = getI18NStr(key: III18NEnum.iiwebex_addAttenderEmail.rawValue)
    lazy var iiwebex_myMeet = getI18NStr(key: III18NEnum.iiwebex_myMeet.rawValue)
    lazy var iiwebex_meetDetailInfo = getI18NStr(key: III18NEnum.iiwebex_meetDetailInfo.rawValue)
    lazy var iiwebex_meetHost = getI18NStr(key: III18NEnum.iiwebex_meetHost.rawValue)
    lazy var iiwebex_meetTime = getI18NStr(key: III18NEnum.iiwebex_meetTime.rawValue)
    lazy var iiwebex_meetNo = getI18NStr(key: III18NEnum.iiwebex_meetNo.rawValue)
    lazy var iiwebex_meetPwd = getI18NStr(key: III18NEnum.iiwebex_meetPwd.rawValue)
    lazy var iiwebex_addPersonEmail = getI18NStr(key: III18NEnum.iiwebex_addPersonEmail.rawValue)
    lazy var iiwebex_none = getI18NStr(key: III18NEnum.iiwebex_none.rawValue)
    lazy var iiwebex_loading = getI18NStr(key: III18NEnum.common_update.rawValue)
    lazy var iiwebex_createSuccess = getI18NStr(key: III18NEnum.iiwebex_createSuccess.rawValue)
    lazy var iiwebex_hostKey = getI18NStr(key: III18NEnum.iiwebex_hostKey.rawValue)
    lazy var iiwebex_mineTxt = getI18NStr(key: III18NEnum.iiwebex_mineTxt.rawValue)
    lazy var iiwebex_deltip = getI18NStr(key: III18NEnum.iiwebex_deltip.rawValue)
    lazy var iiwebex_deltil = getI18NStr(key: III18NEnum.iiwebex_deltil.rawValue)
    lazy var iiwebex_delfir = getI18NStr(key: III18NEnum.iiwebex_delfir.rawValue)
    lazy var iiwebex_delcal = getI18NStr(key: III18NEnum.iiwebex_delcal.rawValue)
    lazy var iiwebex_pwderrorInfo = getI18NStr(key: III18NEnum.iiwebex_pwderrorInfo.rawValue)
    lazy var iiwebex_pwdsuggectTitle = getI18NStr(key: III18NEnum.iiwebex_pwdsuggectTitle.rawValue)
    lazy var iiwebex_noContentSubTxt = getI18NStr(key: III18NEnum.iiwebex_noContentSubTxt.rawValue)
    lazy var iiwebex_today = getI18NStr(key: III18NEnum.iiwebex_today.rawValue)
    lazy var iiwebex_selectPersonFromList = getI18NStr(key: III18NEnum.iiwebex_selectPersonFromList.rawValue)
    lazy var iiwebex_createSave = getI18NStr(key: III18NEnum.iiwebex_createSave.rawValue)
    lazy var iiwebex_meettitleAlert = getI18NStr(key: III18NEnum.iiwebex_meettitleAlert.rawValue)
    lazy var iiwebex_meetDownloadApp = getI18NStr(key: III18NEnum.iiwebex_meetDownloadApp.rawValue)
    lazy var iiwebex_meetDownloadConfirm = getI18NStr(key: III18NEnum.iiwebex_meetDownloadConfirm.rawValue)
    //超过了建议选择人数限制
    lazy var iiwebex_moreThan20Person = getI18NStr(key: III18NEnum.iiwebex_moreThan20Person.rawValue)
    //内部参会人
    lazy var iiwebex_innerPerson = getI18NStr(key: III18NEnum.iiwebex_innerPerson.rawValue)
    //外部参会人
    lazy var iiwebex_outerPerson = getI18NStr(key: III18NEnum.iiwebex_outerPerson.rawValue)
    //添加外部参会人
    lazy var iiwebex_addOuterPersonTitle = getI18NStr(key: III18NEnum.iiwebex_addOuterPersonTitle.rawValue)
    //添加
    lazy var iiwebex_addOuterPersonAdd = getI18NStr(key: III18NEnum.iiwebex_addOuterPersonAdd.rawValue)
    //联系人已经存在
    lazy var iiwebex_outPersonisExists = getI18NStr(key: III18NEnum.iiwebex_outPersonisExists.rawValue)
    //xx前無會議
    lazy var iiwebex_beforeNoMeet = getI18NStr(key: III18NEnum.iiwebex_beforeNoMeet.rawValue)
    //內部分享
    lazy var iiwebex_innerShare = getI18NStr(key: III18NEnum.iiwebex_innerShare.rawValue)
    //郵箱格式不對
    lazy var iiwebex_emailError = getI18NStr(key: III18NEnum.iiwebex_emailError.rawValue)
    //選人
    lazy var iiwebex_selectAttendees = getI18NStr(key: III18NEnum.iiwebex_selectAttendees.rawValue)
    //信息已經複製
    lazy var iiwebex_setPasteInfo = getI18NStr(key: III18NEnum.iiwebex_setPasteInfo.rawValue)
    /// 只包含數字和m字母
    lazy var iiwebex_pwdCharError = getI18NStr(key: III18NEnum.iiwebex_pwdCharError.rawValue)
    /// 分享
    lazy var app_share_txt = getI18NStr(key: III18NEnum.app_share_txt.rawValue)
    /// 删除
    lazy var app_delete_txt = getI18NStr(key: III18NEnum.app_delete_txt.rawValue)
}
