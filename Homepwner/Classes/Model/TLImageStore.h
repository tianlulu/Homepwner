//
//  TLImageStore.h
//  Homepwner
//
//  Created by lushuishasha on 2016/12/12.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TLImageStore : NSObject
+ (instancetype)sharedStore;
- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;
@end
