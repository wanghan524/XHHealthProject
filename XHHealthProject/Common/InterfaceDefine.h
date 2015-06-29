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


#define WEBSERVICEDOMAIN @"http://59.108.16.234/Service.asmx"
//用户登录
#define ONLOGIN @"UserLogin"

//修改密码
#define CHANGEPASSWORD @"UserPwdChange"

#define DISEASESTATUS @"GetDiseaseStatusByIDNumber"

#define USERINFO @"GetUserInfoByIDNumber"

#define LIFRSTYLE @"GetLifeStyleByIDNumber"

#define PHYSICALEXAM @"GetPhysicalExamByIDNumber"

//血压，心电
#define PRESSANDRACE @"GetBloodPressureByIDNumber"
#define ECG @"GetECGByIDNumber"
//根据身份证号获取体质数据
#define FITNESS @"GetFitnessByIDNumber"
//身体成分
#define BODYCOM @"GetBodyCompositionByIDNumber"

//心功能
#define GARDIAC @"GetCardiacFunctionByIDNumber"

//肺功能
#define PULMONARY @"GetPulmonaryFunctionByIDNumber"

//骨密度
#define BMD @"GetBMDByIDNumber"

//血常规与血型
#define ROUTINEBLOODANDBLOOD @"GetRoutineBloodAndBloodTypeByIDNumber"
//血生化和免疫
#define BIOCHEMISTRYANDIMMUNITY @"GetBiochemistryAndImmunityByIDNumber"



//一般检查
#define EYEGENERALEXAM @"GetEyeGeneralExamByIDNumber"
//眼科屈光检查
#define EYEOPHTHALMOLOGYEXAM @"GetEyeOphthalmologyExamByIDNumber"
//眼科眼底检查
#define EYEFUNDUSEXAM @"GetEyeFundusExamByIDNumber"

#endif
