//
//  JrLiveManager.m
//  JrLiveSdk
//
//  Created by iOS on 2021/3/30.
//

#import "JrLiveManager.h"
#import <WebKit/WebKit.h>
#import "JrNetworkManager.h"

@interface JrViewController : UIViewController

+ (UIViewController *)currentViewController;

@end

@implementation JrViewController

+ (UIViewController *) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [JrViewController findBestViewController:viewController];
}

#pragma mark - 内部方法
+ (UIViewController *) findBestViewController:(UIViewController *)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [JrViewController findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [JrViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [JrViewController findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [JrViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
}

@end

@interface JrLiveManager ()

@property (nonatomic, assign) BOOL canOpenWebView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation JrLiveManager {
    NSString *_bundleID;
    NSString *_cdKey;
    NSString *_sdkVersion;
}

- (instancetype)initWithBundleID:(NSString *)bundleID cdKey:(NSString *)cdKey sdkVersion:(NSString *)sdkVersion {
    if (self == [super init]) {
        _bundleID = bundleID;
        _cdKey = cdKey;
        _sdkVersion = sdkVersion;
        [self getSdkAuthInfo];
    }
    return self;
}

- (void)getSdkAuthInfo {
    JrNetworkManager *netManager = [JrNetworkManager new];
    __weak typeof(self) weakSelf = self;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [netManager startPostRequest:_bundleID cdKey:_cdKey sdkVersion:_sdkVersion resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.canOpenWebView = YES;
        }
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^(){
        if (!self.canOpenWebView) return;
        UIViewController *vc = [JrViewController currentViewController];
        [vc.view addSubview:self.webView];
    });
}

- (void)openWithUrlString:(NSString *)urlString {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        config.mediaTypesRequiringUserActionForPlayback = false;
        config.allowsInlineMediaPlayback = YES;
        _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:config];
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}

@end
