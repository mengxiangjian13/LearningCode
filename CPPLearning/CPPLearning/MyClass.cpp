//
//  MyClass.cpp
//  CPPLearning
//
//  Created by Xiangjian Meng on 14-4-17.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#include "MyClass.h"


void MyNamespace::MyClass::foo(int &x)
{
    x = 6;
    this->another();
}

void YourNamespace::MyClass::foo(int &x)
{
    x = 7;
    this->another();
}

void YourNamespace::MyClass::another()
{
    std::cout << "调到这里yourname";
}

void MyNamespace::MyClass::another()
{
    std::cout << "调到这里myname";
}