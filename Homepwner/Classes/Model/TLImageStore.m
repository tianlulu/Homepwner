//
//  TLImageStore.m
//  Homepwner
//
//  Created by lushuishasha on 2016/12/12.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//

#import "TLImageStore.h"

@interface TLImageStore()
@property (nonatomic,strong) NSMutableDictionary *dictonary;
@end

@implementation TLImageStore
+ (instancetype) sharedStore
{
    static TLImageStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

//不允许直接调用init方法
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use + [TLImageStore sharedStore]" userInfo:nil];
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _dictonary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    [self.dictonary setObject:image forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key {
    return [self.dictonary objectForKey:key];
}

- (void)deleteImageForKey:(NSString *)key {
    if (key) {
        return;
    }
    [self.dictonary removeObjectForKey:key];
}
@end
