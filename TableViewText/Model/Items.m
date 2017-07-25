//
//  Items.m
//
//  Created by 瑞胜 杜 on 2017/7/14
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Items.h"


NSString *const kItemsItemTitle = @"itemTitle";
NSString *const kItemsImageName = @"imageName";
NSString *const kItemsItemStaue = @"itemStaue";


@interface Items ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Items

@synthesize itemTitle = _itemTitle;
@synthesize imageName = _imageName;
@synthesize itemStaue = _itemStaue;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.itemTitle = [self objectOrNilForKey:kItemsItemTitle fromDictionary:dict];
            self.imageName = [self objectOrNilForKey:kItemsImageName fromDictionary:dict];
            self.itemStaue = [[self objectOrNilForKey:kItemsItemStaue fromDictionary:dict] integerValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.itemTitle forKey:kItemsItemTitle];
    [mutableDict setValue:self.imageName forKey:kItemsImageName];
    [mutableDict setValue:[NSNumber numberWithInteger:self.itemStaue] forKey:kItemsItemStaue];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.itemTitle = [aDecoder decodeObjectForKey:kItemsItemTitle];
    self.imageName = [aDecoder decodeObjectForKey:kItemsImageName];
    self.itemStaue = [aDecoder decodeIntegerForKey:kItemsItemStaue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_itemTitle forKey:kItemsItemTitle];
    [aCoder encodeObject:_imageName forKey:kItemsImageName];
    [aCoder encodeInteger:_itemStaue forKey:kItemsItemStaue];
}

- (id)copyWithZone:(NSZone *)zone
{
    Items *copy = [[Items alloc] init];
    
    if (copy) {

        copy.itemTitle = [self.itemTitle copyWithZone:zone];
        copy.imageName = [self.imageName copyWithZone:zone];
        copy.itemStaue = self.itemStaue;
    }
    
    return copy;
}


@end
