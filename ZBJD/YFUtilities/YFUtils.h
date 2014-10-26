//
//  YFUtils.h
//  YFUtilities
//
//  Created by 叶帆 on 14-7-21.
//  Copyright (c) 2014年 yefan. All rights reserved.
//

/**
 必要的denpendencies
 我不会告诉你还有很多我自己定义的库~
*/

#ifndef YFUtils_YFUtils_h
#define YFUtils_YFUtils_h

#import "YFDownloader.h"
#import "YFDownloaderManager.h"
#import "YFCommon.h"

#endif

#ifdef DEBUG
#define NSLog(fmt,...) do{NSLog(fmt,##__VA_ARGS__);} while(0)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)  do{}while(0)
#define debugMethod()
#endif
