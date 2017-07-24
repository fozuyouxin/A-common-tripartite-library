//
//  XHVersion.m
//  XHVersionExample
//
//  Created by zhuxiaohui on 2016/11/22.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  

#import "XHVersion.h"
#import <StoreKit/StoreKit.h>
#import "XHVersionRequest.h"

@interface XHVersion()<UIAlertViewDelegate,SKStoreProductViewControllerDelegate>

@property(nonatomic,strong)XHAppInfo *appInfo;

@end

@implementation XHVersion

+ (void)checkNewVersion{
    
    [[XHVersion shardManger] checkNewVersion];
}

+(void)checkNewVersionAndCustomAlert:(NewVersionBlock)newVersion{
    
    [[XHVersion shardManger] checkNewVersionAndCustomAlert:newVersion];
}

#pragma mark - private

+(XHVersion *)shardManger{
    
    static XHVersion *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        
        instance = [[XHVersion alloc] init];
        
    });
    return instance;
}
-(void)checkNewVersion{
    
    [self versionRequest:^(XHAppInfo *appInfo) {
    
        NSString *updateMsg = [NSString stringWithFormat:@"%@",appInfo.releaseNotes];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:updateMsg delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
        [alertView show];
#endif
      
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:updateMsg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            [self openInAppStoreForAppURL:self.appInfo.trackViewUrl];
            
        }]];
        
        [[self window].rootViewController presentViewController:alert animated:YES completion:nil];
        
        UIView *subView1 = alert.view.subviews[0];
        UIView *subView2 = subView1.subviews[0];
        UIView *subView3 = subView2.subviews[0];
        UIView *subView4 = subView3.subviews[0];
        UIView *subView5 = subView4.subviews[0];
        //取title和message：
        //UILabel *title = subView5.subviews[0];
        UILabel *message = subView5.subviews[1];
        //然后设置message内容居左：
        message.textAlignment = NSTextAlignmentLeft;
        //title.textAlignment = NSTextAlignmentLeft;
#endif
        
    }];

}
-(UIWindow *)window{
    
    UIWindow *window = nil;
    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(window)]) {
        window = [delegate performSelector:@selector(window)];
    } else {
        window = [[UIApplication sharedApplication] keyWindow];
    }
    return window;
}
-(void)checkNewVersionAndCustomAlert:(NewVersionBlock)newVersion{
    
    [self versionRequest:^(XHAppInfo *appInfo) {
        
        if(newVersion) newVersion(appInfo);
        
    }];
}
-(void)versionRequest:(NewVersionBlock)newVersion{
    
    [XHVersionRequest xh_versionRequestSuccess:^(NSDictionary *responseDict) {
        
        NSInteger resultCount = [responseDict[@"resultCount"] integerValue];
        if(resultCount==1)
        {
            NSArray *resultArray = responseDict[@"results"];
            NSDictionary *result = resultArray.firstObject;
            XHAppInfo *appInfo = [[XHAppInfo alloc] initWithResult:result];
            NSString *version = appInfo.version;
            self.appInfo = appInfo;
            if([self isNewVersion:version])//新版本
            {
                if(newVersion) newVersion(self.appInfo);
            }
        }
        
    } failure:^(NSError *error) {
        
    }];

}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==1)
    {
        [self openInAppStoreForAppURL:self.appInfo.trackViewUrl];
    }
}
#endif

- (void)openInStoreProductViewControllerForAppId:(NSString *)appId{

        SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
        storeProductVC.delegate = self;
        [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
            if (result) {
                
                [[self window].rootViewController presentViewController:storeProductVC animated:YES completion:nil];
            }
        }];

}

-(void)openInAppStoreForAppURL:(NSString *)appURL{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURL]];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)isNewVersion:(NSString *)newVersion{
    
    return [self newVersion:newVersion moreThanCurrentVersion:[self currentVersion]];
}
-(NSString * )currentVersion{
    
    NSString *key = @"CFBundleShortVersionString";
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    return currentVersion;
}
-(BOOL)newVersion:(NSString *)newVersion moreThanCurrentVersion:(NSString *)currentVersion{
    
    if([currentVersion compare:newVersion options:NSNumericSearch]==NSOrderedAscending)
    {
        return YES;
    }
    return NO;
}
@end
