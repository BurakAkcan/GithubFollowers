//
//  AppError.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 21.08.2022.
//

import Foundation

enum AppError:LocalizedError{
    case invalidUserName
    case unAbleToComplete
    case invalidResponse
    case invalidData
    case errorDecoding
    
    var errorDescription: String?{
        switch self {
        case .invalidUserName:
            return "This username created an invalid request"
        case .unAbleToComplete:
            return "Unable to complete your request."
        case .invalidResponse:
            return "Invalid response from server"
        case .invalidData :
            return "The data received from server was invalid"
        case .errorDecoding:
            return "The data could not decode"
        }
    }
    
  
}

enum UserError:LocalizedError{
    case urlError
    case invalidUserResponse
    case invaliUserData
    case errorDecodingUser
    
    var errorDescription: String?{
        switch self {
        case .urlError:
            return "Url Error "
        case .invalidUserResponse:
            return "Invalid user response from server "
        case .invaliUserData:
            return "The user data received from server was invalid"
        case .errorDecodingUser:
            return "The user data could not decode"
        }
    }
    
}


//Note: Enum Associated Value
//
// enum Barcode{
//    case upc(Int,Int)
//    case qrcode(String)
// }
//
// var productcode = Barcode.upc(8, 12  )
// var productQr = Barcode.qrcode("Test")
//
//
// switch productcode {
// case .upc(let numberOfsystem, let manufecter):
//    print("UPC \(numberOfsystem) \(manufecter)")
// case .qrcode(let qrCode):
//    print("QR \(qrCode)")
// }

//Note: Enum RawValues
// enum ASCIIControl:String{
//    case tab = "test"
//    case lineFedd = "deneme"
// }
