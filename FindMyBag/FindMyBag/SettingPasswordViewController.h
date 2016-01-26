//
//  SettingPasswordViewController.h
//  FindMyBag
//
//  Created by hebiao on 15/7/29.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "BaseViewController.h"
#import "ConstantPart.h"



@interface SettingPasswordViewController : BaseViewController<UITextFieldDelegate>{
    
    UITextField *textField1,*textField2,*textField3,*textField4;
    UILabel *txtLabel;
    
    UILabel *warnLabel;
    
    
    
    NSMutableDictionary *inputDictionary;
  
    
    int  inputCount;
    
    
}

@property PasswordOperationType operaType;


@end
