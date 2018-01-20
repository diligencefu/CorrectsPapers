//
//  OCTools.h
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface OCTools : NSObject

//渲染动画
- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration;


//获取有效地址
+(NSURL *)getEfficientAddress:(NSString *)string;


//多位数加,号
- (NSString *)positiveFormat:(NSString *)text;


//手机号正则
+(BOOL)checkoutPhoneNum:(NSString *)phoneNum;

- (BOOL)isUrl;

/**
 *  验证身份证号
 *
 *  @param cardNo 身份证号
 *
 *  @return 是否正确
 */
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;

@end
