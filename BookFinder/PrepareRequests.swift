//
//  PrepareRequests.swift
//  BookFinder
//
//  Created by Василий Буланов on 11.06.2022.
//

import Foundation

class PrepareRequests {
    private let inputString: String
    
    private var requests = [String]()
    
    init(inputString: String) {
        self.inputString = inputString
        prepareRequests()
    }
    
    private func prepareRequests() {
        requests = inputString.components(separatedBy: "\n")
    }
    
    public func getAllRawRequests() -> [String] {
        return requests
    }
    
    public func getAllPreparedRequests() -> [String] {
        var preapredRequests = [String]()
        let prefix = "https://www.googleapis.com/books/v1/volumes?&tbo=p&tbm=bks&q=%22"
        let suffix = "&key=AIzaSyASWL8mAn0-CDBuSvOnp6fFdvQP0Cmzdgs"
        
        for request in requests {
            var string = ""
            string += prefix
            string += request.replacingOccurrences(of: " ", with: "+")
            string += suffix
            preapredRequests.append(string)
        }
        
        return preapredRequests
    }
}
