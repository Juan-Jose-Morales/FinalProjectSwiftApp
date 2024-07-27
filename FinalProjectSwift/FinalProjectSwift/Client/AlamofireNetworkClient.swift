//
//  AlamofireNetworkClient.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import Alamofire

class AlamofireNetworkClient: NetworkClientProtocol {
    func request<T: Decodable>(_ url: String, method: HTTPMethod, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
}


