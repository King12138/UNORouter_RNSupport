//
//  UNORouter+RN_Support.h
//  UNORouter_RNSupport
//
//  Created by intebox on 2018/8/17.
//

#import "UNORouter.h"

@interface UNORouter (RN_Support)

+ (BOOL)registerHandler:(UNORouteHandler *)handler
                   node:(NSString *)node
           toRNCompoent:(NSString *)RNCompoent;

+ (BOOL)registerHandler:(UNORouteHandler *)handler
             RNCompoent:(NSString *)RNCompoent;

+ (BOOL)registerRNCompoent:(NSString *)RNCompoent;

+ (BOOL)registerNode:(NSString *)node
          RNCompoent:(NSString *)RNCompoent;

@end

