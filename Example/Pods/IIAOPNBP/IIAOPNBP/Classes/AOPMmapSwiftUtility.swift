//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// AOPMmapSwiftUtility.swift
//
// Created by    Noah Shan on 2018/11/8
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation
import IISwiftBaseUti

class AOPMmapSwiftUtility: NSObject {
    override init() {
        super.init()
    }

    /*
     方法此处需要添加到串行队列中-尽量是高优先级的线程
     目前统一放到主线程中即可，因为ios主线程是一个串行队列，不必担心内存映射内容覆盖问题

     filename目前规则为nsuuid.string:如果当前映射的地址空间未使用完毕，则此参数无用，继续使用空间
     如果空间不足以存储写入的内容，则使用此参数创建文件系统并映射进内存
     目前映射地址空间为  1Mb

     content为需要写入的内容：目前仅使用UTF-8编码格式
     */
    static func write2MmapFileSys(name filename: String, fileContent content: String) {

        GCDUtils.toMianThreadProgressSome {
            AOPMmapOCUtility.writeData(filename, fileContent: content)
        }
    }
}
