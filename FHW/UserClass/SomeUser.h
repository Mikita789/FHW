//
//  SomeUser.h
//  FHW
//
//  Created by Никита Попов on 19.03.24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SomeUser : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *bd;

@end

NS_ASSUME_NONNULL_END
