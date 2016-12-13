//
//  TLItem.m
//  Homepwner
//
//  Created by lushuishasha on 2016/12/9.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//

#import "TLItem.h"

@implementation TLItem
- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)serialNumber {
    self = [super init];
    if (self) {
        _itemName = name;
        _serialNumber = serialNumber;
        _valueInDollars = value;
        _dateCreated = [[NSDate alloc]init];
        
        //创建一个NSUUID对象，然后获取其String类型
        NSUUID *uuid = [[NSUUID alloc]init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }
    return self;
}


+ (TLItem *)randomItem{
    NSArray *randomNounList = @[@"hello1",@"hello2",@"hello3"];
    NSArray *randomAdjectiveList = @[@"Hi1",@"Hi2",@"Hi3"];

    NSInteger adjextiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nouIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@"@"%@",[randomAdjectiveList objectAtIndex:adjextiveIndex],[randomNounList objectAtIndex:nouIndex]];
    
    int ramdomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%d",arc4random() % 12];
    
    TLItem *newItem = [[self alloc]initWithItemName:randomName valueInDollars:ramdomValue serialNumber:randomSerialNumber];
    
    return newItem;
}

- (NSString *)description {
    return [[NSString alloc]initWithFormat:@"%@ (%@):worth:%d, record on %@",self.itemName,self.serialNumber,self.valueInDollars,self.dateCreated];
}
@end
