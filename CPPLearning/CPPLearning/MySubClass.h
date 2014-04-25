//
//  MySubClass.h
//  CPPLearning
//
//  Created by Xiangjian Meng on 14-4-22.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#ifndef __CPPLearning__MySubClass__
#define __CPPLearning__MySubClass__

#include <iostream>
#include "MyClass.h"
#include <vector>
#include <list>

class MySubClass : public MyNamespace::MyClass{
    
public:
    std::vector<int> intArray;
    std::list<int> intList;
    void foo(int &x);
    //构造函数       //同时调用父类的构造函数
    MySubClass(int a, int b) : MyNamespace::MyClass()
    {
        x = a;
        y = b;
    }
    
    MySubClass() : MyNamespace::MyClass()
    {
        x = 0;
        y = 0;
        intArray.push_back(1);
        intArray.push_back(2);
        intArray.push_back(3);
        intArray.push_back(4);
        intArray.push_back(5);
        
        intList.push_back(1);
        intList.push_back(2);
        intList.push_back(3);
        intList.push_back(4);
        intList.push_back(5);
    }
    
    //析构函数 ~
    ~MySubClass(){
        printf("dddd\n");
    }
    
    MySubClass operator+(const int &a)
    {
        return MySubClass(x+a,y+a);
    }
    
};

#endif /* defined(__CPPLearning__MySubClass__) */
