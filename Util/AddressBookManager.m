//
//  AddressBookManager.m
//  HealthChengDuTKT
//
//  Created by 实习生 on 2017/1/23.
//  Copyright © 2017 WeDoctor Group.. All rights reserved.
//

#import "AddressBookManager.h"

@interface AddressBookManager()<CNContactPickerDelegate,CNContactViewControllerDelegate>
@property(nonatomic, strong)CNContactViewController *controller;
@property(nonatomic, strong)CNContactStore *contactStore;
@end


@implementation AddressBookManager


//初次加载
//CNAuthorizationStatusNotDetermined = 0,
//应用程序未授权访问联系人
//CNAuthorizationStatusRestricted,
//拒绝访问通讯录
//CNAuthorizationStatusDenied,
//授权访问联系人数据的应用程序。
//CNAuthorizationStatusAuthorized
//获取访问状态
//+ (CNAuthorizationStatus)authorizationStatusForEntityType:(CNEntityType)entityType;

typedef NS_ENUM(NSUInteger, AddressBookStatus) {
    AddressBookStatusError = 0,
    AddressBookStatusSuccess
};


- (BOOL)existPhone:(NSString*)phoneNum{
    if(isIos8){
       return [self existPhoneIos8:phoneNum];
    }else{
       return [self existPhoneIos9:phoneNum];
    }
}
-(CNContactStore*)contactStore{
    if(!_contactStore){
        _contactStore=[[CNContactStore alloc]init];
    }
    return _contactStore;
}
- (BOOL)existPhoneIos8:(NSString*)phoneNum{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    CFArrayRef records;
    // 获取通讯录中全部联系人
    records = ABAddressBookCopyArrayOfAllPeople(addressBook);
    // 遍历全部联系人，检查是否存在指定号码
    CFIndex peopleCount = CFArrayGetCount(records);
    for (int i=0; i<peopleCount; i++)
    {
        ABRecordRef record = CFArrayGetValueAtIndex(records, i);
        CFTypeRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
        CFArrayRef phoneNums = ABMultiValueCopyArrayOfAllValues(phones);
        if (phoneNums)
        {
            for (int j=0; j<CFArrayGetCount(phoneNums); j++)
            {
                NSString *phone = (NSString*)CFArrayGetValueAtIndex(phoneNums, j);
                if ([phone isEqualToString:phoneNum])
                {
                    return YES;
                }
            }
        }
    }
    CFRelease(addressBook);
    return NO;
}
- (BOOL)existPhoneIos9:(NSString*)phoneNumValue{
    if(!phoneNumValue){
        phoneNumValue=@"";
    }
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        
    }
    CNContactStore *store = [[CNContactStore alloc]init];
    NSError *error = nil;
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc]initWithKeysToFetch:@[CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]];
    __block bool isPhone= false;
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        NSString *phone = [NSString string];
        for (CNLabeledValue *value in contact.phoneNumbers) {
            CNPhoneNumber *phoneNum = value.value;
            phone = phoneNum.stringValue; //电话
            if([phone isEqualToString:phoneNumValue]){
                isPhone = true;
            }
        }
    }];
    return isPhone;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"";
  // [self saveNewContact];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)saveNewContact{
    //1.创建Contact对象，须是可变
    CNMutableContact *contact = [[CNMutableContact alloc] init];
    //2.为contact赋值
    [self setValueForContact:contact existContect:NO];
    //3.创建新建联系人页面
    _controller = [CNContactViewController viewControllerForNewContact:contact];
    //代理内容根据自己需要实现
    _controller.delegate = self;
    //4.跳转
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:_controller];
    [self presentViewController:navigation animated:YES completion:^{
    }];

}
- (void)setValueForContact:(CNMutableContact *)contact existContect:(BOOL)exist{
    if (!exist) {
        contact.familyName = self.name;
    }
    //电话
    CNLabeledValue *phoneNumber = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile value:[CNPhoneNumber phoneNumberWithStringValue:self.phone]];
    if (!exist) {
        contact.phoneNumbers = @[phoneNumber];
    }
    //现有联系人情况
    else{
        if ([contact.phoneNumbers count] >0) {
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] initWithArray:contact.phoneNumbers];
            [phoneNumbers addObject:phoneNumber];
            contact.phoneNumbers = phoneNumbers;
        }else{
            contact.phoneNumbers = @[phoneNumber];
        }
    }
}

- (NSMutableArray *)fetchContactWithAddressBook:(ABAddressBookRef)addressBook{
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {////有权限访问
        //获取联系人数组
        NSArray *array = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        NSMutableArray *contacts = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            //获取联系人
            ABRecordRef people = CFArrayGetValueAtIndex((__bridge ABRecordRef)array, i);
            //获取联系人详细信息,如:姓名,电话,住址等信息
            NSString *firstName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonFirstNameProperty);
            NSString *lastName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonLastNameProperty);
            ABMutableMultiValueRef *phoneNumRef = ABRecordCopyValue(people, kABPersonPhoneProperty);
            NSString *phoneNumber =  ((__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneNumRef)).lastObject;
            [contacts addObject:@{@"name": [firstName stringByAppendingString:lastName], @"phoneNumber": phoneNumber}];
        }
        return contacts;
    }else{//无权限访问
        NSLog(@"无权限访问通讯录");
        return nil;
    }
}

- (BOOL)contactViewController:(CNContactViewController *)viewController shouldPerformDefaultActionForContactProperty:(CNContactProperty *)property{
    return YES;
}

/*!
 * @abstract Called when the view has completed.
 * @discussion If creating a new contact, the new contact added to the contacts list will be passed.
 * If adding to an existing contact, the existing contact will be passed.
 * @note It is up to the delegate to dismiss the view controller.
 */
- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(nullable CNContact *)contact{
  //  if([self.navigationController.viewControllers count] > 2){
        //倒数第二个
  //      id viewCtrl = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 2];
  //      [self.navigationController popToViewController:viewCtrl animated:NO];
  //  }
   // [viewController dismissViewControllerAnimated:YES completion:^{
  //  }];
}
//1成功： 0失败
- (BOOL)creatNewRecord:(NSString*)Name Moble:(NSString*)moblie And:(NSString*)moblie2
 {
     CFErrorRef error = NULL;
     //创建一个通讯录操作对象
     ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);

     //创建一条新的联系人纪录
     ABRecordRef newRecord = ABPersonCreate();

     //为新联系人记录添加属性值
     ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)Name, &error);

     //创建一个多值属性(电话)
     ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
     ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)moblie, kABPersonPhoneMobileLabel, NULL);
     ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)moblie2, kABPersonPhoneMobileLabel, NULL);

     ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
     ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
     //添加email
    // ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    // ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFTypeRef)([_infoDictionary objectForKey:@"email"]), kABWorkLabel, NULL);
    // ABRecordSetValue(newRecord, kABPersonEmailProperty, multiEmail, &error);


     //添加记录到通讯录操作对象
     ABAddressBookAddRecord(addressBook, newRecord, &error);

     //保存通讯录操作对象
     ABAddressBookSave(addressBook, &error);
     __block BOOL k=false;
     //通过此接口访问系统通讯录
     ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
         if (granted) {
             k=true;
             //显示提示
             //if (isIos8) {
             //   UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"添加成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
             //   UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
             //        [self dismissViewControllerAnimated:YES completion:nil];

             //    }];
             //    [alertVc addAction:alertAction];
             //    [self presentViewController:alertVc animated:YES completion:nil];
             //}else{

             //    UIAlertView *tipView = [[UIAlertView alloc] initWithTitle:nil message:@"添加成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
             //    [tipView show];
             //}
         }
     });
     
    // CFRelease(multiEmail);
     CFRelease(multi);
     CFRelease(newRecord);
     CFRelease(addressBook);
     return k;
 }



- (void)askUserWithSuccess:(void (^)())success failure:(void (^)())failure
{
    if(isIos8){
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            if(granted){
                dispatch_async(dispatch_get_main_queue(), ^{
                    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
                    if(status ==CNAuthorizationStatusAuthorized){
                        success();
                    }else{
                        failure();
                    }
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure();
                });
            }
        });
    }else{
        [self.contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted){
                dispatch_async(dispatch_get_main_queue(), ^{
                    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                    if (status == CNAuthorizationStatusAuthorized) {
                        success();
                    }else{
                        failure();
                    }
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure();
                });
            }
        }];
    }
}
@end
