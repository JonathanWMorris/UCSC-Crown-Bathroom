//
//  SignInView.swift
//  UCSC Crown Bathroom
//
//  Created by Jonathan Morris on 9/7/21.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import RealmSwift

struct SignInView: View {
    
    @State var currentNonce:String?
    @StateObject var signInViewModel: SignInViewModel
    
    let realm = try! Realm()
    
    var body: some View {
        SignInWithAppleButton(
            
            //Request
            onRequest: { request in
                let nonce = signInViewModel.randomNonceString()
                currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = signInViewModel.sha256(nonce)
            },
            
            //Completion
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    switch authResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        
                        guard let nonce = currentNonce else {
                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                        }
                        guard let appleIDToken = appleIDCredential.identityToken else {
                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                        }
                        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                            return
                        }
                        
                        let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                        Auth.auth().signIn(with: credential) { (authResult, error) in
                            guard error == nil else { fatalError() }
                            guard let result = authResult else { fatalError() }
                            
                            let user = User()
                            user.name = result.user.displayName ?? ""
                            user.email = result.user.email ?? ""
                            user.id = result.user.uid
                            
                            try! realm.write {
                                self.realm.add(user)
                            }
                            
                            signInViewModel.isUserAuthenticated()
                            
                        }
                        
                        print("\(String(describing: Auth.auth().currentUser?.uid))")
                    default:
                        break
                        
                    }
                default:
                    break
                }
                
            }
        ).frame(width: 280, height: 45, alignment: .center)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(signInViewModel: SignInViewModel())
    }
}
