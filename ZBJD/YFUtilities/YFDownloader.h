//
//  YFDownloader.h
//  V2EX
//
//  Created by 叶帆 on 14-9-20.
//  Copyright (c) 2014年 yefan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    kDownloadWaiting = 0,               //等待下载
    kDownloading = 1,                   //正在下载
    kDownloadSucceed = 2,               //下载成功
    kDownloadFailed = 3,                //下载失败
    kDownloadCanceled = 4               //下载取消
}DownloaderStatus;

@protocol YFDownloaderDelegate;

@interface YFDownloader : NSObject

@property (nonatomic, copy) NSString* purpose;
@property (nonatomic, assign) DownloaderStatus status;
@property (nonatomic, strong) NSURLRequest *urlRequest;
@property (nonatomic, strong) NSURLConnection *theConnection;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) id<YFDownloaderDelegate> delegate;

- (void)refresh;
/**
 执行download操作
 @param request  URL
 @param receiver 实现delegate的downloader
 @param pur      downloader的标识
 */
- (void)startDownloadWithRequest:(NSURLRequest *)request
                        callback:(id<YFDownloaderDelegate>)receiver
                         purpose:(NSString *)pur;
- (void)cancelDownload;
@end

@protocol YFDownloaderDelegate<NSObject>
- (void)downloader:(YFDownloader*)downloader completeWithNSData:(NSData*)data;
- (void)downloader:(YFDownloader*)downloader didFinishWithError:(NSString*)message;
@end
