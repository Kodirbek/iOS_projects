//
//  Authenticator.swift
//  BucketList
//
//  Created by kodirbek on 5/15/24.
//

import SwiftUI
import LocalAuthentication

class Authenticator {
    
    static func authenticate() async -> Bool {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            do {
                let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                return success
            } catch {
                print("Authentication failed, error: \(error.localizedDescription)")
                return false
            }
        } else {
            // handle biometric auth fail case (e.g. password)
            return false
        }
    }
}
