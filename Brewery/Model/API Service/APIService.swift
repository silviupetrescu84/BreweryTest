//
//  APIService.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/11/20.
//

import Foundation


//We should use this to inject but for now we can keep it here
let currentService: PossibleServices = .Alamofire

import Foundation

//Should be in different file
let jsonEncoder: JSONEncoder    = { let enc = JSONEncoder(); enc.dateEncodingStrategy = .iso8601; enc.outputFormatting = [.sortedKeys]; return enc }()
let jsonDecoder: JSONDecoder    = { let dec = JSONDecoder(); dec.dateDecodingStrategy = .iso8601; return dec }()

enum StringDownloadError: Error {
    case definedError(String)
}

class APIService: APIRequests {
    
    static var shared: APIRequests! = {
#if UI_TEST 
        return APIMockService()
#else
        return APIService()
#endif
    }()

    static var service: CloudService! {
        get {
            if currentService == .Alamofire {
                return AlamoService()
            } else if currentService == .NSURLSession {
                return NSURLService()
            } else {
                return nil //If it's not set it will crash
            }
        }
    }
    
    // Gets data from API for directly Codable objects
    private func getAPIData<T>(endpoint: String, parameters: [String: String] = [:], type: T.Type, completion: @escaping (Error?, Any?) -> Void) where T: Decodable {
        guard APIService.service != nil else {
            completion(NSError(domain: Bundle.main.bundleIdentifier!,
                               code: -2,
                               userInfo: [NSLocalizedDescriptionKey: "No service defined to query"]), nil)
            return
        }
        
        APIService.service.get(endpoint: endpoint, parameters: parameters) { error, result in
            if error != nil {
                completion(self.normaliseError(error: error, data: result as? Data), nil)
            } else if let data = result as? Data {
                
                do {                    
                    let object = try jsonDecoder.decode(type, from: data)
                   
                    completion(nil, object)
                } catch {
                    completion(error, nil)
                }
            } else {
                completion(NSError(domain: Bundle.main.bundleIdentifier!,
                                   code: -3,
                                   userInfo: [NSLocalizedDescriptionKey: "Invalid API Response"]), nil)
            }
        }
    }
    
    private func getAPIData(endpoint: String, parameters: [String: String] = [:], completion: @escaping(Error?, Any?) -> Void) {
        guard APIService.service != nil else {
            completion(NSError(domain: Bundle.main.bundleIdentifier!,
                               code: -2,
                               userInfo: [NSLocalizedDescriptionKey: "No service defined to query"]), nil)
            return
        }
        
        APIService.service.get(endpoint: endpoint, parameters: parameters) { error, result in
            if error != nil {
                completion(self.normaliseError(error: error, data: result as? Data), nil)
            } else if let data = result as? Data {
                
                do {
                    let object = String(decoding: data, as: UTF8.self)
                    if object.isEmpty {
                        throw StringDownloadError.definedError("String empty")
                    }
                    completion(nil, object)
                  
                } catch {
                    completion(error, nil)
                }
            } else {
                completion(NSError(domain: Bundle.main.bundleIdentifier!,
                                   code: -3,
                                   userInfo: [NSLocalizedDescriptionKey: "Invalid API Response"]), nil)
            }
        }
    }
    
    func getBeers(for parameters: [String:String]?, completion: @escaping (Error?, Any?) -> Void) {
        getAPIData(endpoint:beersEndPoint , type: [Beer].self, completion: completion)
    }
    
    func getInput(for parameters: [String : String]?, completion: @escaping (Error?, Any?) -> Void) {
        getAPIData(endpoint: inputEndPoint, completion: completion)
    }
    private func normaliseError(error: Error?, data: Data?) -> Error? {
        guard let err = error else { return error }
        
        let nsError = err as NSError
        
        if data != nil,
            let result = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String: Any],
            let message = result["message"] as? String {
            var userInfo    = nsError.userInfo
            
            userInfo[NSLocalizedDescriptionKey]    = message
            
            return NSError(domain: nsError.domain, code: nsError.code, userInfo: userInfo)
        }
        return nsError
    }
}
