//
//  BNRItemStore.h
//  Homepwner
//
//  Created by lushuishasha on 2016/12/9.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//管理BNRItem数组

#import <Foundation/Foundation.h>

//@class编译器指令，告诉编译器你不需要知道这个类的具体信息，从而加快编译速度；当真正要创建这个类的实例或是要调用其方法时，就必须导入其头文件了
@class TLItem;
@interface TLItemStore : NSObject

// 静态方法，此方法用来创建单例类对象
+ (instancetype)sharedStore;

- (TLItem *)createItem;

- (NSArray *)allItems;
- (void)removeItem:(TLItem *)item;
- (void)moveItemAtIndex:(NSInteger)formIndex toIndex:(NSInteger)toIndex;
@end
