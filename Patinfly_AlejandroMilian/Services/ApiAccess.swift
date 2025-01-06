//
//  ApiAccess.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 5/1/25.
//

import Foundation

struct APIAccess {
    
    static let scheme = "https"
    static let host = "patinfly.com"
    static let token: String = "TxSo9LQvy8Fp4k0ItsBAZ3RUlEdmGenJj5KDcbif2425"
    static let urlServer: String = "https://patinfly.com/"
    static let pathStatus: String = "/endpoints/status/"
    static let pathScooter: String = "/endpoints/scooter"
    static let pathScooterStart: String = "/endpoints/rent/start/ea147af2-d480-11ec-91c7-ecf4bbcc40f8"
    static let pathScooterStop: String = "/endpoints/rent/stop/ea147af2-d480-11ec-91c7-ecf4bbcc40f8"
    
    static func scooters() -> URLComponents{
        var urlServerScooters: URLComponents = APIAccess.baseURL()
        urlServerScooters.path = APIAccess.pathScooter
        return urlServerScooters
    }
    
    static func serverStatus() -> URLComponents{
        var urlServerStatus: URLComponents = APIAccess.baseURL()
        urlServerStatus.path = APIAccess.pathStatus
        return urlServerStatus
    }
    
    static func baseURL() -> URLComponents{
        var baseServerURL: URLComponents = URLComponents()
        baseServerURL.scheme = APIAccess.scheme
        baseServerURL.host = APIAccess.host
        return baseServerURL
    }
    
    static func scootersStartRent() -> URLComponents{
        var urlServerScooters: URLComponents = APIAccess.baseURL()
        urlServerScooters.path = APIAccess.pathScooterStart
        return urlServerScooters
    }
    
    static func scootersStopRent() -> URLComponents{
        var urlServerScooters: URLComponents = APIAccess.baseURL()
        urlServerScooters.path = APIAccess.pathScooterStop
        return urlServerScooters
    }
    
}
