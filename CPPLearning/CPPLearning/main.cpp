//
//  main.cpp
//  CPPLearning
//
//  Created by Xiangjian Meng on 14-4-17.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#include <iostream>
//#include "MyClass.h"
#include "MySubClass.h"

int main(int argc, const char * argv[])
{

    // insert code here...
    std::cout << "Hello, World!\n";
    
    int a = 3;
    
    MyNamespace::MyClass m;
    m.x = 5;
    m.y = 6;
    m.foo(a);
    
    MyNamespace::MyClass *mc = new MyNamespace::MyClass;
    mc->x = 4;
    mc->y = 5;
    mc->foo(a);
    
    std::cout << a;
    
    delete mc;
    
    YourNamespace::MyClass y;
    y.x = 2;
    y.y = 3;
    y.foo(a);
    
    YourNamespace::MyClass *yo = new YourNamespace::MyClass;
    yo->x = 2;
    yo->y = 3;
    yo->foo(a);
    
    std::cout << a;
    
    delete  yo;
    
    MySubClass s;
    s.x = 2;
    s.y = 3;
    s.foo(a);
    
    MySubClass *ms = new MySubClass();
    ms->x = 2;
    ms->y = 4;
    ms->foo(a);
    
    std::cout << a;
    
    delete ms;
    
    return 0;
}

