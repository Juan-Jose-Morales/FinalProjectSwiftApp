//
//  NetworkClientProtocol.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import Alamofire

protocol NetworkClientProtocol {
    func request<T: Decodable>(_ url: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders?, completion: @escaping (Result<T, AFError>) -> Void)
}


