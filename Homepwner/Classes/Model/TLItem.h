//
//  TLItem.h
//  Homepwner
//
//  Created by lushuishasha on 2016/12/9.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLItem : NSObject
@property (nonatomic,copy) NSString *itemName;
@property (nonatomic,copy) NSString *serialNumber;
@property (assign) int valueInDollars;
@property (nonatomic,strong) NSDate *dateCreated;

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)serialNumber;
+ (TLItem *)randomItem;
@end
