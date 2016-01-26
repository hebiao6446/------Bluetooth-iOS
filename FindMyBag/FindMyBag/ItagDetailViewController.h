//
//  ItagDetailViewController.h
//  FindMyBag
//
//  Created by hebiao on 15-7-30.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "BaseViewController.h"
#import "ReloadListViewDelegate.h"
#import "DisconnectBluethDelegate.h"

@interface ItagDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>{
    
    
    UITableView *table;
    
    UIImageView *imgView;
    
    
      UIImagePickerController *imagePickerController;
    
    
    UITextField *nameTextField;
    
    
}




@property (nonatomic,assign) id<ReloadListViewDelegate>delegate;
@property (nonatomic,assign) id<DisconnectBluethDelegate>disConnectdelegate;

@property (retain) NSString *UUIDString;

@end
