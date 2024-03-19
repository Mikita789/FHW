//
//  ViewController.m
//  FHW
//
//  Created by Никита Попов on 19.03.24.
//

#import "ViewController.h"
#import "SomeUser.h"
#import "SAMKeychain.h"
#import "Nextscr.h"




@interface ViewController ()

@property UITextField *nameTF;
@property UITextField *lastNameTF;
@property UITextField *bdTF;
@property UIButton *saveButton;
@property UIButton *nextScrButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x - 100, 50, 200, 30)];
    self.nameTF.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTF.placeholder = @"enter name";
    [self.view addSubview:self.nameTF];
    
    self.lastNameTF = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x - 100, 100, 200, 30)];
    self.lastNameTF.borderStyle = UITextBorderStyleRoundedRect;
    self.lastNameTF.placeholder = @"enter last name";
    [self.view addSubview:self.lastNameTF];
    
    self.bdTF = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x - 100, 150, 200, 30)];
    self.bdTF.borderStyle = UITextBorderStyleRoundedRect;
    self.bdTF.placeholder = @"enter your birthday";
    [self.view addSubview:self.bdTF];
    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 100, 200, 200, 50)];
    [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.backgroundColor = UIColor.systemMintColor;
    [self.view addSubview:self.saveButton];
    
    self.nextScrButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 100, 350, 200, 50)];
    [_nextScrButton setTitle:@"Next Scr" forState:UIControlStateNormal];
    [_nextScrButton addTarget:self action:@selector(nextScrButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.nextScrButton.backgroundColor = UIColor.systemMintColor;
    [self.view addSubview:self.nextScrButton];
    
    
}

- (void)userDefSaveData:(SomeUser *)user {
    if (![user.name  isEqual: @""]){
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"user"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        NSData *dataRes = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        SomeUser *userRes = [NSKeyedUnarchiver unarchiveObjectWithData:dataRes];
        NSLog(@"SAVED DATA: ______________");
        NSLog(@"Name: %@", userRes.name);
        NSLog(@"Last Name: %@", userRes.lastName);
        NSLog(@"Birth Date: %@", userRes.bd);
        NSLog(@"_______________");
        
        
    }
}

- (void)keyChainSaveData:(SomeUser *)user {
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [SAMKeychain setPasswordData:userData forService:@"MyApp" account:@"user"];
    
    // Получение сохраненного экземпляра класса SomeUser из Keychain
    NSData *savedKCData = [SAMKeychain passwordDataForService:@"MyApp" account:@"user"];
    SomeUser *resUser = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSLog(@"KC DATA : ______");
    
    NSLog(@"Name: %@", resUser.name);
    NSLog(@"Last Name: %@", resUser.lastName);
    NSLog(@"Birth Date: %@", resUser.bd);
    NSLog(@" ___________");
    
}

- (void)prListSaveData:(SomeUser *)user {
    // Преобразование экземпляра класса SomeUser в NSDictionary
    NSDictionary *userDictionary = @{@"name": user.name,
                                     @"lastName": user.lastName,
                                     @"bd": user.bd};
    
    // Сохранение Property List в файл
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"SomeUser.plist"];
    NSError *error;
    NSData *propertyListData = [NSPropertyListSerialization dataWithPropertyList:userDictionary format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    if (propertyListData) {
        if ([propertyListData writeToFile:filePath options:NSDataWritingAtomic error:&error]) {
            NSLog(@"Property List сохранен в %@", filePath);
        } else {
            NSLog(@"Ошибка сохранения Property List: %@", error);
        }
    } else {
        NSLog(@"Ошибка сериализации Property List: %@", error);
    }
    
    // Получение пути к файлу Property List
    NSString *filePathRes = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"SomeUser.plist"];
    
    // Загрузка Property List из файла
    NSData *propertyListDataRes = [NSData dataWithContentsOfFile:filePathRes];
    if (propertyListDataRes) {
        NSError *error;
        id propertyList = [NSPropertyListSerialization propertyListWithData:propertyListData options:0 format:NULL error:&error];
        if (propertyList) {
            if ([propertyList isKindOfClass:[NSDictionary class]]) {
                NSDictionary *userDictionary = (NSDictionary *)propertyList;
                
                // Получение данных из Property List
                NSString *name = [userDictionary objectForKey:@"name"];
                NSString *lastName = [userDictionary objectForKey:@"lastName"];
                NSString *bd = [userDictionary objectForKey:@"bd"];
                
                // Создание или обновление экземпляра класса SomeUser
                SomeUser *user = [[SomeUser alloc] init];
                user.name = name;
                user.lastName = lastName;
                user.bd = bd;
                
                // Использование данных
                NSLog(@"PR DATA: ______________");
                
                NSLog(@"Name: %@", user.name);
                NSLog(@"Last Name: %@", user.lastName);
                NSLog(@"Birth Date: %@", user.bd);
                NSLog(@" ______________");
                
            } else {
                NSLog(@"Invalid Property List format. Expected NSDictionary.");
            }
        } else {
            NSLog(@"Error deserializing Property List: %@", error);
        }
    } else {
        NSLog(@"Error reading Property List file.");
    }
    
    
}

- (void)errorGenerate:(NSInteger *)index{
    NSArray *array = @[@"Apple", @"Banana", @"Orange"];
    @try {
        // Возможный код, который может вызвать исключение
        NSString *element = [array objectAtIndex:index];
        NSLog(@"Element: %@", element);
    }
    @catch (NSException *exception) {
        // Обработка исключения
        NSLog(@"Исключение произошло: %@", exception);
    }
    @finally {
        // Код, который будет выполнен независимо от наличия исключения
        NSLog(@"Блок finally выполнен");
    }
    
}

- (void)saveButtonTapped:(UIButton *)sender {
    NSString *nameText = self.nameTF.text;
    NSString *lastNameText = self.lastNameTF.text;
    NSString *bdText = self.bdTF.text;
    NSLog(@"%@, %@, %@", nameText, lastNameText, bdText);
    
    SomeUser *user = [[SomeUser alloc] init];
    user.name = nameText;
    user.lastName = lastNameText;
    user.bd = bdText;
    //UD
    [self userDefSaveData:user];
    
    //KC
    [self keyChainSaveData:user];
    
    //pr list
    [self prListSaveData:user];
    
    [self errorGenerate:100];
    
    
}


- (void)nextScrButtonTapped:(UIButton *)sender{
    UIViewController *nextViewController = [[NextScr alloc] init];
    [self presentViewController:nextViewController animated:YES completion:nil];
}

@end
