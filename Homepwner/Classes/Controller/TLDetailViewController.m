//
//  TLDetailViewController.m
//  Homepwner
//
//  Created by lushuishasha on 2016/12/12.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//

#import "TLDetailViewController.h"
#import "TLItem.h"
#import "TLImageStore.h"


@interface TLDetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
//contentMode设置为ScaleToFill 保持宽高比缩放
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation TLDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    TLItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *itemKey = self.item.itemKey;
    UIImage *imageToDisplay = [[TLImageStore sharedStore] imageForKey:itemKey];
    self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //取消当前的第一响应对象
    [self.view endEditing:YES];
    
    TLItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
//init方法中还没有给TLItem赋值，所以要实现setItem方法
- (void)setItem:(TLItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

//为了处理点击事件，TLDetailViewController对象的视图从UIView改为UIControl
- (IBAction)backGroundInside:(id)sender {
    [self.view endEditing:YES];
}

/**
 1.UIImagePickerControllerSourceTypeCamera 用于用户拍摄一张新的照片
 2.UIImagePickerControllerSourceTypePhotoLibrary 用于显示界面 让用户选择相册，然后从选中的相册中选择一张照片
 3.UIImagePickerControllerSourceTypeSavedPhotosAlbum 用于让用户从最近拍摄的照片里选择一张照片
 */
- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        pickerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    pickerVc.delegate = self;
    
    // ios8 在info.plist —Source Code中添加
    //UsageDescription相关的key, 描述字符串自己随意填写就可以,但是一定要填写，不然会引发包无效的问题，导致上传打包后构建版本一直不显示。
    [self presentViewController:pickerVc animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //通过info字典获取选择的照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //以itemKey为键，将照片存入TLImageStore对象
    [[TLImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
