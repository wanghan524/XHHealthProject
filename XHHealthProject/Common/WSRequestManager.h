//
//  WSRequestManager.h
//  WebServiceDemo
//
//  Created by art_kernel_zyc on 14/12/15.
//  Copyright (c) 2014年 art_kernel_zyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSURLRequest.h"
#import "XHHealthRequest.h"



@interface WSRequestManager : NSObject

+(void)webServiceConfigureDomain:(NSString *)domain;




/**
 *  最终版请求方式
 */
+(void)WSrequestNameSpace:(NSString *)space MethodName:(NSString*)methodName andSoapAction:(NSString *)soapAction andKeyArr:(NSArray*)keyArr andValueArr:(NSArray *)valueArr andParameterType:(NSDictionary*)parameterType successRequest:(SuccessRequest)successBlock failedRequest:(FailedRequest)failedBlock;





+(void)XHGetRequestParameters:(NSDictionary *)parameters withMethodName:(NSString *)methodName SuccessRequest:(SuccessRequestBlock)successBlock FailRequest:(FailRequestBlock)failBlock;

@end
