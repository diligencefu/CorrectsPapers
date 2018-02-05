//
//  WeChatPay_Header.h
//  CorrectsPapers
//
//  Created by RongXing on 2017/12/8.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

#ifndef WeChatPay_Header_h
#define WeChatPay_Header_h

#pragma mark -
#pragma mark - 微信支付配置参数

// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
#define WX_APPID @"wxee4f5f10143d1da2"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
#define WX_APPSecret @"a475e492d8f21801df64a8ed9c006a5c"
// 微信支付商户号
#define MCH_ID  @"1493756792"


#pragma mark -
#pragma mark - 统一下单请求参数键值

//  应用id
#define WXAPPID @"appid"
//  商户号
#define WXMCHID @"mch_id"
//  随机字符串1493754792
#define WXNONCESTR @"nonce_str"
//  签名
#define WXSIGN @"sign"
//  商品描述
#define WXBODY @"body"
//  商户订单号
#define WXOUTTRADENO @"out_trade_no"
//  总金额
#define WXTOTALFEE @"total_fee"
//  终端IP
#define WXEQUIPMENTIP @"spbill_create_ip"
//  通知地址
#define WXNOTIFYURL @"notify_url"
//  交易类型
#define WXTRADETYPE @"trade_type"
//  预支付交易会话
#define WXPREPAYID @"prepay_id"

//  这是API密钥
#define WechatAPIKey @"LPJCdQIBADANBgkqhkiG9w8BAQEFAASC"


#pragma mark -
#pragma mark - 微信下单接口

//  微信统一下单接口连接
#define WXUNIFIEDORDERURL @"https://api.mch.weixin.qq.com/pay/unifiedorder"
#define WeChatPay @"https://api.mch.weixin.qq.com/pay/unifiedorder"//微信支付下单接口
#endif /* PrefixHeader_pch */

//作者：lyoniOS
//链接：http://www.jianshu.com/p/af8cbc9d51b0
//來源：简书
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

