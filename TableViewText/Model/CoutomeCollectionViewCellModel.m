//
//  CoutomeCollectionViewCellModel.m
//
//  Created by 瑞胜 杜 on 2017/7/14
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "CoutomeCollectionViewCellModel.h"
#import "Items.h"


NSString *const kCoutomeCollectionViewCellModelType = @"type";
NSString *const kCoutomeCollectionViewCellModelItems = @"items";


@interface CoutomeCollectionViewCellModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CoutomeCollectionViewCellModel

@synthesize type = _type;
@synthesize items = _items;


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
            self.type = [self objectOrNilForKey:kCoutomeCollectionViewCellModelType fromDictionary:dict];
    NSObject *receivedItems = [dict objectForKey:kCoutomeCollectionViewCellModelItems];
    NSMutableArray *parsedItems = [NSMutableArray array];
    if ([receivedItems isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedItems) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedItems addObject:[Items modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedItems isKindOfClass:[NSDictionary class]]) {
       [parsedItems addObject:[Items modelObjectWithDictionary:(NSDictionary *)receivedItems]];
    }

    self.items = [NSArray arrayWithArray:parsedItems];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kCoutomeCollectionViewCellModelType];
    NSMutableArray *tempArrayForItems = [NSMutableArray array];
    for (NSObject *subArrayObject in self.items) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItems addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItems addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:kCoutomeCollectionViewCellModelItems];

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

    self.type = [aDecoder decodeObjectForKey:kCoutomeCollectionViewCellModelType];
    self.items = [aDecoder decodeObjectForKey:kCoutomeCollectionViewCellModelItems];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_type forKey:kCoutomeCollectionViewCellModelType];
    [aCoder encodeObject:_items forKey:kCoutomeCollectionViewCellModelItems];
}

- (id)copyWithZone:(NSZone *)zone
{
    CoutomeCollectionViewCellModel *copy = [[CoutomeCollectionViewCellModel alloc] init];
    
    if (copy) {

        copy.type = [self.type copyWithZone:zone];
        copy.items = [self.items copyWithZone:zone];
    }
    
    return copy;
}


@end
