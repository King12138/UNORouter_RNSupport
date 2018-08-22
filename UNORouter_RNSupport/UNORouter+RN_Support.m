//
//  UNORouter+RN_Support.m
//  UNORouter_RNSupport
//
//  Created by intebox on 2018/8/17.
//

#import "UNORouter+RN_Support.h"
#import <objc/runtime.h>

#import "UNORouteRequest+RNSupport.h"
#import "UNORNHanlder.h"

@interface NSURL (UNORoute_RNSupport_add)

- (NSDictionary *)RNSupport_queryParams;

@end

@implementation UNORouter (RN_Support)

+ (void)load{
    Method originRequestMethod = class_getClassMethod(self, @selector(hook_requestWithOriginReqest:apiType:));
    
    Method hook_originRequestMethod = class_getClassMethod(self, @selector(rn_support_hook_requestWithOriginReqest:apiType:));
    
    method_exchangeImplementations(originRequestMethod, hook_originRequestMethod);
}

NSMapTable *shared(void){
    static NSMapTable *one = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        one =[NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                   valueOptions:NSPointerFunctionsStrongMemory];
    });
    return one;
}

static const NSString *SUNORouteComponent_Key = @"SUNORouteComponent_Key";
static const NSString *SUNORouteHandler_Key = @"SUNORouteHandler_Key";

+ (BOOL)registerRNCompoent:(NSString *)RNCompoent{
    return [self registerNode:RNCompoent
                   RNCompoent:RNCompoent];
}

+ (BOOL)registerNode:(NSString *)node
          RNCompoent:(NSString *)RNCompoent{
    return [self registerHandler:[[UNORNHanlder alloc] init]
                            node:node
                    toRNCompoent:RNCompoent];
}


+ (BOOL)registerHandler:(UNORouteHandler *)handler
             RNCompoent:(NSString *)RNCompoent{
    return [self registerHandler:handler
                            node:RNCompoent
                    toRNCompoent:RNCompoent];
}

+ (BOOL)registerHandler:(UNORouteHandler *)handler
                   node:(NSString *)node
           toRNCompoent:(NSString *)RNCompoent{

    if (handler ==nil ||node == nil  || RNCompoent == nil) {
        return false;
    }
    
    [shared() setObject:@{SUNORouteComponent_Key:RNCompoent,
                          SUNORouteHandler_Key:handler}
                 forKey:node];
    return true;
}

#pragma mark-
#pragma mark- swizzle

+ (UNORouteHandler *)rn_support_hook_requestWithOriginReqest:(UNORouteRequest *)originRequest apiType:(UNORoute_Api_Type)apiType{
 
    NSString *currentNode = nil;
    if(originRequest.currenNode != nil){
        currentNode = originRequest.currenNode;
    }else{
        NSURL *pathUrl = [NSURL URLWithString:originRequest.path];
        if (pathUrl.query != nil) {
            NSDictionary *queryParams = [pathUrl RNSupport_queryParams];
            currentNode = [queryParams.allKeys containsObject:UNO_ROUTE_StoryBoard_ID_Key] ?queryParams[UNO_ROUTE_StoryBoard_ID_Key]:nil;;
        }else if (pathUrl.relativePath != nil){
            currentNode = pathUrl.lastPathComponent;
        }
    }
    
    if(currentNode != nil && [[shared() keyEnumerator].allObjects containsObject:currentNode]){
        NSDictionary *nodeCahce = [shared() objectForKey:currentNode];
        originRequest.isRN = YES;
        originRequest.component = [nodeCahce objectForKey:SUNORouteComponent_Key];
        UNORouteHandler *handler = [nodeCahce objectForKey:SUNORouteHandler_Key];
        if(handler != nil){
            return handler;
        }else{
            return [self rn_support_hook_requestWithOriginReqest:originRequest apiType:apiType];
        }
    }else{
        return [self rn_support_hook_requestWithOriginReqest:originRequest apiType:apiType];
    }
}

@end


@implementation NSURL (UNORoute_RNSupport_add)

- (NSDictionary *)RNSupport_queryParams{
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionary];
    
    NSArray *components = [self.query componentsSeparatedByString:@"&"];
    for (NSString *component in components) {
        NSRange range = [component rangeOfString:@"="];
        if (range.location == NSNotFound || range.location == 0 || range.location == component.length-1) {
            //当”=“ 不存在或者在头部或者在尾部,无效
            continue;
        }
        NSArray *stringComponents = [component componentsSeparatedByString:@"="];
        if (stringComponents.count == 2) {
            [queryParams setObject:stringComponents[1] forKey:stringComponents[0]];
        }
    }
    
    return [queryParams copy];
}

@end

