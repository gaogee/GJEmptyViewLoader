//
//  UITableView+GJLoader.m
//  GJEmptyViewLoader
//
//  Created by zhanggaoju on 2023/11/15.
//

#import "UITableView+GJLoader.h"
#import <objc/runtime.h>
@implementation NSObject (swizzle)
+ (void)swizzleInstanceSelector:(SEL)originalSel swizzledSelector:(SEL)swizzledSel{
    
    Method originMethod = class_getInstanceMethod(self, originalSel);
    Method swizzedMehtod = class_getInstanceMethod(self, swizzledSel);
    BOOL methodAdded = class_addMethod(self, originalSel, method_getImplementation(swizzedMehtod), method_getTypeEncoding(swizzedMehtod));
    
    if (methodAdded) {
        class_replaceMethod(self, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMehtod);
    }
}
@end

@implementation UITableView (GJLoader)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSelector:@selector(reloadData) swizzledSelector:@selector(swizzed_reloadData)];
    });
}
-(void)setEmptyView:(UIView *)emptyView{
    [self addSubview:emptyView];
    emptyView.hidden = YES;
    objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)emptyView{
    return objc_getAssociatedObject(self, @selector(emptyView));
}
- (void)swizzed_reloadData {
    [self swizzed_reloadData];
}
-(void)startLoading{
    self.emptyView.hidden = YES;
}
-(void)endLoading{
    self.emptyView.hidden = ![self checkEmpty];
}
- (BOOL)checkEmpty {
    BOOL isEmpty = NO;
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    if (sections<=0) {
        isEmpty = YES;
    }else{
        for (int i = 0; i < sections; i++) {
            NSInteger rows = [src tableView:self numberOfRowsInSection:i];
            isEmpty = rows?NO:YES;
        }
    }
    return isEmpty;
}
@end
