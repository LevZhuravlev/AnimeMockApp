//
//  ReportService.swift
//  AnimeMockApp
//
//  Created by Журавлев Лев on 01.12.2023.
//

import Foundation

class ReportService {
    
    private let parserDelegate = ReportXMLParserDelegate()
        
    func fetchReport(for animeType: TypesOfAnimeContent, completion: ((Report?, Error?) -> Void)? = nil) {
        let urlString = "https://cdn.animenewsnetwork.com/encyclopedia/reports.xml?id=155&type=\(animeType)&nlist=50"
        
        guard let url = URL(string: urlString) else {
            completion?(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion?(nil, error)
                return
            }

            guard let data = data else {
                completion?(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }

            let parsedReport = self?.parserDelegate.parse(data: data)
                                    
            completion?(parsedReport, nil)
        }

        task.resume()
    }
}
