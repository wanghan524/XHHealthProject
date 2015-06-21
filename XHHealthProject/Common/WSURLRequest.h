//
//  WSRequest.h
//
//
//  Created by art_kernel_zyc on 14/12/15.
//  Copyright (c) 2014年 art_kernel_zyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceDefine.h"




typedef void (^SuccessRequest)(id data);
typedef void (^SuccessRequestWithNoteID)(id data, NSString *noteID);
typedef void (^FailedRequest)(NSError *error);
typedef void (^FailedRequestWithNoteID)(NSError *error,NSString *noteID);
typedef void (^ReceiveDataProgress)(NSUInteger expectLength,NSUInteger currentLength);

typedef void (^ReceiveDataProgressWithNoteID)(NSUInteger expectLength,NSUInteger currentLength,NSString *noteID);


static NSString *GlobalWebServiceURL = nil;
static NSString *GlobalWebServiceNameSpace = nil;

@interface WSURLRequest : NSObject

@property(nonatomic,copy)NSString *method;
/*!
 * @brief 开始请求之前，先配置webService服务器地址
 * @param url 设置webService服务器地址
 */
+(void)webServiceConfigureDomain:(NSString *)domain;

/*!
 * @brief 开始请求
 * @param nameSpace 设置服务器的命名空间
 * @param methodName 设置接口的方法名字
 * @param soapAction 设置接口的soapAction
 * @param parameterDic 设置接口的参数，该参数是字典类型的，key 对应 value，即 参数名：值 此值可以为nil，代表没有参数
 * @param parameterType 设置接口的参数的类型，默认为字符串，可以为nil，如果为nil的话，代表字符串
 * @param successBlock 请求成功后的回调
 * @param failedBlock 请求失败后的回调
 */
-(void)WSRequestNameSpace:(NSString *)nameSpace MethodName:(NSString *)methodName andSoapAction:(NSString *)soapAction andParameter:(NSDictionary *)parameterDic andParameterType:(NSDictionary*)parameterType successRequest:(SuccessRequest)successBlock failedRequest:(FailedRequest)failedBlock;

/**
 *  最终版请求
 *
 *  @param space         命名空间
 *  @param methodName    接口方法名字
 *  @param soapAction    soapaction
 *  @param keyArr        所有接口参数
 *  @param valueArr      接口参数对应的值
 *  @param parameterType 参数的类型，是字典类型的
 *  @param successBlock  successBlock description
 *  @param failedBlock   failedBlock description
 */

-(void)WSrequestNameSpace:(NSString *)space MethodName:(NSString*)methodName andSoapAction:(NSString *)soapAction andKeyArr:(NSArray*)keyArr andValueArr:(NSArray *)valueArr andParameterType:(NSDictionary*)parameterType successRequest:(SuccessRequest)successBlock failedRequest:(FailedRequest)failedBlock;




-(void)WSrequestNameSpace:(NSString *)space MethodName:(NSString*)methodName andSoapAction:(NSString *)soapAction andKeyArr:(NSArray*)keyArr andValueArr:(NSArray *)valueArr andParameterType:(NSDictionary*)parameterType successRequest:(SuccessRequest)successBlock failedRequest:(FailedRequest)failedBlock andResponseType:(RETURNTYPE)type;






@end
