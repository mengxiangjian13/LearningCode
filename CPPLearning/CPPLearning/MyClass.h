//
//  MyClass.h
//  CPPLearning
//
//  Created by Xiangjian Meng on 14-4-17.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#ifndef __CPPLearning__MyClass__
#define __CPPLearning__MyClass__

#include <iostream>

namespace MyNamespace {
    class MyClass {
    public:
        int x;
        int y;
        
    public:
        void foo(int &x);
    
    private:
        void another();
    };
}

namespace YourNamespace {
    class MyClass {
    public:
        int x;
        int y;
        
    public:
        void foo(int &x);
        
    private:
        void another();
    };
}



#endif /* defined(__CPPLearning__MyClass__) */
