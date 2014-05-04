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
#include "Car.h"

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
    
    MySubClass mms = s + 2;
    std::cout << "lll" << mms.x;
    
    MySubClass *ms = new MySubClass();
    ms->x = 2;
    ms->y = 4;
    ms->foo(a);
    
    std::cout << a;
    
    std::cout << "vector第三个元素是" << s.intArray.at(2)<< "\n";
    std::cout << "vector第四个元素是" << ms->intArray.at(3)<< "\n";
    
    std::list<int>::iterator i;
    int j=0;
    for (i = s.intList.begin(); i != s.intList.end(); i ++)
    {
        int thisInt = *i;
        j++;
        std::cout << "list第"<< j << "个元素是" << thisInt << "\n";
    }
    
    delete ms;
    
    Car fordCar;
    fordCar.name = "ford";
    Tyre *fordCarTyre = new Tyre(4);
    fordCar.tyre = fordCarTyre;
    
    Car audiCar;
    audiCar.name = "audi";
    Tyre *audiCarTyre = new Tyre(3);
    audiCar.tyre = audiCarTyre;
    
    Car bmwCar;
    bmwCar.name = "bmw";
    Tyre *bmwCarTyre = new Tyre(5);
    bmwCar.tyre = bmwCarTyre;
    
    std::vector<Car> *carArray = new std::vector<Car>;
    carArray->push_back(fordCar);
    carArray->push_back(audiCar);
    carArray->push_back(bmwCar);
    
    for (int h=0; h<carArray->size(); h++)
    {
        std::string name = carArray->at(h).name;
        std::cout << "第" << h << "种车的名字是" << name << ",";
        std::cout << "这部车有" << carArray->at(h).tyre->count << "个车轮" << "\n";
    }
    
    delete carArray;
    
    return 0;
}

