//
//  XHHealthRequest.h
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/17.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessRequestBlock)(id data);
typedef void (^FailRequestBlock) (id data , NSError *error);

@interface XHHealthRequest : NSObject


-(void)getRequestParameters:(NSDictionary *)parameters withMethodName:(NSString *)methodName SuccessRequest:(SuccessRequestBlock)successBlock FailRequest:(FailRequestBlock)failBlock;
@end
