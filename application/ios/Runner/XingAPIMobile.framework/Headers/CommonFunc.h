//
//  CommonFunc.h
//  XingAPIMobile
//
//  Created by Gwanho Jeong on 2020/02/06.
//  Copyright © 2020 Gwanho Jeong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonFunc : NSObject
{
    
}

+(NSString*)GetIPAddress:(BOOL)dot;
+(BOOL)Check_WiFi;
+(NSString*)GetTrim:(NSString*)str;
+(NSMutableData*)GetSpace:(NSInteger)count;
+(NSMutableData*)GetZeroSpace:(NSInteger)count;

+(void)AppendDataWithAttr:(NSMutableData*)buffer data:(NSMutableData*)data;
+(void)WriteData:(NSMutableData*)buffer str:(NSString*)str;
+(NSString*)ReadDataString:(NSData*)data start:(NSInteger)start count:(NSInteger)count;
+(NSInteger)ReadDataInt:(NSData*)data start:(NSInteger)start count:(NSInteger)count;
+(double)ReadDataDouble:(NSData*)data start:(NSInteger)start count:(NSInteger)count;
+(void)StringToData:(NSString*)inputStr buffer:(NSMutableData*)data size:(NSInteger)size;

@end

NS_ASSUME_NONNULL_END
