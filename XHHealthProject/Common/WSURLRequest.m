//
//  WSRequest.m
//  WebServiceDemo
//
//  Created by art_kernel_zyc on 14/12/15.
//  Copyright (c) 2014年 art_kernel_zyc. All rights reserved.
//

#import "WSURLRequest.h"
#import "GDataXMLNode.h"


@interface WSURLRequest ()<NSURLConnectionDataDelegate>
{
    NSURLConnection *_conncetion;
    NSURL *_url;
    NSMutableURLRequest *_mutableRequest;
    NSMutableData *_mutabData;
    
    SuccessRequest _successBlock;
    FailedRequest _failedBlock;
    
    //方法名 用于解析返回后的xml文档
    NSString *_methodNameStr;
    
    RETURNTYPE _xmlOrJson;
    
    ReceiveDataProgress _receiveProgressBlock;
    
    NSUInteger expectedLength;
    NSUInteger currentLength;
    
    //用于上传笔记的请求
    SuccessRequestWithNoteID _successWithNoteBlock;
    FailedRequestWithNoteID _failedWithNoteBlock;
    
    ReceiveDataProgressWithNoteID _receiveWithNoteIDDataBlock;
}
@property(nonatomic,strong)NSURLConnection *connection;
@property(nonatomic,strong)NSURL *url;
@property(nonatomic,strong)NSMutableURLRequest *mutableRequest;
@property(nonatomic,strong)NSMutableData *mutabData;
@property(nonatomic,copy)SuccessRequest successBlock;
@property(nonatomic,copy)FailedRequest failedBlock;
@property(nonatomic,copy)ReceiveDataProgress receiveDataBlock;
@property(nonatomic,copy)SuccessRequestWithNoteID successWithNoteBlock;
@property(nonatomic,copy)FailedRequestWithNoteID failedWithNoteBlock;
@property(nonatomic,copy)ReceiveDataProgressWithNoteID receiveWithNoteIDDataBlock;
@property(nonatomic,copy)NSString *noteIDStr;

@property(nonatomic,copy)NSString *methodNameStr;

@end


@implementation WSURLRequest




@synthesize connection = _conncetion,url = _url,mutableRequest = _mutableRequest,mutabData = _mutabData,successBlock = _successBlock,failedBlock = _failedBlock;



#pragma mark start 设置webService服务器地址
+(void)webServiceConfigureDomain:(NSString *)domain
{
    
    @synchronized(self)
    {
        GlobalWebServiceURL = domain;
    }
}
#pragma mark end
#if 0
-(void)WSRequestNameSpace:(NSString *)nameSpace MethodName:(NSString *)methodName andSoapAction:(NSString *)soapAction andParameter:(NSDictionary *)parameterDic andParameterType:(NSDictionary*)parameterType successRequest:(SuccessRequest)successBlock failedRequest:(FailedRequest)failedBlock
{
    if(self.connection)
    {
        [self.connection cancel];
        self.connection = nil;
    }
    
    if( nil != GlobalWebServiceURL )
    {
        self.url = [NSURL URLWithString:GlobalWebServiceURL];
    }
    else
    {
        NSAssert(1<0, @"没有配置webservice服务器url地址");
        return;
    }
    self.successBlock = [successBlock copy];
    self.failedBlock = [failedBlock copy];
    self.mutableRequest = [NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:0];
    self.methodNameStr = [methodName copy];
    NSString *soapMsg = [self soapXmlMessageNameSpace:nameSpace andMethodName:methodName andParameter:parameterDic andParameterType:parameterType];
    NSString *msgLength = [NSString stringWithFormat:@"%ld",(unsigned long)[soapMsg length]];
    
    //DLog(@"%@",soapMsg);
    
    [self.mutableRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [self.mutableRequest addValue:soapAction forHTTPHeaderField:@"soapAction"];
    [self.mutableRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [self.mutableRequest setHTTPMethod:@"POST"];
    [self.mutableRequest setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.connection = [[NSURLConnection alloc]initWithRequest:self.mutableRequest delegate:self];
    [self.connection start];
    
}
#endif

-(NSString *)soapXmlMessageNameSpace:(NSString *)space andMethodName:(NSString*)methodName andKeyArr:(NSArray*)keyArr andValue:(NSArray*)valueArr andParameterType:(NSDictionary*)parameterType
{
    if( nil == space || [space isEqualToString:@""])
    {
        NSAssert(1<0, @"命名空间为空");
        return nil;
    }
    if( nil == methodName || [methodName isEqualToString:@""] )
    {
        NSAssert(1<0, @"没有给出调用接口名字");
        return nil;
    }
    GDataXMLElement *elementEnvelope = [GDataXMLElement elementWithName:@"soap:Envelope"];
    
    GDataXMLNode *nodeV = [GDataXMLNode namespaceWithName:@"xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"];
    GDataXMLNode *nodeI = [GDataXMLNode namespaceWithName:@"xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"];
    GDataXMLNode *nodeD = [GDataXMLNode namespaceWithName:@"soap" stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"];

    
    NSArray *nameSpacesArr = @[nodeV,nodeI,nodeD];
    [elementEnvelope setNamespaces:nameSpacesArr];
    
    GDataXMLElement *elementHeader = [GDataXMLElement elementWithName:@"soap:Body"];
    
    /**
     *  生成 调用函数名字
     */
    GDataXMLElement *elementMethodName = [GDataXMLElement elementWithName:methodName stringValue:@""];
    //[elementMethodName addAttribute:nodeDefault];
    GDataXMLElement *nameSpaceMethod = [GDataXMLElement elementWithName:@"xmlns" stringValue:space];
    [elementMethodName addAttribute:nameSpaceMethod];
    
    
    /**
     *  生成 参数节点
     */
    NSUInteger i = 0;
    if([keyArr count] != 0 && keyArr != nil)
    {
        for(NSString *key in keyArr)
        {
            GDataXMLElement *elementKey = [GDataXMLElement elementWithName:key stringValue:[valueArr objectAtIndex:i]];
#if 0
            if( nil != parameterType  && [parameterType count] > 0)
            {
                GDataXMLElement *attributeType = [GDataXMLElement elementWithName:@"i:type" stringValue:([parameterType objectForKey:key] != nil)?[parameterType objectForKey:key]:@"d:string"];
                [elementKey addAttribute:attributeType];
            }
            else
            {
                GDataXMLElement *defaultType = [GDataXMLElement elementWithName:@"i:type" stringValue:@"d:string"];
                [elementKey addAttribute:defaultType];
                
            }
#endif
            [elementMethodName addChild:elementKey];
            i++;
        }
        
    }
    [elementHeader addChild:elementMethodName];
    
    [elementEnvelope addChild:elementHeader];

    return elementEnvelope.XMLString;

    
}



-(void)WSrequestNameSpace:(NSString *)space MethodName:(NSString*)methodName andSoapAction:(NSString *)soapAction andKeyArr:(NSArray*)keyArr andValueArr:(NSArray *)valueArr andParameterType:(NSDictionary*)parameterType successRequest:(SuccessRequest)successBlock failedRequest:(FailedRequest)failedBlock andResponseType:(RETURNTYPE)type
{
    [self WSrequestNameSpace:space MethodName:methodName andSoapAction:soapAction andKeyArr:keyArr andValueArr:valueArr andParameterType:parameterType successRequest:successBlock failedRequest:failedBlock];
    _xmlOrJson = type;
    
}


-(void)WSrequestNameSpace:(NSString *)space MethodName:(NSString*)methodName andSoapAction:(NSString *)soapAction andKeyArr:(NSArray*)keyArr andValueArr:(NSArray *)valueArr andParameterType:(NSDictionary*)parameterType successRequest:(SuccessRequest)successBlock failedRequest:(FailedRequest)failedBlock andProgress:(ReceiveDataProgress)currentProgress
{
    [self WSrequestNameSpace:space MethodName:methodName andSoapAction:soapAction andKeyArr:keyArr andValueArr:valueArr andParameterType:parameterType successRequest:successBlock failedRequest:failedBlock];
    self.receiveDataBlock = [currentProgress copy];
}

//带有进度条的笔记上传事件

-(void)WSNoteIDrequestNameSpace:(NSString *)space MethodName:(NSString *)methodName andSoapAction:(NSString *)soapAction andKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andParameterType:(NSDictionary *)parameterType successRequest:(SuccessRequestWithNoteID)successWithNoteIDBlock failedRequest:(FailedRequestWithNoteID)failedWithNoteIDBlock andProgress:(ReceiveDataProgressWithNoteID)currentProgress withNoteID:(NSString *)noteID;

{
    if(self.connection)
    {
        [self.connection cancel];
        self.connection = nil;
    }
    
    if( nil != GlobalWebServiceURL )
    {
        self.url = [NSURL URLWithString:GlobalWebServiceURL];
    }
    else
    {
        NSAssert(1<0, @"没有配置webservice服务器url地址");
        return;
    }
    if(noteID != nil)
    {
        self.noteIDStr = noteID;
    }
    else
    {
        NSAssert(false, @"noteid有误");
        return;
    }
    self.successWithNoteBlock = [successWithNoteIDBlock copy];
    self.failedWithNoteBlock = [failedWithNoteIDBlock copy];
    self.receiveWithNoteIDDataBlock = [currentProgress copy];
    self.receiveDataBlock = nil;
    self.successBlock = nil;
    self.failedBlock = nil;
    self.mutableRequest = [NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0f];
    self.methodNameStr = [methodName copy];
    NSString *soapMsg = [self soapXmlMessageNameSpace:space andMethodName:methodName andKeyArr:keyArr andValue:valueArr andParameterType:parameterType];
    
    NSString *msgLength = [NSString stringWithFormat:@"%ld",(unsigned long)[soapMsg length]];
    
     DLog(@"%lu",(unsigned long)[[soapMsg dataUsingEncoding:NSUTF8StringEncoding] length]);
    
    [self.mutableRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    
    //[self.mutableRequest addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    
    [self.mutableRequest addValue:soapAction forHTTPHeaderField:@"soapAction"];
    [self.mutableRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [self.mutableRequest setHTTPMethod:@"POST"];
    [self.mutableRequest setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.connection = [[NSURLConnection alloc]initWithRequest:self.mutableRequest delegate:self];
    [self.connection start];
    
    _xmlOrJson = XML;
    

    
}










-(void)WSNoteIDrequestNameSpace:(NSString *)space MethodName:(NSString *)methodName andSoapAction:(NSString *)soapAction andKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andParameterType:(NSDictionary *)parameterType successRequest:(SuccessRequestWithNoteID)successWithNoteIDBlock failedRequest:(FailedRequestWithNoteID)failedWithNoteIDBlock withNoteID:(NSString *)noteID
{
    if(self.connection)
    {
        [self.connection cancel];
        self.connection = nil;
    }
    
    if( nil != GlobalWebServiceURL )
    {
        self.url = [NSURL URLWithString:GlobalWebServiceURL];
    }
    else
    {
        NSAssert(1<0, @"没有配置webservice服务器url地址");
        return;
    }
    if(noteID != nil)
    {
        self.noteIDStr = noteID;
    }
    else
    {
        NSAssert(false, @"noteid有误");
        return;
    }
    self.successWithNoteBlock = [successWithNoteIDBlock copy];
    self.failedWithNoteBlock = [failedWithNoteIDBlock copy];
    self.successBlock = nil;
    self.failedBlock = nil;
    self.mutableRequest = [NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0f];
    self.methodNameStr = [methodName copy];
    NSString *soapMsg = [self soapXmlMessageNameSpace:space andMethodName:methodName andKeyArr:keyArr andValue:valueArr andParameterType:parameterType];
    
    NSString *msgLength = [NSString stringWithFormat:@"%ld",(unsigned long)[soapMsg length]];
    
    // DLog(@"%@",soapMsg);
    
    [self.mutableRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [self.mutableRequest addValue:soapAction forHTTPHeaderField:@"soapAction"];
    [self.mutableRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [self.mutableRequest setHTTPMethod:@"POST"];
    [self.mutableRequest setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.connection = [[NSURLConnection alloc]initWithRequest:self.mutableRequest delegate:self];
    [self.connection start];
    
    _xmlOrJson = XML;

    
}








-(void)WSrequestNameSpace:(NSString *)space MethodName:(NSString *)methodName andSoapAction:(NSString *)soapAction andKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andParameterType:(NSDictionary *)parameterType successRequest:(SuccessRequest)successBlock failedRequest:(FailedRequest)failedBlock
{
    if(self.connection)
    {
        [self.connection cancel];
        self.connection = nil;
    }
    
    if( nil != GlobalWebServiceURL )
    {
        self.url = [NSURL URLWithString:GlobalWebServiceURL];
    }
    else
    {
        NSAssert(1<0, @"没有配置webservice服务器url地址");
        return;
    }
    self.successWithNoteBlock = nil;
    self.failedWithNoteBlock = nil;
    self.successBlock = [successBlock copy];
    self.failedBlock = [failedBlock copy];
    self.mutableRequest = [NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0f];
    self.methodNameStr = [methodName copy];
    NSString *soapMsg = [self soapXmlMessageNameSpace:space andMethodName:methodName andKeyArr:keyArr andValue:valueArr andParameterType:parameterType];

    NSString *msgLength = [NSString stringWithFormat:@"%ld",(unsigned long)[soapMsg length]];
    
    // DLog(@"%@",soapMsg);
    
    [self.mutableRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [self.mutableRequest addValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    [self.mutableRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [self.mutableRequest setHTTPMethod:@"POST"];
    [self.mutableRequest setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.connection = [[NSURLConnection alloc]initWithRequest:self.mutableRequest delegate:self];
    [self.connection start];

    _xmlOrJson = XML;
    
}

#pragma mark connection start
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSRange range = NSMakeRange(0, self.mutabData.length);
    [self.mutabData resetBytesInRange:range];
    //[self.data setData:nil];
    [self.mutabData setLength:0];
    
    
    
    if( self.failedBlock )
    {
        self.failedBlock(error);
    }
    else
        if(self.failedWithNoteBlock)
        {
            if(self.noteIDStr != nil)
            {
                self.failedWithNoteBlock(error,self.noteIDStr);
            }
        }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if( nil != self.mutabData )
    {
        NSRange range = NSMakeRange(0, self.mutabData.length);
        [self.mutabData resetBytesInRange:range];
        //[self.data setData:nil];
        [self.mutabData setLength:0];
        
        self.mutabData  = nil;
    }
    expectedLength = MAX(response.expectedContentLength, 1);
    currentLength = 0;

    self.mutabData = [[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if( self.mutabData )
    {
        [self.mutabData appendData:data];
    }
    currentLength += [data length];
    
    if( self.receiveDataBlock )
    {
        self.receiveDataBlock(expectedLength,currentLength);
    }
    else
        if( self.receiveWithNoteIDDataBlock )
        {
            self.receiveWithNoteIDDataBlock(expectedLength,currentLength,self.noteIDStr);
        }
    
}

-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    if(self.receiveWithNoteIDDataBlock)
    {
        self.receiveWithNoteIDDataBlock(totalBytesExpectedToWrite,totalBytesWritten,self.noteIDStr);
    }
   // DLog(@"-----zyc  %lu, %lu,%lu------end",bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if( self.successBlock )
    {
        if(self.methodNameStr)
        {
            
            if(_xmlOrJson == XML)
            {
                NSData *tmpData = [self xmlParseData:self.mutabData andMethodName:self.methodNameStr];
                self.successBlock(tmpData);
            }
            else
            {
                NSData *tmpData = [self.mutabData copy];
                self.successBlock(tmpData);
            }
            self.methodNameStr = nil;
        }
    }
    else
    if(self.successWithNoteBlock)
    {
        if(self.methodNameStr)
        {
            
            if(_xmlOrJson == XML)
            {
                NSData *tmpData = [self xmlParseData:self.mutabData andMethodName:self.methodNameStr];
                if(self.noteIDStr != nil)
                {self.successWithNoteBlock(tmpData,self.noteIDStr);}
            }
            else
            {
                NSData *tmpData = [self.mutabData copy];
                self.successWithNoteBlock(tmpData,self.noteIDStr);
            }
            self.methodNameStr = nil;
        }

        
    }
}
#pragma mark connection end



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
    GDataXMLElement *bodyResponse = (GDataXMLElement *)[body childAtIndex:0];
    GDataXMLElement *endResult = (GDataXMLElement*)[bodyResponse childAtIndex:0];

    returnData = [endResult.stringValue dataUsingEncoding:NSUTF8StringEncoding];
    return returnData;
}
#pragma mark xmlParse end



@end
