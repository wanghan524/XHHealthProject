//
//  InterfaceDefine.h
//  WebServiceDemo
//
//  Created by art_kernel_zyc on 14/12/15.
//  Copyright (c) 2014年 art_kernel_zyc. All rights reserved.
//

#ifndef WebServiceDemo_InterfaceDefine_h
#define WebServiceDemo_InterfaceDefine_h



typedef enum ResponseType
{
    XML = 1,
    JSON
    
}RETURNTYPE;


#define NAMESPACE @"http://www.dhi-net.com/BeiJingHoLi/index.html"
#define SOPAACTION @"http://www.dhi-net.com/BeiJingHoLi/index.html/"



//#define WEBSERVICEDOMAIN @"http://202.105.12.131:11000/JHMobileWCFService?wsdl"
//#define WEBSERVICEDOMAIN @"http://192.168.60.9:12000/JHMobileWCFService?wsdl"

#define WEBSERVICEDOMAIN @"http://59.108.16.234/Service.asmx"
//用户登录
#define ONLOGIN @"UserLogin"

#define DISEASESTATUS @"GetDiseaseStatusByIDNumber"

#define USERINFO @"GetUserInfoByIDNumber"

#define LIFRSTYLE @"GetLifeStyleByIDNumber"

#define PHYSICALEXAM @"GetPhysicalExamByIDNumber"



//根据身份证号获取体质数据
#define FITNESS @"GetFitnessByIDNumber"
//身体成分
#define BODYCOM @"GetBodyCompositionByIDNumber"


#endif
