//
//  FileOperation.h
//  YRProject
//
//  Created by art_kernel_zyc on 14/12/31.
//  Copyright (c) 2014年 豆豆豆. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum SavePath
{
    DOCUMENT = 0,
    CACHE,
    LIBARARY,
    TMP
}SaveForDictionaryType;

@interface FileOperation : NSObject

@property(nonatomic,assign)SaveForDictionaryType saveType;

/**
 *  取得沙盒目录
 *
 *  @return
 */
+(NSString *)plistPathForSandBox;

+(BOOL)operationWritePlist:(NSString *)plistForPath ;


+(BOOL)operationExistFile:(NSString *)fileName savePathType:(SaveForDictionaryType)type;


+(BOOL)operationDeletedFileWithPath:(NSString *)pathAndFileName;

+(BOOL)operationCreateFileDictionary:(NSString *)name savePathType:(SaveForDictionaryType)type;

@end
