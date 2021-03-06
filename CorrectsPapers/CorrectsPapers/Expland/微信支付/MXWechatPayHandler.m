/**
 @@create by 刘智援 2016-11-28
 
 @简书地址:    http://www.jianshu.com/users/0714484ea84f/latest_articles
 @Github地址: https://github.com/lyoniOS
 @return MXWechatPayHandler（微信调用工具类）
 */

#import "MXWechatPayHandler.h"
#import <CommonCrypto/CommonDigest.h>
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#import "AFNetworkActivityIndicatorManager.h"
#else
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#endif
///用户获取设备ip地址
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <Foundation/Foundation.h>
#import "WXApiObject.h"
#import "MXWechatSignAdaptor.h"
#import "WeChatPay_Header.h"
#import "WXApi.h"
#import "XMLDictionary.h"

@implementation MXWechatPayHandler

#pragma mark - Public Methods

+(void)jumpToWxPaywithPrice:(CGFloat)price andTypeName:(NSString *)typeName andOrderNo:(NSString *)orderNo
{
    //============================================================
    // 支付流程实现
    // 客户端操作     (实际操作应由服务端操作)
    //============================================================
    NSString *tradeType = @"APP";                                       //交易类型
    NSString *totalFee  = [NSString stringWithFormat:@"%d",(int)(price*100)];                                         //交易价格1表示0.01元，10表示0.1元
    NSString *tradeNO   = [self generateTradeNO];                       //随机字符串变量 这里最好使用和安卓端一致的生成逻辑
    NSString *addressIP = [self fetchIPAddress];                        //设备IP地址,请再wifi环境下测试,否则获取的ip地址为error,正确格式应该是8.8.8.8
    
    int value = (arc4random() % 8) + 1;
    NSString *str=[NSString stringWithFormat:@"%ld+%d",time(0),value];
    NSString *md5Str=[self md5:str];
    [[NSUserDefaults standardUserDefaults] setObject:md5Str forKey:WXOUTTRADENO];
//    NSString *orderNo   = md5Str;   //随机产生订单号用于测试，正式使用请换成你从自己服务器获取的订单号
//    NSString *orderNo   = [NSString stringWithFormat:@"%ld",time(0)];   //随机产生订单号用于测试，正式使用请换成你从自己服务器获取的订单号
    NSString *notifyUrl = @"http://wxpay.weixin.qq.com";// 交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
    
    //获取SIGN签名
    MXWechatSignAdaptor *adaptor = [[MXWechatSignAdaptor alloc] initWithWechatAppId:WX_APPID
                                                                        wechatMCHId:MCH_ID
                                                                            tradeNo:tradeNO
                                                                   wechatPartnerKey:WechatAPIKey
                                                                           payTitle:typeName
                                                                            orderNo:orderNo
                                                                           totalFee:totalFee
                                                                           deviceIp:addressIP
                                                                          notifyUrl:notifyUrl
                                                                          tradeType:tradeType];

    //转换成XML字符串,这里只是形似XML，实际并不是正确的XML格式，需要使用AF方法进行转义
    NSString *string = [[adaptor dic] XMLString];

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    // 这里传入的XML字符串只是形似XML，但不是正确是XML格式，需要使用AF方法进行转义
    session.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [session.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [session.requestSerializer setValue:WeChatPay forHTTPHeaderField:@"SOAPAction"];
    [session.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return string;
    }];
    
    [session POST:WeChatPay
       parameters:string
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         //  输出XML数据
         NSString *responseString = [[NSString alloc] initWithData:responseObject
                                                          encoding:NSUTF8StringEncoding] ;
         //  将微信返回的xml数据解析转义成字典
         NSDictionary *dic = [NSDictionary dictionaryWithXMLString:responseString];
         
         // 判断返回的许可
         if ([[dic objectForKey:@"result_code"] isEqualToString:@"SUCCESS"]
             &&[[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
             // 发起微信支付，设置参数
             PayReq *request = [[PayReq alloc] init];
             request.openID = [dic objectForKey:WXAPPID];
             request.partnerId = [dic objectForKey:WXMCHID];
             request.prepayId= [dic objectForKey:WXPREPAYID];
             request.package = @"Sign=WXPay";
             request.nonceStr= [dic objectForKey:WXNONCESTR];
             
             // 将当前时间转化成时间戳
             NSDate *datenow = [NSDate date];
             NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
             UInt32 timeStamp =[timeSp intValue];
             request.timeStamp= timeStamp;
             
             // 签名加密                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
             MXWechatSignAdaptor *md5 = [[MXWechatSignAdaptor alloc] init];
             
             request.sign=[md5 createMD5SingForPay:request.openID
                                         partnerid:request.partnerId
                                          prepayid:request.prepayId
                                           package:request.package
                                          noncestr:request.nonceStr
                                         timestamp:request.timeStamp];             
             // 调用微信
             [WXApi sendReq:request];
         }else
         {
//             [MBProgressHUD showError:@"支付失败"];
             
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
     }];
    
    
}

+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    //    CC_MD5(cStr, strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;

}

#pragma mark - Private Method
/**
 ------------------------------
 产生随机字符串
 ------------------------------
 1.生成随机数算法 ,随机字符串，不长于32位
 2.微信支付API接口协议中包含字段nonce_str，主要保证签名不可预测。
 3.我们推荐生成随机数算法如下：调用随机数函数生成，将得到的值转换为字符串。
 */
+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    //  srand函数是初始化随机数的种子，为接下来的rand函数调用做准备。
    //  time(0)函数返回某一特定时间的小数值。
    //  这条语句的意思就是初始化随机数种子，time函数是为了提高随机的质量（也就是减少重复）而使用的。
    
    //　srand(time(0)) 就是给这个算法一个启动种子，也就是算法的随机种子数，有这个数以后才可以产生随机数,用1970.1.1至今的秒数，初始化随机数种子。
    //　Srand是种下随机种子数，你每回种下的种子不一样，用Rand得到的随机数就不一样。为了每回种下一个不一样的种子，所以就选用Time(0)，Time(0)是得到当前时时间值（因为每时每刻时间是不一样的了）。
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
    srand(time(0)); // 此行代码有警告:
#pragma clang diagnostic pop
    for (int i = 0; i < kNumber; i++) {
        
        unsigned index = rand() % [sourceStr length];
        
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

/**
 ------------------------------
 获取设备ip地址
 ------------------------------
 1.貌似该方法获取ip地址只能在wifi状态下进行
 */
+ (NSString *)fetchIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
@end
