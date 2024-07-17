//
//  AuthInterceptor.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 17/7/24.
//

import Foundation
import Alamofire
import LocalAuthentication

struct AuthInterceptor: RequestInterceptor {
    
    let authToken = UserDefaults.standard.string(forKey: "AuthToken")
    
    func intercept(request: URLRequest, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = request
        request.headers.add(name: "Authorization", value: String("\(authToken)"))
        completion(.success(request))
    }
}
