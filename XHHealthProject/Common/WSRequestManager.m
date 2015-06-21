//
//  WSRequestManager.m
//  WebServiceDemo
//
//  Created by art_kernel_zyc on 14/12/15.
//  Copyright (c) 2014年 art_kernel_zyc. All rights reserved.
//

#import "WSRequestManager.h"


@implementation WSRequestManager
+(void)webServiceConfigureDomain:(NSString *)domain
{
    if(domain)
    {
        [WSURLRequest webServiceConfigureDomain:domain];
    }
}



+(void)WSrequestNameSpace:(NSString *)space MethodName:(NSString *)methodName andSoapAction:(NSString *)soapAction andKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andParameterType:(NSDictionary *)parameterType successRequest:(SuccessRequest)successBlock failedRequest:(FailedRequest)failedBlock
{
    WSURLRequest *request = [[WSURLRequest alloc]init];
    [request WSrequestNameSpace:space MethodName:methodName andSoapAction:soapAction andKeyArr:keyArr andValueArr:valueArr andParameterType:parameterType successRequest:successBlock failedRequest:failedBlock];
}


+(void)XHGetRequestParameters:(NSDictionary *)parameters withMethodName:(NSString *)methodName SuccessRequest:(SuccessRequestBlock)successBlock FailRequest:(FailRequestBlock)failBlock
{
    XHHealthRequest *request = [[XHHealthRequest alloc]init];
    [request getRequestParameters:parameters withMethodName:methodName SuccessRequest:successBlock FailRequest:failBlock];
}


@end
