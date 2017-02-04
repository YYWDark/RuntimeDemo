//
//  main.m
//  RuntimeDemo
//
//  Created by wyy on 2017/2/3.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import <objc/runtime.h>
void getMethod();
void getProperty();
void getIvars();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        getMethod();
//        getProperty();
        getIvars();
    }
    return 0;
}

void getMethod() {
    Class cls = [Student class];
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(cls, &methodCount);
    NSLog(@"方法的数量：%d",methodCount);
    if(methods){
        //你会发现有.cxx_destruct的方法名称，关于这点你可以http://blog.sunnyxx.com/2014/04/02/objc_dig_arc_dealloc/
        for (unsigned int i = 0; i < methodCount; i++) {
            SEL sel = method_getName(methods[i]);
            NSLog(@"方法的名称:%@",NSStringFromSelector(sel));
             //v16@0:8 分别代表返回类型 参数类型 方法
            const char *typeEncoding = method_getTypeEncoding(methods[i]);
            NSLog(@"typeEncoding:%@",[NSString stringWithUTF8String:typeEncoding]);
            char *returnType = method_copyReturnType(methods[i]);
            //返回类型
            if (returnType) {
                NSLog(@"返回类型:%@",[NSString stringWithUTF8String:returnType]);
                free(returnType);
            }
        }
    }
}

void getProperty() {
    Class cls = [Student class];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    if (properties) {
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            unsigned int count1;
            objc_property_attribute_t *attrs = property_copyAttributeList(property, &count1);
            for (unsigned int j = 0; j < count1; j++) {
                objc_property_attribute_t attr = attrs[j];
                const char * name = attr.name;
                const char * value = attr.value;
                NSLog(@"属性的描述：%s 值：%s", name, value);
            }
            
            const char *name = property_getName(property);
            if (name) {
                 NSLog(@"属性值 = %@",[NSString stringWithUTF8String:name]);
            }
        }
        free(properties);
        
        
    }

}

void getIvars() {
    unsigned int ivarCount = 0;
    Class cls = [Student class];
    Ivar *ivars = class_copyIvarList(cls, &ivarCount);
    if (ivars) {
        for (unsigned int i = 0; i < ivarCount; i++) {
            const char *name = ivar_getName(ivars[i]);
            NSLog(@"属性或者变量值 = %@",[NSString stringWithUTF8String:name]);

        }
        free(ivars);
    }
}
