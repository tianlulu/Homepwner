//
//  BNRItemsTableViewController.m
//  Homepwner
//
//  Created by lushuishasha on 2016/12/9.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//

#import "TLItemsTableViewController.h"
#import "TLItemStore.h"
#import "TLItem.h"

@interface TLItemsTableViewController ()
@property (nonatomic,strong) IBOutlet UIView *headerView;
@end

@implementation TLItemsTableViewController
- (UIView *)headerView {
    if (!_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}

// 重写父类的指定初始化方法：调用自己的指定初始化方法
- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:UITableViewStylePlain];
//    if(self){
//        for (int i=0; i<5; i++) {
//            [[TLItemStore sharedStore] createItem];
//        }
//    }
    return self;
}


- (IBAction)addNewItem:(id)sender{
    TLItem *item = [[TLItemStore sharedStore] createItem];
    NSInteger lastRow = [[[TLItemStore sharedStore] allItems] indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)toggleEditingMode:(id)sender{
    if (self.editing){
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }else{
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.tableHeaderView = self.headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[TLItemStore sharedStore] allItems].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *allItems = [[TLItemStore sharedStore] allItems];
    TLItem *item = allItems[indexPath.row];
    cell.textLabel.text = [item description];
    return cell;
}

//删除行:必须同时删除UITableViewCell对象与TLItemStore对象
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)
    editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *allItems = [[TLItemStore sharedStore] allItems];
    TLItem *item = allItems[indexPath.row];
    
    [[TLItemStore sharedStore] removeItem:item];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

//移动行：只需移动TLItemStore中的TLItem对象即可
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[TLItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}
@end
