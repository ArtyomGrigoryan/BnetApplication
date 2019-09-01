//
//  NetworkDataFetcher.swift
//  BnetApplication
//
//  Created by Артем Григорян on 12/08/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getSession(response: @escaping (ServerResponse?, Error?) -> Void)
    func getRecords(session: String, response: @escaping (ServerResponse2?, Error?) -> Void)
    func createNewRecord(session: String, userText: String, response: @escaping (ServerResponse?, Error?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getSession(response: @escaping (ServerResponse?, Error?) -> Void) {
        let parameters = ["a": API.newSession]
       
        networking.request(params: parameters) { (data, error) in
            guard let data = data else {
                return response(nil, error)
            }
            let decoded = self.decodeJSON(type: ServerResponse.self, from: data)
            response(decoded, nil)
        }
    }
    
    func createNewRecord(session: String, userText: String, response: @escaping (ServerResponse?, Error?) -> Void) {
        let parameters = ["session": session,
                          "body"   : userText,
                          "a"      : API.addEntry]
        
        networking.request(params: parameters) { (data, error) in
            guard let data = data else {
                return response(nil, error)
            }
            let decoded = self.decodeJSON(type: ServerResponse.self, from: data)
            response(decoded, nil)
        }
    }
    
    func getRecords(session: String, response: @escaping (ServerResponse2?, Error?) -> Void) {
        let parameters = ["session": session,
                          "a"      : API.getEntries]
        
        networking.request(params: parameters) { (data, error) in
            guard let data = data else {
                return response(nil, error)
            }
            let decoded = self.decodeJSON(type: ServerResponse2.self, from: data)
            response(decoded, nil)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()

        do {
            return try decoder.decode(type.self, from: data)
        } catch let error {
            print("Error is: ", error)
            return nil
        }
    }
}
