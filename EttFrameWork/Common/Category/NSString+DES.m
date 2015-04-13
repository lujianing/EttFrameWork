//
//  NSString+DES.m
//  DeveloperLxDemo
//
//  Created by Jin on 15-4-1.
//  Copyright (c) 2015年 DeveloperLx. All rights reserved.
//

#import "NSString+DES.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (DES)

- (NSString *)desEncryptWithKey:(NSString *)key
{
    NSData * plaintextData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = plaintextData.length + kCCBlockSizeAES128;
    void * buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeDES,
                                          NULL,
                                          plaintextData.bytes,
                                          plaintextData.length,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData * encryptedData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [encryptedData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    free(buffer);
    return nil;
}

- (NSString *)desDecryptWithKey:(NSString *)key
{
    NSData * ciphertextBase64Data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData * ciphertextData = [[NSData alloc]initWithBase64EncodedData:ciphertextBase64Data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = ciphertextData.length + kCCBlockSizeAES128;
    void * buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeDES,
                                          NULL,
                                          ciphertextData.bytes,
                                          ciphertextData.length,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData * decryptedData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        return [[NSString alloc]initWithData:decryptedData encoding:NSUTF8StringEncoding];//[NSString stringWithUTF8String:decryptedData.bytes];
    }
    
    free(buffer);
    return nil;
}

@end
