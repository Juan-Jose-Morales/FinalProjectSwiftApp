//
//  AlamofireNetworkClient.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import Alamofire

class AlamofireNetworkClient: NetworkClientProtocol {
    let afSession: Alamofire.Session
    
    class WildClardServerTrustPolicyManager: ServerTrustManager {
        override func serverTrustEvaluator(forHost host: String) throws -> (any ServerTrustEvaluating)? {
            if let policy = evaluators[host] {
                return policy
            }
            var domainComponents = host.split(separator: ".")
            if domainComponents.count > 2 {
                domainComponents[0] = "*"
                let wildCardHost = domainComponents.joined(separator: ".")
                return evaluators[wildCardHost]
            }
            return nil
        }
    }
    
    init() {
        let serverTrustPolicies: [String: ServerTrustEvaluating] = [
            "*.vass.es": PinnedCertificatesTrustEvaluator()
        ]
        
        let wildCard = WildClardServerTrustPolicyManager(evaluators: serverTrustPolicies)
        self.afSession = Session(configuration: URLSessionConfiguration.default, serverTrustManager: wildCard)
    }
    
    func request<T: Decodable>(_ url: String, method: HTTPMethod, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        afSession.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
}


