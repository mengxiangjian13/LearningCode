//
//  Tyre.h
//  CPPLearning
//
//  Created by Xiangjian Meng on 14-5-4.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#ifndef __CPPLearning__Tyre__
#define __CPPLearning__Tyre__

#include <iostream>

class Tyre {
public:
    int count;
    Tyre(int tyreCount)
    {
        count = tyreCount;
    }
    
    ~Tyre()
    {
        std::cout << "汽车的轮胎被卸掉了";
    }
};

#endif /* defined(__CPPLearning__Tyre__) */
