//
//  Items.h
//
//  Created by 瑞胜 杜 on 2017/7/14
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    ItemStaue_None  =   0,
    ItemStaue_CanDelete =   1,
    ItemStaue_HadAdd    =   2,
    ItemStaue_CanAdd    =   3,
} ItemStaue;

@interface Items : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) ItemStaue itemStaue;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
