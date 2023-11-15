//
//  UITableView+GJLoader.h
//  GJEmptyViewLoader
//
//  Created by zhanggaoju on 2023/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (GJLoader)

@property (nonatomic, strong) UIView *emptyView;

-(void)startLoading;

-(void)endLoading;

@end

NS_ASSUME_NONNULL_END
