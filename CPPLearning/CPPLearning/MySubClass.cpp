//
//  MySubClass.cpp
//  CPPLearning
//
//  Created by Xiangjian Meng on 14-4-22.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#include "MySubClass.h"


void MySubClass::foo(int &x)
{
    MyNamespace::MyClass *f = (MyNamespace::MyClass *)this;
    f->foo(x);
    x = 10;
}