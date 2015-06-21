//
//  SQLHelp.h
//  YRProject
//
//  Created by art_kernel_zyc on 15/1/6.
//  Copyright (c) 2015年 豆豆豆. All rights reserved.
//

#ifndef YRProject_SQLHelp_h
#define YRProject_SQLHelp_h

//笔记表的创建
#define NOTETABLE @"create table if not exists note (rowid INTEGER PRIMARY KEY AUTOINCREMENT,NOTE_ID Varchar(16),PATIENT_ID Varchar(16),VISIT_ID Varchar(2),NOTE_TYPE Varchar(1),NOTE_CONTENT Varchar(100),UPLOAD_FLAG Varchar(1),USER_ID Varchar(16),DOCTOR_NAME Varchar(32),CREATE_TIME Varchar(20),HOSPITAL_NO Varchar(16));"
//笔记插入语句
#define NOTEINSERT @"INSERT INTO note(NOTE_ID,PATIENT_ID,VISIT_ID,NOTE_TYPE,NOTE_CONTENT,UPLOAD_FLAG,USER_ID,DOCTOR_NAME,CREATE_TIME,HOSPITAL_NO) VALUES(?,?,?,?,?,?,?,?,?,?);"
/**
 *  笔记查询语句
 */
#define NOTESELECT @"select * from note  where PATIENT_ID ='"

#endif
