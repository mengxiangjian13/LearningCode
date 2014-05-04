//
//  Car.h
//  CPPLearning
//
//  Created by Xiangjian Meng on 14-5-4.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#ifndef __CPPLearning__Car__
#define __CPPLearning__Car__

#include <iostream>
#include <string>
#include "Tyre.h"

class Car {
    
public:
    std::string name;
    Tyre *tyre;
};


#endif /* defined(__CPPLearning__Car__) */
