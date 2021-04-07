//
//  JrLiveManager.h
//  JrLiveSdk
//
//  Created by iOS on 2021/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JrLiveManager : NSObject

/// 创建验证授权管理类
/// @param bundleID ios的bundleID
/// @param cdKey 欢句内嵌专属激活码
/// @param sdkVersion SDK版本号
- (instancetype)initWithBundleID:(NSString *)bundleID cdKey:(NSString *)cdKey sdkVersion:(NSString *)sdkVersion;

/// 打开webView
/// @param urlString url
- (void)openWithUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
