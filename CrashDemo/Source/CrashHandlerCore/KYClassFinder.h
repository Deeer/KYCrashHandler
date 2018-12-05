//
//  KYClassFinder.h
//  CrashDemo
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018 apple. All rights reserved.
//

#ifndef KYClassFinder_h
#define KYClassFinder_h
#import <objc/runtime.h>
static inline NSArray * findSubClass(Class certainClass) {
    int numOfSubclasses = 0;
    Class *classes = NULL;
    // 获取所有已注册的类
    numOfSubclasses = objc_getClassList(NULL, 0);
    
    if (numOfSubclasses <= 0) {
        return [NSMutableArray array];
    }
    
    classes = (Class *)malloc(sizeof(Class) * numOfSubclasses);
    objc_getClassList(classes, numOfSubclasses);
    NSArray *classArray = @[];
    for (int i = 0; i < numOfSubclasses; i++) {
        if (certainClass == class_getSuperclass(classes[i])) {
            classArray = @[classes[i]];
            break;
        }
    }
    
    free(classes);
    return classArray;
}

#endif /* KYClassFinder_h */
