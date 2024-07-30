//
//  UserServiceProtocol.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import Alamofire

protocol UserServiceProtocol {
    func register(user: User, completion: @escaping (Result<User, Error>) -> Void)
    func updateOnlineStatus(isOnline: Bool, completion: @escaping (Result<Void, AFError>) -> Void)
}
