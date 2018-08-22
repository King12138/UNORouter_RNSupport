//
//  UNORNHanlder.m
//  UNORouter_RNSupport
//
//  Created by intebox on 2018/8/22.
//

#import "UNORNHanlder.h"
#import <React/RCTRootView.h>
#import "UNORouteRequest+RNSupport.h"

@implementation UNORNHanlder

- (UIViewController *)targetViewControllerWithRequest:(UNORouteRequest *)request{
    UIViewController *viewController = [[UIViewController alloc] init];
    RCTBridge *bridge = [[UIApplication sharedApplication].delegate performSelector:@selector(bridge)];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                     moduleName:request.component initialProperties:request.params];
    viewController.view = rootView;
    return viewController;
}

@end
