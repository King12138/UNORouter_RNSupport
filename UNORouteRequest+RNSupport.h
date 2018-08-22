//
//  UNORouteRequest+RNSupport.h
//  UNORouter_RNSupport
//
//  Created by intebox on 2018/8/17.
//

#import "UNORouteRequest.h"

@interface UNORouteRequest (RNSupport)

@property (nonatomic, assign) BOOL isRN;
@property (nonatomic, strong) NSString *component;

@end
