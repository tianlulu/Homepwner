//
//  BNRItemStore.m
//  Homepwner
//
//  Created by lushuishasha on 2016/12/9.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//

#import "TLItemStore.h"
#import "TLItem.h"
#import "TLImageStore.h"


@interface TLItemStore()
@property (nonatomic) NSMutableArray *privateItems;
@end

@implementation TLItemStore
+ (instancetype)sharedStore {
    static  TLItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[TLItemStore alloc] initPriivate];
    }
    return sharedStore;
}

//如果调用[[TLItemStore alloc]init],抛出异常，提示应该使用[TLItemStore sharedStore]
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [TLItemStore sharedStore]" userInfo:nil];
    return nil;
}

//私有的初始化方法
- (instancetype)initPriivate{
    self = [super init];
    if(self){
        _privateItems = [[NSMutableArray alloc]init];
    }
    return self;
}

- (NSArray *)allItems {
    return  [self.privateItems copy];
}

- (TLItem *)createItem {
    TLItem *item = [TLItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(TLItem *)item {
    //在用户删除某个TLItem对象后，需要同时在TLImageStore删除对应的UIImage对象
    [[TLImageStore sharedStore] deleteImageForKey:item.itemKey];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)formIndex toIndex:(NSInteger)toIndex{
    if(formIndex == toIndex){
        return;
    }
    //得到要移动的对象指针，以便稍后插入到新的位置
    TLItem *item = self.privateItems[formIndex];
    //将item从allItems数组中移除
    [self.privateItems removeObjectAtIndex:formIndex];
    //插入到新的位置
    [self.privateItems insertObject:item atIndex:toIndex];
}
@end
