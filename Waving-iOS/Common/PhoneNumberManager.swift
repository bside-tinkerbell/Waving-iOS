//
//  PhoneNumberManager.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/12/09.
//

import Foundation
import PhoneNumberKit

final class PhoneNumberManager {
    static func format(_ phoneNumber: String) -> String? {
        // Assuming phoneNumber is the raw phone number string you want to format
        let phoneNumberKit = PhoneNumberKit()
        do {
            let parsedPhoneNumber: PhoneNumber = try phoneNumberKit.parse(phoneNumber)
            
            // Format the phone number as 000-0000-0000
            let formattedPhoneNumber = phoneNumberKit.format(parsedPhoneNumber, toType: .e164)
            
            // Extract national code
            let nationalCode = parsedPhoneNumber.nationalNumber
            
            // Now, you can use formattedPhoneNumber and nationalCode as needed
            print("Formatted Number: \(formattedPhoneNumber)")
            print("National Code: \(nationalCode)")
            
            return formattedPhoneNumber
        } catch {
            print("Error parsing phone number: \(error)")
            return nil
        }
    }
}
