//
//  FileOperation.m
//  YRProject
//
//  Created by art_kernel_zyc on 14/12/31.
//  Copyright (c) 2014年 豆豆豆. All rights reserved.
//

#import "FileOperation.h"

static NSString *endPath;
static inline  void fileNameAccordingType(NSString *fileName,SaveForDictionaryType type)
{
    NSString *path = nil;
    switch (type) {
        case DOCUMENT:
        {
            path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            break;
        }
        case CACHE:
        {
            path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            break;
            
        }
        case LIBARARY:
        {
            path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
            break;
        }
        case TMP:
        {
            path = NSTemporaryDirectory();
            break;
            
        }
        default:
            break;
    }
    
    endPath = [path stringByAppendingPathComponent:fileName];
    
}

@implementation FileOperation

+(BOOL)operationCreateFileDictionary:(NSString *)name savePathType:(SaveForDictionaryType)type
{
    fileNameAccordingType(name, type);
    if(endPath == nil){
        NSAssert(false, @"文件有误");
        return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:endPath])
    {
        return YES;
    }
    else
    {
        if([manager createDirectoryAtPath:endPath withIntermediateDirectories:YES attributes:nil error:nil] == YES)
        {
            return YES;
        }
        return NO;
    }
    return NO;
}



+(BOOL)operationExistFile:(NSString *)fileName savePathType:(SaveForDictionaryType)type
{
    
    fileNameAccordingType(fileName, type);
    if(endPath == nil){
        NSAssert(false, @"文件有误");
        return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:endPath])
    {
        return YES;
    }
    else
    {
        return NO;
    }
    return NO;
}


+(BOOL)operationDeletedFileWithPath:(NSString *)pathAndFileName
{
    if(pathAndFileName == nil){ NSAssert(false, @"error");  return NO;}
    BOOL endResult = NO;
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:pathAndFileName])
    {
        endResult = [manager removeItemAtPath:pathAndFileName error:nil];
    }
    return endResult;
    
}



@end
