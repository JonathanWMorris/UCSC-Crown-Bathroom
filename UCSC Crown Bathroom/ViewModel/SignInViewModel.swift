//
//  SignInViewModel.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/7/21.
//

import Foundation
import RealmSwift
import CryptoKit

class SignInViewModel: ObservableObject {
    @Published var userExists = false
    @Published var thereIsExistingShower = false
    
    let realm = try! Realm()
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    //Hashing function using CryptoKit
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func isUserAuthenticated() {
        let users = realm.objects(User.self)
        
        if users.count != 0 {
            DispatchQueue.main.async {
                self.userExists = true
            }
        }
    }
    
    func checkForExistingShower() {
        let showers = realm.objects(LocalShower.self)
        
        for shower in showers {
            if shower.durationLeft > 0 {
                thereIsExistingShower = true
            } else {
                try! realm.write {
                    thereIsExistingShower = false
                    realm.delete(shower)
                }
            }
        }
        
        if showers.isEmpty {
            thereIsExistingShower = false
        }
    }
}
