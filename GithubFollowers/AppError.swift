//
//  AppError.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 21.08.2022.
//

import Foundation

enum AppError:LocalizedError{
    case errorDecoding
    case unknowError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String?{
        switch self {
        case .errorDecoding:
            return "Could not decoding"
        case .unknowError:
            return "I have no idea "
        case .invalidUrl:
            return "Could not valid url"
        case .serverError(let error):
            return error
        }
    }
}
