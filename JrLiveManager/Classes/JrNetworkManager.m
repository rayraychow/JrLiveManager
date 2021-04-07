//
//  JrNetworkManager.m
//  JrLiveSdk
//
//  Created by iOS on 2021/3/30.
//

#import "JrNetworkManager.h"
#import "RSAHandler.h"

@implementation JrNetworkManager

// 实现 Post 请求
- (void)startPostRequest:(NSString *)appId cdKey:(NSString *)cdKey sdkVersion:(NSString *)sdkVersion resultBlock:(void(^)(BOOL isSuccess))resultBlock {
    NSString *strUrl = @"https://zen.jravity.com/openapi/system/sdkAuthInfo";
    NSURL *url = [NSURL URLWithString:strUrl];
    
    //参数字符串：请求参数放到请求体中
    NSDictionary *dic = @{@"appId":appId,
                          @"cdKey":cdKey,
                          @"sdkVersion":sdkVersion
    };
    if (appId.length < 0) {
        NSLog(@"匠人验签授权接口:appId不能为空");
        return;
    }
    if (cdKey.length < 0) {
        NSLog(@"匠人验签授权接口:cdKey不能为空");
        return;
    }
    if (sdkVersion.length < 0) {
        NSLog(@"匠人验签授权接口:sdkVersion不能为空");
        return;
    }
    //将参数转换成NSData类型
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSInteger ts = [now timeIntervalSince1970] * 1000;
    [request setValue:@(ts).stringValue forHTTPHeaderField:@"ts"];
    [request setValue:@"hj-ios" forHTTPHeaderField:@"sysCode"];
    NSString *originStr = [NSString stringWithFormat:@"sysCode=hj-ios&ts=%@", @(ts).stringValue];
    NSString *privateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKYV6nyt6H7Ai8GbC1oBmxp8iEQPt7O9f1OD2vUtAIA1yD1r5C6Cg6o/ctZPFBFQDHaIBRJTPsc0sVCLJya6M7TVBT+gZa5kOY9Y+nzrwScL63L7kesf33I3D76jetggICZzlTOfC4yZXJ+HXOgX65KDXvMpiHamU1XIx02HcRF1AgMBAAECgYB40RSEohWwrux7aAf375cey1xs9moRzFWlMRPEqnnkyjrhw2x4EOUqoYEuONRGS87lIsldrUTLsJ8UEkXmvCkDxFsRpbGD4ABBJM1aa7YaAxWeS6ut8AZxFdQ3dAD5EWqeur7C8bDxuyBTAMEn+hJ1qWnNDTpbfcmlYZC8evm2QQJBANjDSWrytDX6NRIFn8lRNAyXOAf8Ao5SS8ZMCATMLVmUrgPlVC2imjv+bubnuFRXdkyrncGYBooruDiEZEEVkr0CQQDEJkOoosrVE2koFpRg8yKOha3C/+6VlmFYhKo8ZCDjPiI+XNt6SA3u0ypAnd1Bd0Par7u8+oTAL3W5S/mnfwEZAkBW/Ket35AqSSqa/N7Or2Ov2c+GhL+R1bzK6yAcrMNWO7BJp/JMDgDPKp/e0gbK8f5rbkN0uUmGkVzwcVC6PaoRAkA6Lt+C9kcUTV2z9n6tA3IMtLqGTUSIOsNFbpTQtSLMRXIC7ahs7VK0tQ6jfDBVavtFszsNI4KdP3a8MD0t4g6BAkA0vBrdTbb939BN5KuDmZcrI8BOtuPEjajIC7y7htJ6rYeBOoNkHYiQDOUY8LYlfTjvD+0jwPAmhwuq82Q+Kq5j";
    NSString *publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCmFep8reh+wIvBmwtaAZsafIhED7ezvX9Tg9r1LQCANcg9a+QugoOqP3LWTxQRUAx2iAUSUz7HNLFQiycmujO01QU/oGWuZDmPWPp868EnC+ty+5HrH99yNw++o3rYICAmc5UznwuMmVyfh1zoF+uSg17zKYh2plNVyMdNh3ERdQIDAQAB";
    RSAHandler *handler = [RSAHandler new];
    [handler importKeyWithType:KeyTypePrivate andkeyString:privateKey];
    [handler importKeyWithType:KeyTypePublic andkeyString:publicKey];
    NSString *sign = [handler signString:originStr];
    [request setValue:sign forHTTPHeaderField:@"sign"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //session配置
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfig.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    defaultConfig.timeoutIntervalForRequest = 15;
    defaultConfig.allowsCellularAccess = YES;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    //执行请求任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"匠人验签授权接口数据输出--%@",dic);
        NSString *code = dic[@"code"];
        if (resultBlock) {
            resultBlock(code.intValue == 200 ? YES : NO);
        }
    }];
    [dataTask resume];
}

@end
