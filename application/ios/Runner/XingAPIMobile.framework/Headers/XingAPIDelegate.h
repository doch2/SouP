//
//  XingAPIDelegate.h
//  XingAPIMobile
//
//  Created by Gwanho Jeong on 2020/02/10.
//  Copyright © 2020 Gwanho Jeong. All rights reserved.
//

#ifndef XingAPIDelegate_h
#define XingAPIDelegate_h

#import "InoutData.h"

@protocol XingAPIDelegate <NSObject>

@required
//서비스 요청 응답
-(void) OnReceiveData:(ReceiveData*)data;

//서비스 메시지
-(void) OnReceiveMessage:(ReceiveMessage*)msg;

//Error 메시지
-(void) OnReceiveError:(ReceiveMessage*)msg;

//Release Data
-(void) OnReleaseData:(NSInteger)rqID code:(NSString*)code;

//time out
-(void) OnTimeOut:(NSInteger)rqID code:(NSString*)code;

//실시간 데이터
-(void) OnReceiveRealData:(NSString*)bcCode key:(NSString*)key data:(NSData*)data;

@optional
//로그인 처리 메시지
-(void) OnLoginResult:(LOGIN_MSG*)result;

//연결종료
-(void) OnDisconnect;

//연결시도
-(void) OnRetryConnnect:(NSInteger)count;

//RequestService에 대응하는 실시간 응답
-(void) OnReceiveServiceRealData:(NSInteger)handle key:(NSString*)key data:(NSData*)data;
@end


#endif /* XingAPIDelegate_h */
