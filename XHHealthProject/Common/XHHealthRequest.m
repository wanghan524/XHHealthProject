//
//  XHHealthRequest.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/17.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "XHHealthRequest.h"
#import "InterfaceDefine.h"
#import "GDataXMLNode.h"
@interface XHHealthRequest ()<NSURLConnectionDataDelegate>
@property(nonatomic,copy)SuccessRequestBlock sucessRequestB;
@property(nonatomic,copy)FailRequestBlock failRequestB;
@property(nonatomic,strong)NSURL *baseUrl;
@property(nonatomic,strong)NSString *methodName;
@property(nonatomic,strong)NSURLConnection *connection;
@property(nonatomic,strong)NSMutableURLRequest *request;
@property(nonatomic,strong)NSMutableData *muData;


@end


@implementation XHHealthRequest

-(void)getRequestParameters:(NSDictionary *)parameters withMethodName:(NSString *)methodName SuccessRequest:(SuccessRequestBlock)successBlock FailRequest:(FailRequestBlock)failBlock
{
    if(self.connection != nil)
    {
        [self.connection cancel];
        self.connection = nil;
    }
    if(self.baseUrl != nil)
    {
        self.baseUrl = nil;
    }
    
    NSMutableString *urlMuString = [[NSMutableString alloc]init];
    [urlMuString appendString:WEBSERVICEDOMAIN];
    [urlMuString appendString:@"/"];
    [urlMuString appendString:methodName];
    
    NSArray *keyArr = [parameters allKeys];
    if([keyArr count] == 0)
    {
    }
    else
    {
        [urlMuString appendString:@"?"];
    }
    NSUInteger count = [keyArr count];
    for(NSString *key in keyArr)
    {
        NSString *tmpValue = [NSString stringWithFormat:@"%@=%@",key,[parameters objectForKey:key]];
        [urlMuString appendString:tmpValue];
        count = count - 1;
        if(count >= 1)
        {
            [urlMuString appendString:@"&"];
        }
        
    }
    
    self.baseUrl = [NSURL URLWithString:urlMuString];
    self.methodName = methodName;
    if(successBlock)
    {
        self.sucessRequestB = [successBlock copy];
    }
    if(failBlock)
    {
        self.failRequestB = [failBlock copy];
    }
    
    self.request = [[NSMutableURLRequest alloc]initWithURL:self.baseUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    self.connection = [[NSURLConnection alloc]initWithRequest:self.request delegate:self];
    [self.connection start];

    
}






-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(self.failRequestB)
    {
        self.failRequestB(self.muData,error);
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.muData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(self.muData != nil)
    {
        NSRange range = NSMakeRange(0, self.muData.length);
        [self.muData resetBytesInRange:range];
        self.muData = nil;
    }
    self.muData = [[NSMutableData alloc]initWithCapacity:0];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(self.sucessRequestB)
    {
        
        NSString *xmlStr = [[NSString alloc]initWithData:self.muData encoding:NSUTF8StringEncoding];
        self.muData = [self xmlParseData:self.muData andMethodName:self.methodName];
        
        self.sucessRequestB(self.muData);
    }
}

#pragma mark xmlParse start
-(NSData *)xmlParseData:(NSMutableData *)muData andMethodName:(NSString *)methodName
{
    NSError *error = nil;
    NSData *returnData = nil;
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithXMLString:[[NSString alloc]initWithData:[muData copy] encoding:NSUTF8StringEncoding] options:0 error:&error];
    if(error)
    {
        DLog(@"%@",error);
        NSAssert(1<0, @"有错误");
    }
    //.....
    GDataXMLElement *root = [doc rootElement];
    
    GDataXMLElement *body = (GDataXMLElement *)[root childAtIndex:0];
    
    returnData = [body.stringValue dataUsingEncoding:NSUTF8StringEncoding];
    return returnData;
}
#pragma mark xmlParse end









@end
