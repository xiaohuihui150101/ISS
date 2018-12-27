//
//  RootModel.m
//  ISS
//
//  Created by isoft on 2018/12/25.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RootModel.h"

@implementation RootModel

@end

@implementation ListData

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rows" : [ListRows class]};
}

@end

@implementation ListRows

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"postLabels" : [ListPostLabels class]};
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}

MJExtensionCodingImplementation
- (NSString *)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if (!oldValue && [property.srcClass isSubclassOfClass:self.class]) {
        return @"";
    }
    return oldValue;
}


@end

@implementation ListPostLabels

MJExtensionCodingImplementation
- (NSString *)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if (!oldValue && [property.srcClass isSubclassOfClass:self.class]) {
        return @"";
    }
    return oldValue;
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"postID": @"id"};
}


@end
