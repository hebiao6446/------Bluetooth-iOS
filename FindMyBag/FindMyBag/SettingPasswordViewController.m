//
//  SettingPasswordViewController.m
//  FindMyBag
//
//  Created by hebiao on 15/7/29.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "SettingPasswordViewController.h"
#import "HeadFile.h"

@interface SettingPasswordViewController ()

@end

@implementation SettingPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_26", nil);
    
    inputCount=0;
    
    
    
    inputDictionary=[[NSMutableDictionary alloc] init];
    
    
    
    txtLabel=[[UILabel alloc] init];
    txtLabel.frame=CGRectMake(0, 20, self.view.frame.size.width, 40);
    if (self.operaType==PasswordOperationTypeOpen) {
         txtLabel.text=CustomLocalizedString(@"text_string_27", nil);
    }else{
         txtLabel.text=CustomLocalizedString(@"text_string_29", nil);
    }
   
    txtLabel.font=[UIFont systemFontOfSize:20];
    txtLabel.textColor=UICOLOR_SYSTEM_GREEN_COLOR_1;
    txtLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:txtLabel];
    
    
    
    
    float xy=(self.view.frame.size.width-60)/4;
    
    
    
    
    warnLabel=[[UILabel alloc] init];
    warnLabel.frame=CGRectMake(0, 20+xy+65, self.view.frame.size.width, 40);
    warnLabel.text=CustomLocalizedString(@"text_string_30", nil);
    warnLabel.font=[UIFont systemFontOfSize:20];
    warnLabel.textColor=UICOLOR_SYSTEM_GREEN_COLOR_1;
    warnLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:warnLabel];
    warnLabel.hidden=YES;
    
    
    
    
    
    
    
    
    textField1=[[UITextField alloc] init];
    textField1.frame=CGRectMake(15, 70, xy, xy);
    textField1.layer.borderColor=[UICOLOR_SYSTEM_GREEN_COLOR_1 CGColor];
    textField1.layer.borderWidth=1;
    textField1.font=[UIFont systemFontOfSize:30];
    textField1.borderStyle=UITextBorderStyleBezel;
    textField1.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textField1.textAlignment=NSTextAlignmentCenter;
    textField1.autocapitalizationType=UITextAutocapitalizationTypeNone; //首字母不大写
    textField1.autocorrectionType = UITextAutocorrectionTypeNo;// 不执行自动更正单词
    textField1.delegate=self;
    [textField1 addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    textField1.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:textField1];
    [textField1 becomeFirstResponder];
    
    
    
    textField2=[[UITextField alloc] init];
    textField2.frame=CGRectMake(15+xy+10, 70, xy, xy);
    textField2.layer.borderColor=[UICOLOR_SYSTEM_GREEN_COLOR_1 CGColor];
    textField2.layer.borderWidth=1;
    textField2.font=[UIFont systemFontOfSize:30];
    textField2.borderStyle=UITextBorderStyleBezel;
    textField2.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textField2.textAlignment=NSTextAlignmentCenter;
    textField2.autocapitalizationType=UITextAutocapitalizationTypeNone; //首字母不大写
    textField2.autocorrectionType = UITextAutocorrectionTypeNo;// 不执行自动更正单词
    textField2.delegate=self;
    [textField2 addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    textField2.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:textField2];
    
    
    textField3=[[UITextField alloc] init];
    textField3.frame=CGRectMake(15+xy+10+xy+10, 70, xy, xy);
    textField3.layer.borderColor=[UICOLOR_SYSTEM_GREEN_COLOR_1 CGColor];
    textField3.layer.borderWidth=1;
    textField3.font=[UIFont systemFontOfSize:30];
    textField3.borderStyle=UITextBorderStyleBezel;
    textField3.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textField3.textAlignment=NSTextAlignmentCenter;
    textField3.autocapitalizationType=UITextAutocapitalizationTypeNone; //首字母不大写
    textField3.autocorrectionType = UITextAutocorrectionTypeNo;// 不执行自动更正单词
    textField3.delegate=self;
    [textField3 addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    textField3.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:textField3];
    
    textField4=[[UITextField alloc] init];
    textField4.frame=CGRectMake(15+xy+10+xy+10+xy+10, 70, xy, xy);
    textField4.layer.borderColor=[UICOLOR_SYSTEM_GREEN_COLOR_1 CGColor];
    textField4.layer.borderWidth=1;
    textField4.font=[UIFont systemFontOfSize:30];
    textField4.borderStyle=UITextBorderStyleBezel;
    textField4.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textField4.textAlignment=NSTextAlignmentCenter;
    textField4.autocapitalizationType=UITextAutocapitalizationTypeNone; //首字母不大写
    textField4.autocorrectionType = UITextAutocorrectionTypeNo;// 不执行自动更正单词
    textField4.delegate=self;
    [textField4 addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    textField4.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:textField4];
}

-(void)hideWarn:(id)sender{
    warnLabel.hidden=YES;
    
    
    
}
-(void)textChange:(UITextField *)sender{
    
   
    
    if (sender.text.length>0) {
        if (sender==textField1) {
            [textField2 becomeFirstResponder];
        }else if (sender==textField2){
            [textField3 becomeFirstResponder];
        }else if (sender==textField3){
            [textField4 becomeFirstResponder];
        }else if (sender==textField4){
            
            inputCount ++;
            
            
            if (self.operaType==PasswordOperationTypeOpen) {
                [self passwordOperationTypeOpenAction];
            }else if (self.operaType==PasswordOperationTypeClose){
                [self passwordOperationTypeCloseAction];
            }else if (self.operaType==PasswordOperationTypeChange){
                
                [self passwordOperationTypeChangeAction];
            }
            
            
            
           
            
            
        }
    }
    
    
}
///// 打开密码
-(void)passwordOperationTypeOpenAction{
     NSDictionary *d=@{@"key1":textField1.text,@"key2":textField2.text,@"key3":textField3.text,@"key4":textField4.text};
    if (inputCount==1) {
        
         [inputDictionary setDictionary:d];
    }else{
        
        
        
        
        if ([d isEqualToDictionary:inputDictionary]) {
            
            NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
            [def setObject:d forKey:NSUSERDEFAULTS_PASSWORD_4];
            [def setBool:YES forKey:NSUSERDEFAULTS_HAVE_PASSWORD_3];
            [def synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
        }else{
            
        warnLabel.text=CustomLocalizedString(@"text_string_30", nil);
            warnLabel.hidden=NO;
            [self performSelector:@selector(hideWarn:) withObject:nil afterDelay:1.5];
        }
    }
    
    
    txtLabel.text=CustomLocalizedString(@"text_string_28", nil);
    
    [textField1 becomeFirstResponder];
    textField1.text=@"";
    textField2.text=@"";
    textField3.text=@"";
    textField4.text=@"";
    
}

///// 关闭密码
-(void)passwordOperationTypeCloseAction{
    
    
    
    NSDictionary *d=@{@"key1":textField1.text,@"key2":textField2.text,@"key3":textField3.text,@"key4":textField4.text};
    
    
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults] objectForKey:NSUSERDEFAULTS_PASSWORD_4];
    
    if ([d isEqualToDictionary:dic]) {
        
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        [def setObject:@{@"key1":@"",@"key2":@"",@"key3":@"",@"key4":@""} forKey:NSUSERDEFAULTS_PASSWORD_4];
        [def setBool:NO forKey:NSUSERDEFAULTS_HAVE_PASSWORD_3];
        [def synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        warnLabel.text=CustomLocalizedString(@"text_string_31", nil);
        warnLabel.hidden=NO;
        [self performSelector:@selector(hideWarn:) withObject:nil afterDelay:1.5];
    }
    
    [inputDictionary setDictionary:d];
    [textField1 becomeFirstResponder];
    textField1.text=@"";
    textField2.text=@"";
    textField3.text=@"";
    textField4.text=@"";
    
    
}
-(void)passwordOperationTypeChangeAction{
    
    
    NSDictionary *d=@{@"key1":textField1.text,@"key2":textField2.text,@"key3":textField3.text,@"key4":textField4.text};
    
    
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults] objectForKey:NSUSERDEFAULTS_PASSWORD_4];
    
    
    if (inputCount==1) {
        
        
        if([d isEqualToDictionary:dic]){
            inputCount++;
            
      txtLabel.text=CustomLocalizedString(@"text_string_27", nil);
        }else{
            
            inputCount=0;
            warnLabel.text=CustomLocalizedString(@"text_string_31", nil);
            warnLabel.hidden=NO;
            [self performSelector:@selector(hideWarn:) withObject:nil afterDelay:1.5];
        }
        
    }else{
        
        if ([inputDictionary count]==0) {
            [inputDictionary setDictionary:d];
            txtLabel.text=CustomLocalizedString(@"text_string_28", nil);
            
        }else{
            
            if ([inputDictionary isEqualToDictionary:d]) {
                
                
                NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
                [def setObject:inputDictionary forKey:NSUSERDEFAULTS_PASSWORD_4];
                [def setBool:YES forKey:NSUSERDEFAULTS_HAVE_PASSWORD_3];
                [def synchronize];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
                
                warnLabel.text=CustomLocalizedString(@"text_string_30", nil);
                warnLabel.hidden=NO;
                [self performSelector:@selector(hideWarn:) withObject:nil afterDelay:1.5];
                
            }
            
        }
        
    }
    
    [textField1 becomeFirstResponder];
    textField1.text=@"";
    textField2.text=@"";
    textField3.text=@"";
    textField4.text=@"";
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text=@"";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
