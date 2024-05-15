//
//  Authenticator.swift
//  BucketList
//
//  Created by kodirbek on 5/15/24.
//

import SwiftUI
import LocalAuthentication

class Authenticator {
    
    static func authenticate(completionHandler: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    completionHandler(true)
                } else {
                    print("Authentication failed, error: \(authenticationError?.localizedDescription ?? "")")
                    completionHandler(false)
                }
            }
        } else {
            // handle biometric auth fail case (e.g. password)
        }
    }
}
