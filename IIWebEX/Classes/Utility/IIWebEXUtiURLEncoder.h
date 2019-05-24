//
//  IIWebEXUtiURLEncoder.h
//  impcloud
//
//  Created by Noah_Shan on 2018/10/10.
//  Copyright © 2018 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

// < 此处添加这俩文件是为了让swift代码可使用sd库>
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImage/SDWebImageManager.h"
//[[UIApplication sharedApplication].keyWindow makeToast:str duration:1.0 position:CSToastPositionCenter];

@interface NSString (URL)

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

@end
