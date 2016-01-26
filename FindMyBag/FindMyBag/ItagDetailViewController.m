//
//  ItagDetailViewController.m
//  FindMyBag
//
//  Created by hebiao on 15-7-30.
//  Copyright (c) 2015年 hebiao. All rights reserved.
//

#import "ItagDetailViewController.h"
#import "HeadFile.h"
#import "ItagDetailTableViewCell.h"
#import "AntiLostViewController.h"
#import "SearchingTagViewController.h"

#import "DeviceBean.h"

#import "LostBean.h"
@interface ItagDetailViewController ()

@end

@implementation ItagDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nagationLabel.text=CustomLocalizedString(@"nagation_title_8", nil);
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
    
    
    
    
    imgView=[[UIImageView alloc] init];
    imgView.frame=CGRectMake(20, 15+35, 70, 70);
    imgView.layer.masksToBounds=YES;
    imgView.layer.cornerRadius=4.5;
    imgView.layer.backgroundColor=[[UIColor clearColor]CGColor];
    [imgView setImage:[UIImage imageNamed:@"Icon-60"]];
    [table addSubview:imgView];
    
 
    
    
    
    nameTextField=[[UITextField alloc] init];
    nameTextField.frame=CGRectMake(110, 15+35+15, 200, 40);
    nameTextField.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    nameTextField.layer.borderWidth=1;
    nameTextField.font=[UIFont systemFontOfSize:20];
//    nameTextField.borderStyle=UITextBorderStyleLine;
    nameTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    nameTextField.textAlignment=NSTextAlignmentLeft;
    nameTextField.autocapitalizationType=UITextAutocapitalizationTypeNone; //首字母不大写
    nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;// 不执行自动更正单词
    nameTextField.delegate=self;
    nameTextField.returnKeyType=UIReturnKeyDone;
    [table addSubview:nameTextField];
    
    
   
    UIButton *button=[[UIButton alloc] init];
    button.frame=CGRectMake(0, 0, 70, 70);
    button.center=imgView.center;
    [button addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    [table addSubview:button];
    
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getDeviceBeanMsg];
}

-(void)getDeviceBeanMsg{
    
    DeviceBean *db=[DeviceBean getDeviceBeanByUUID:self.UUIDString];
    nameTextField.text=db.tagName;
    
    
    if (db.imageName.length>0&&[StaticFunction localExistenceThisImage:db.imageName]) {
         UIImage *imageFromDictionary = [UIImage imageWithContentsOfFile:[[StaticFunction imageFilePath] stringByAppendingPathComponent:db.imageName]];
        [imgView setImage:imageFromDictionary];
        
    }else{
        [imgView setImage:[UIImage imageNamed:@"Icon-60"]];

    }
    
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length>0) {
        [DeviceBean updateTagName:textField.text uuid:self.UUIDString];
        [LostBean updateLostBeanTagName:textField.text with:self.UUIDString];
        [self.delegate reloadListViewAction];
        
    }
    
}

-(void)photoAction{
    [self.view endEditing:YES];
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:CustomLocalizedString(@"actionsheet_txt_43", nil)
                                  delegate:self
                                  cancelButtonTitle:CustomLocalizedString(@"actionsheet_txt_44", nil)
                                  destructiveButtonTitle:nil
                                  otherButtonTitles: CustomLocalizedString(@"actionsheet_txt_45", nil),CustomLocalizedString(@"actionsheet_txt_46", nil),nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
        
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            //            [self presentModalViewController:imagePickerController animated:YES];
            
            [self presentViewController:imagePickerController animated:YES completion:^{
                
                
                
            }];
            
            
        }
        
        
    }else if (buttonIndex==1){
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        //        [self presentModalViewController:imagePickerController animated:YES];
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
            
            
        }];
        
        
    }
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
   
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    
    
  
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"])
    {
        
        UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
        
        [imgView setImage:image];
        
        
        
        NSString *str=[NSString stringWithFormat:@"%ld",time(NULL)];
        [UIImagePNGRepresentation(image) writeToFile:[[StaticFunction imageFilePath] stringByAppendingPathComponent:str] atomically:YES];
        
        
        [DeviceBean updateImageName:str uuid:self.UUIDString];
        [LostBean updateLostBeanImageName:str with:self.UUIDString];
        
        [self.delegate reloadListViewAction];
        
    }
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 100;
    }
    
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        
        UITableViewCell *cell=[[UITableViewCell alloc] init];
//        cell.selected=NO;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        
        return cell;
        
    }else{
        
        
        ItagDetailTableViewCell *cell=(ItagDetailTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ItagDetailTableViewCell" owner:self options:nil][0];
        
 
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
        NSString *str=[NSString stringWithFormat:@"cell_title_%d",indexPath.row+36];
        
        
        cell.imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"service_%d",indexPath.row+1]];
     cell.txtLabel.text=CustomLocalizedString(str, nil);
        
        
        
        return cell;
    }
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            
            
            AntiLostViewController *alvc=[[AntiLostViewController alloc] init];
            alvc.hidesBottomBarWhenPushed = YES;
            alvc.UUIDString=self.UUIDString;
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationController pushViewController:alvc animated:YES];
            
        }else if (indexPath.row==1){
            SearchingTagViewController *stvc=[[SearchingTagViewController alloc] init];
            stvc.hidesBottomBarWhenPushed = YES;
             stvc.UUIDString=self.UUIDString;
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationController pushViewController:stvc animated:YES];
        }else if (indexPath.row==2){
            
            [self.disConnectdelegate disconnectBluethAction:self.UUIDString];
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
    }else if (indexPath.section==0){
        
        [self photoAction];
        
    }
    
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
