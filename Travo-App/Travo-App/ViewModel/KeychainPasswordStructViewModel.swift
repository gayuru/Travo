//
//  KeychainPasswordStructViewModel.swift
//  Travo-App
//
//  Created by Jun Cheong on 27/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

struct KeychainPasswordStructViewModel {
    enum KeychainError: Error {
        case noPasswordFound
        case invalidPassword
        case notAPassword
        case unknownError
        case keychainQueryStatusError
    }
    
    let service:String
    private var account:String
    let accessGroup:String?
    
    init(service:String, account:String, accessGroup:String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // Validates the Password against Keychain
    func getPassword() throws -> String {
        var keychainQuery = KeychainPasswordStructViewModel.queryKeychain(withService: self.service, account: self.account, accessGroup: self.accessGroup)
        keychainQuery[kSecMatchLimit as String] = kSecMatchLimitOne
        keychainQuery[kSecReturnAttributes as String] = kCFBooleanTrue
        keychainQuery[kSecReturnData as String] = kCFBooleanTrue
        
        // If Found then Handle Possible UnsafeMutablePointer Exception/Error
        var foundPassword: AnyObject?
        let queryStatus = withUnsafeMutablePointer(to: &foundPassword) {
            SecItemCopyMatching(keychainQuery as CFDictionary, UnsafeMutablePointer($0))
        }
        
        guard queryStatus != errSecItemNotFound else { throw KeychainError.noPasswordFound }
        guard queryStatus == noErr else {throw KeychainError.keychainQueryStatusError }
        
        // Extract Password to String
        guard let existingPassword = foundPassword as? [String:AnyObject],
            let rawPasswordData = existingPassword[kSecValueData as String] as? Data,
            let passwordString = String(data: rawPasswordData, encoding: String.Encoding.utf8)
        else {
            throw KeychainError.notAPassword
        }
        return passwordString
    }
    
    // Insert Password into Keychain
    func savePassword(password:String) throws {
        // Encodes into utf8 hash
        let hashedPassword = password.data(using: String.Encoding.utf8)!
        
        do {
            // Update if existing password found
            try _ = getPassword()
            
            // Update existing password
            var updateAttributes = [String:AnyObject]()
            
            updateAttributes[kSecValueData as String] = hashedPassword as AnyObject?
            
            let keyChainQuery = KeychainPasswordStructViewModel.queryKeychain(withService: self.service, account: self.account, accessGroup: self.accessGroup)
            
            let keychainQueryStatus = SecItemUpdate(keyChainQuery as CFDictionary, updateAttributes as CFDictionary)
            
            // Bad status exception
            guard keychainQueryStatus == noErr else { throw KeychainError.keychainQueryStatusError}
        } catch KeychainError.noPasswordFound {
            // Create new password for new user
            let newPassword = KeychainPasswordStructViewModel.queryKeychain(withService: self.service, account: self.account, accessGroup: self.accessGroup)
            
            // Insert into keychain
            let keychainQueryStatus = SecItemAdd(newPassword as CFDictionary, nil)
            
            guard keychainQueryStatus == noErr else { throw KeychainError.keychainQueryStatusError }
        }
    }
    
    mutating func renameKeychainAccount(accountName:String) throws {
        var updateAttributes = [String:AnyObject]()
        updateAttributes[kSecAttrAccount as String] = accountName as AnyObject?
        
        let keychainQuery = KeychainPasswordStructViewModel.queryKeychain(withService: self.service, account: self.account, accessGroup: self.accessGroup)
        let keychainQueryStatus = SecItemUpdate(keychainQuery as CFDictionary, updateAttributes as CFDictionary)
        
        // Bad Query Status throw Exception
        guard keychainQueryStatus == noErr || keychainQueryStatus == errSecItemNotFound else { throw KeychainError.keychainQueryStatusError }
    }
    
    func deleteSelfFromKeychain() throws {
        let keychainQuery = KeychainPasswordStructViewModel.queryKeychain(withService: self.service, account: self.account, accessGroup: self.accessGroup)
        let keychainQueryStatus = SecItemDelete(keychainQuery as CFDictionary)
        
        guard keychainQueryStatus == noErr || keychainQueryStatus == errSecItemNotFound else { throw KeychainError.keychainQueryStatusError}
    }
    
    static func passwordItemsMatchingAccountAndAccessGroup(forService service: String, accessGroup:String? = nil) throws -> [KeychainPasswordStructViewModel] {
        var keychainQuery = self.queryKeychain(withService: service, accessGroup: accessGroup)
        keychainQuery[kSecMatchLimit as String] = kSecMatchLimitAll
        keychainQuery[kSecReturnAttributes as String] = kCFBooleanTrue
        keychainQuery[kSecReturnData as String] = kCFBooleanFalse

        // Find Matching objects from Keychain
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(keychainQuery as CFDictionary, UnsafeMutablePointer($0))
        }

        // If no items were found, return an empty array.
        guard status != errSecItemNotFound else { return [] }

        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.keychainQueryStatusError }

        // Cast the query result to an array of dictionaries.
        guard let resultData = queryResult as? [[String : AnyObject]] else { throw KeychainError.notAPassword }

        // Create KeychainPasswordStructViewModel instances in search result
        var passwordItems = [KeychainPasswordStructViewModel]()
        for result in resultData {
            guard let account  = result[kSecAttrAccount as String] as? String else { throw KeychainError.notAPassword }

            let passwordItem = KeychainPasswordStructViewModel(service: service, account: account, accessGroup: accessGroup)
            passwordItems.append(passwordItem)
        }

        return passwordItems
    }
    
    // Make Queries to the Keychain
    private static func queryKeychain(withService service:String, account: String? = nil, accessGroup:String? = nil) -> [String:AnyObject] {
        var keychainQuery = [String:AnyObject]()
        
        keychainQuery[kSecClass as String] = kSecClassGenericPassword
        keychainQuery[kSecAttrService as String] = service as AnyObject?
        
        if account != nil {
            keychainQuery[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if accessGroup != nil {
            keychainQuery[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        return keychainQuery
    }
}
