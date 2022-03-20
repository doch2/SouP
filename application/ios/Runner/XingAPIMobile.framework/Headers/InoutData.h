//
//  InoutData.h
//  XingAPIMobile
//
//  Created by Gwanho Jeong on 2020/02/10.
//  Copyright © 2020 Gwanho Jeong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InoutDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface LOGIN_INFO : NSObject
@property (nonatomic, assign) NSInteger loginType;              //로그인 형태
@property (nonatomic, strong) NSString *userId;                 //사용자 아이디
@property (nonatomic, strong) NSString *userPwd;                //아이디에 해당하는 비밀번호
@property (nonatomic, strong) NSString *certPassword;           //공인인증 비밀번호
@property (nonatomic, assign) NSInteger seletedCertIndex;       //선택된 공인인증 순번

- (id)init:(NSInteger)loginType;
@end

//=================================================================================

@interface LOGIN_DATA : NSObject

@property (nonatomic, assign) enum SERVER_TYPE connect_server;  //접속 서버
@property (nonatomic, assign) NSInteger handle;                 //핸들
@property (nonatomic, assign) BOOL showLoginView;               //로그인 view 보이기 유무
@property (nonatomic, strong) NSString *motuUserId;             //모의투자 사용자 아이디
@property (nonatomic, strong) NSString *motuUserPwd;            //모의투자 사용자 비밀번호
@property (nonatomic, assign) NSInteger pubCertIdx;             //공인인증 Index
@property (nonatomic, strong) NSString *pubCertPwd;             //공인인증

- (id)init:(NSInteger)handle connect_server:(enum SERVER_TYPE)connect_server;

@end

//=================================================================================
@interface CONNECT_RESULT : NSObject
@property (nonatomic, assign) BOOL success;                 // 성공여부
@property (nonatomic, assign) enum CONNECT_ERROR error;     // 에러

- (id)init:(BOOL)success error:(enum CONNECT_ERROR)error;
- (NSString*)GetErrorString;
@end

//=================================================================================
@interface RSLT_MSG : NSObject
@property (nonatomic, assign) NSInteger code;      // code
@property (nonatomic, strong) NSString * msg;       // 메시지

- (id)init:(NSInteger)code msg:(NSString*)msg;

@end


//=================================================================================
@interface LOGIN_MSG : NSObject
@property (nonatomic, assign) BOOL result;              // 결과
@property (nonatomic, strong) RSLT_MSG * rsltMsg;       // 메시지

- (id)init:(BOOL)result msg:(RSLT_MSG*)msg;

@end

//=================================================================================
@interface RQ_RESULT : NSObject
@property (nonatomic, assign) NSInteger rqID;               // rqID
@property (nonatomic, assign) BOOL ok;                      // error 여부
@property (nonatomic, strong) RSLT_MSG * rsltMsg;           // 메시지

- (id)init:(NSInteger)rqID result:(BOOL)result msg:(RSLT_MSG*)msg;

@end

//=================================================================================
@interface ReceiveData : NSObject
@property (nonatomic, assign) NSInteger handle;
@property (nonatomic, assign) NSInteger rqID;
@property (nonatomic, strong) NSString * headerType;
@property (nonatomic, strong) NSString * tr;
@property (nonatomic, strong) NSString * blockName;
@property (nonatomic, strong) NSData* data;
@property (nonatomic, assign) NSInteger dataLen;
@property (nonatomic, assign) NSInteger gubun;
@property (nonatomic, strong) NSString * continueYN;
@property (nonatomic, strong) NSString * continueKey;
@property (nonatomic, strong) NSString * userData;

- (id)init:(NSInteger)handle rqID:(NSInteger)rqID headerType:(NSString*)headerType tr:(NSString*)tr blockName:(NSString*)blockName data:(NSData*)data dataLen:(NSInteger)dataLen  continueYN:(NSString*)continueYN continueKey:(NSString*)continueKey userData:(NSString*)userData gubun:(NSInteger)gubun;

@end


//=================================================================================
@interface ReceiveMessage : NSObject
@property (nonatomic, assign) NSInteger handle;
@property (nonatomic, assign) NSInteger rqID;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * errorCode;
@property (nonatomic, strong) NSString * message;

- (id)init:(NSInteger)handle rqID:(NSInteger)rqID code:(NSString*)code errorCode:(NSString*)errorCode message:(NSString*)message;

@end


//=================================================================================
@interface ReceiveRealData : NSObject
@property (nonatomic, assign) NSInteger handle;
@property (nonatomic, strong) NSString * RDName;
@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) NSData* data;
@property (nonatomic, assign) NSInteger dataLen;

- (id)init:(NSInteger)handle RDName:(NSString*)RDName key:(NSString*)key data:(NSData*)data dataLen:(NSInteger)dataLen;

@end

//=================================================================================
@interface SIGN_INFO : NSObject
@property (nonatomic, strong) NSString * DN;
@property (nonatomic, strong) NSString * serialNum;
@property (nonatomic, strong) NSString * subjectName;
@property (nonatomic, strong) NSString * policy;
@property (nonatomic, strong) NSString * issuerName;
@property (nonatomic, strong) NSString * validTo;


- (id)init:(NSString*)DN serialNum:(NSString*)serialNum subjectName:(NSString*)subjectName policy:(NSString*)policy issuerName:(NSString*)issuerName validTo:(NSString*)validTo;

@end


//=================================================================================
//서버 연결을 위한 서버 정보 설정
@interface SERVER_INFO : NSObject
@property (nonatomic, assign) SERVER_TYPE serverType;
@property (nonatomic, assign) NSInteger port;

- (id)init:(SERVER_TYPE)serverType port:(NSInteger)port;
- (BOOL)IsMotuServer;
@end

//=================================================================================
@interface ACNT_INFO : NSObject
@property (nonatomic, strong) NSString * acntNo;
@property (nonatomic, strong) NSString * acntName;

- (id)init:(NSString*)acntNo acntName:(NSString*)acntName;
@end

NS_ASSUME_NONNULL_END
