//
//  SomeUser.m
//  FHW
//
//  Created by Никита Попов on 19.03.24.
//

#import "SomeUser.h"

@implementation SomeUser

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.bd forKey:@"bd"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.bd = [decoder decodeObjectForKey:@"bd"];
    }
    return self;
}
@end
