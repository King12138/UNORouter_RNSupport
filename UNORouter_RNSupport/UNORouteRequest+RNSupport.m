//
//  UNORouteRequest+RNSupport.m
//  UNORouter_RNSupport
//
//  Created by intebox on 2018/8/17.
//

#import "UNORouteRequest+RNSupport.h"
#import <objc/runtime.h>

@implementation UNORouteRequest (RNSupport)

static const char *SUNOISRN_KEY = "SUNOISRN_KEY";
- (BOOL)isRN{
    NSNumber *isRN = objc_getAssociatedObject(self, SUNOISRN_KEY);
    return isRN == nil?NO:[isRN boolValue];
}

- (void)setIsRN:(BOOL)isRN{
    objc_setAssociatedObject(self, SUNOISRN_KEY, @(isRN), OBJC_ASSOCIATION_RETAIN);
}


static const char *SUNOComponent_KEY = "SUNOComponent_KEY";
- (NSString *)component{
    return objc_getAssociatedObject(self, SUNOComponent_KEY);
}

- (void)setComponent:(NSString *)component{
    objc_setAssociatedObject(self, SUNOComponent_KEY, component, OBJC_ASSOCIATION_RETAIN);
}

@end
