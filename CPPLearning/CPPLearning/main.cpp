//
//  main.cpp
//  CPPLearning
//
//  Created by Xiangjian Meng on 14-4-17.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#include <iostream>
#include "MyClass.h"

int main(int argc, const char * argv[])
{

    // insert code here...
    std::cout << "Hello, World!\n";
    
    int a = 3;
    
    MyClass m;
    m.x = 5;
    m.y = 6;
    m.foo(a);
    
    MyClass *mc = new MyClass;
    mc->x = 4;
    mc->y = 5;
    mc->foo(a);
    
    std::cout << a;
    
    delete mc;
    
    return 0;
}

