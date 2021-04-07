//
//  JrNetworkManager.h
//  JrLiveSdk
//
//  Created by iOS on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JrNetworkManager : NSObject

/// 查询应用是否有SDK权限
/// @param appId ios的bundleID
/// @param cdKey 欢句内嵌专属激活码
/// @param sdkVersion SDK版本号
/// @param resultBlock 成功回调
- (void)startPostRequest:(NSString *)appId cdKey:(NSString *)cdKey sdkVersion:(NSString *)sdkVersion resultBlock:(void(^)(BOOL isSuccess))resultBlock;

@end

NS_ASSUME_NONNULL_END
