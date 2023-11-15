#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GJEmptyViewLoader.h"
#import "UICollectionView+GJLoader.h"
#import "UITableView+GJLoader.h"

FOUNDATION_EXPORT double GJEmptyViewLoaderVersionNumber;
FOUNDATION_EXPORT const unsigned char GJEmptyViewLoaderVersionString[];

