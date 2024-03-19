//
//  NextScr.m
//  FHW
//
//  Created by Никита Попов on 19.03.24.
//

#import "NextScr.h"
#import <objc/runtime.h>

@interface NextScr ()

@end

@implementation NextScr

-(void) newViewDidLoad{
    NSLog(@"new viewDidLoad meth");
}

-(void) newViewWillAppear{
    NSLog(@"new ViewWillAppear meth");
}

-(void) newViewDidAppear{
    NSLog(@"new viewDidAppear meth");
}

-(void) newViewWillDisappear{
    NSLog(@"new ViewWillDisappear meth");
}

-(void) newViewDidDisappear{
    NSLog(@"new ViewDidDisappear meth");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        Method originalMethod = class_getInstanceMethod([UIViewController class], @selector(viewDidLoad));
        Method swapMeth = class_getInstanceMethod([self class], @selector(newViewDidLoad));
        method_exchangeImplementations(originalMethod, swapMeth);
        
        Method originalMethod2 = class_getInstanceMethod([UIViewController class], @selector(viewWillAppear));
        Method swapMeth2 = class_getInstanceMethod([self class], @selector(newViewWillAppear));
        method_exchangeImplementations(originalMethod2, swapMeth2);
        
        Method originalMethod3 = class_getInstanceMethod([UIViewController class], @selector(viewDidAppear));
        Method swapMeth3 = class_getInstanceMethod([self class], @selector(newViewDidAppear));
        method_exchangeImplementations(originalMethod3, swapMeth3);
        
        Method originalMethod4 = class_getInstanceMethod([UIViewController class], @selector(viewWillDisappear));
        Method swapMeth4 = class_getInstanceMethod([self class], @selector(newViewWillDisappear));
        method_exchangeImplementations(originalMethod4, swapMeth4);
        
        Method originalMethod5 = class_getInstanceMethod([UIViewController class], @selector(viewDidDisappear));
        Method swapMeth5 = class_getInstanceMethod([self class], @selector(newViewDidDisappear));
        method_exchangeImplementations(originalMethod5, swapMeth5);
        
    }
    return self;
}

@end
