//
//  DataFetcherService.swift
//  BnetApplication
//
//  Created by Артем Григорян on 21/09/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

protocol DataFetcherServiceProtocol {
    func getSession(response: @escaping (ServerResponse?, Error?) -> Void)
    func getRecords(session: String, response: @escaping (ServerResponse2?, Error?) -> Void)
    func createNewRecord(session: String, userText: String, response: @escaping (ServerResponse?, Error?) -> Void)
}

class DataFetcherService: DataFetcherServiceProtocol {
    let dataFetcher: DataFetcher!
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func getSession(response: @escaping (ServerResponse?, Error?) -> Void) {
        let parameters = ["a": API.newSession]
       
        dataFetcher.fetchJSONData(params: parameters, response: response)
    }
    
    func getRecords(session: String, response: @escaping (ServerResponse2?, Error?) -> Void) {
        let parameters = ["session": session,
                          "a"      : API.getEntries]
        
        dataFetcher.fetchJSONData(params: parameters, response: response)
    }
    
    func createNewRecord(session: String, userText: String, response: @escaping (ServerResponse?, Error?) -> Void) {
        let parameters = ["session": session,
                          "body"   : userText,
                          "a"      : API.addEntry]
        
        dataFetcher.fetchJSONData(params: parameters, response: response)
    }
}
