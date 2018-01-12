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
- (BOOL)isUrl;
@end
