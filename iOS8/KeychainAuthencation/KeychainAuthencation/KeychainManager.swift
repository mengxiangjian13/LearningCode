//
//  KeychainManager.swift
//  KeychainAuthencation
//
//  Created by Xiangjian Meng on 14-10-8.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class KeychainManager: NSObject {
    
    var serviceIdentifier = "TouchyFeelySecureStore";
    var accountName = "TouchyFeelyAccount";
    
    var savedSecret : String? {
        
        set {
            
            if let ff = newValue
            {
                save(ff);
            }
            else
            {
                delete();
            }
            
        }
        
        get {
            
            return password();
        }
    }
    
    private func save(password : String)
    {
        if let data = password.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        {
            delete();
            
            let accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .UserPresence, nil);
            
            let keyChainQuery = [
                kSecClass : kSecClassGenericPassword,
                kSecAttrService : serviceIdentifier,
                kSecAttrAccount : accountName,
                kSecValueData : data,
                kSecAttrAccessControl : accessControl.takeRetainedValue()
            ];
            
            SecItemAdd(keyChainQuery, nil);
        }
    }
    
    private func password() -> String?
    {
        let keyChainQuery = [
            kSecClass              : kSecClassGenericPassword,
            kSecAttrService        : serviceIdentifier,
            kSecAttrAccount        : accountName,
            kSecReturnData         : true,
            kSecMatchLimit         : kSecMatchLimitOne,
            kSecUseOperationPrompt : "Authenticate to retrieve your secret!"
        ];
        
        var extractedData: Unmanaged<AnyObject>? = nil
        
        let status = SecItemCopyMatching(keyChainQuery, &extractedData)
        
        let opaque = extractedData?.toOpaque()
        var contentsOfKeychain: String?
        
        if let opaque = opaque {
            let retrievedData = Unmanaged<NSData>.fromOpaque(opaque).takeUnretainedValue()
            // Convert the data retrieved from the keychain into a string
            contentsOfKeychain = NSString(data: retrievedData, encoding: NSUTF8StringEncoding)
        } else {
            println("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
    
    private func delete()
    {
        let keychainQuery = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : serviceIdentifier,
            kSecAttrAccount : accountName
        ];
        
        SecItemDelete(keychainQuery);
    }
   
}
