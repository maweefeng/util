//
//  AddressBookManager.h
//  HealthChengDuTKT
//
//  Created by 实习生 on 2017/1/23.
//  Copyright © 2017 WeDoctor Group.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <ContactsUI/ContactsUI.h>
#import <ContactsUI/CNContactViewController.h>
#import <ContactsUI/CNContactPickerViewController.h>
#import "PMViewController.h"

@interface AddressBookManager : PMViewController
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* name;
//授权
- (void)askUserWithSuccess:(void (^)())success failure:(void (^)())failure;
//检查电话是否重复
- (BOOL)existPhone:(NSString*)phoneNum;
//添加通讯录
- (BOOL)creatNewRecord:(NSString*)Name Moble:(NSString*)moblie And:(NSString*)moblie2;
@end
