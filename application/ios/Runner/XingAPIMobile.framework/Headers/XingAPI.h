//
//  XingAPI.h
//  XingAPIMobile
//
//  Created by Gwanho Jeong on 2020/02/05.
//  Copyright © 2020 Gwanho Jeong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InoutDefine.h"
#import "XingAPIDelegate.h"
#import "InoutData.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XingAPI : NSObject
{
    
}

+ (XingAPI*) getInstance;


//외부 인터페이스 시작
-(void)InitAPI;

//API를 종료한다.
-(void)CloseAPI;

//개발 view에서 호출한다.
//view 객체를 받고 핸들값을 생성해 넘겨준다.
//view가 생성하는 시점에 호출한다.
-(NSInteger)InitView:(id<XingAPIDelegate>)apiDelegate name:(NSString*)name;

//네트워크 종료/재접속 정보를 받을 delegate 설정
-(void)SetNetworkDelegate:(id<XingAPIDelegate>)apiDelegate;

//handle에 해당하는 view 객체를 삭제한다.
//view가 종료될 때 호출한다.
-(void)DeinitView:(NSInteger)handle;

//연결을 해지 한다.
-(void)Disconnect;

//연결이 되어 있는지 확인
-(BOOL)IsConnected;

//로그인
-(void)Login:(UIViewController*)view loginData:(LOGIN_DATA*)loginData;

//로그인 상태
-(BOOL)IsLogin;

//로그아웃
-(void) Logout;

//공인인증 정보
-(NSArray<SIGN_INFO *>*) GetSignList;

//해더정보 설정
-(void) SetHeaderInfo:(NSInteger)type value:(NSString*)value;

//데이터 요청, byte배열형 데이터
- (RQ_RESULT*) RequestData:(NSInteger)handle code:(NSString*)code data:(NSData*)data  next:(BOOL)next continueKey:(NSString*)continueKey compress:(BOOL)compress timeOut:(NSInteger)timeOut;

//실시간 데이티 요청
- (BOOL) AdviseRealData:(NSInteger)handle code:(NSString*)code key:(NSString*)key;

//실시간 중지
- (BOOL) UnAdviseRealData:(NSInteger)handle code:(NSString*)code key:(NSString*)key;

//핸들에 해당하는 실시간 전체 중지
- (BOOL) UnAdviseRealDataAll:(NSInteger)handle;

//시간당 전송 횟수
- (NSInteger) GetRequestCount:(NSString*)code;

//계좌관련
//보유계좌 갯수
- (NSInteger) GetAccountCount;

//계좌, 계좌명 배열
- (NSArray<ACNT_INFO*>*) GetAccountList;

//계좌명
- (NSString*) GetAccountName:(NSString*)acnt;

//계좌 세부이름
- (NSString*) GetAccountDetailName:(NSString*)acnt;

//계좌 별칭
- (NSString*) GetAccountNickName:(NSString*)acnt;
//계좌관련

//자동 재연결
- (BOOL) GetAutoConnect;

//자동 재연결 설정
- (void) SetAutoConnect:(BOOL)bAuto;

//통신 매체
- (NSString*) GetCommMedia;

//당사 매체
- (NSString*) GetETKMedia;

//연결 서버 타입
- (enum SERVER_TYPE) GetConnectServerType;

//로그 pc에 접속하기 위해 IP와 Port를 설정하는 view
- (void) LogTracePC_ShowSetupView:(UIViewController*)view;

//로그 pc에 접속한다.
- (NSString*) LogTracePC_Connect;

//로그 pc 접속을 끊는다.
- (void) LogTracePC_Disconnect;

//로그 pc에 접속 유무
- (BOOL) LogTracePC_IsConnected;

//서비스 데이터 요청
-(RQ_RESULT*) RequestServiceData:(NSInteger)handle code:(NSString*)code data:(NSData*)data;

//서비스 실시간 중지
-(RQ_RESULT*) RemoveService:(NSInteger)handle realKey:(NSString*)realKey;

//인증서 가져오기
-(void)CopyPubCert:(UIViewController*)view handle:(NSInteger)handle;

//외부 인터페이스 끝

@end

NS_ASSUME_NONNULL_END
