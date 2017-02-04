//
//  Student.h
//  RuntimeDemo
//
//  Created by wyy on 2017/2/3.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject {
    CGFloat width;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;

- (void)gotoSchool;
@end
