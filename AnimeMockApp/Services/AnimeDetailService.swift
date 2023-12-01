//
//  AnimeDetailService.swift
//  AnimeMockApp
//
//  Created by Журавлев Лев on 01.12.2023.
//

import Foundation

class AnimeDetailService {
    
    private let animeParser = AnimeDetailXMLParser()
    
    func fetchAnimeDetails(for animeId: String, completion: @escaping (Result<AnimeDetails, Error>) -> Void) {
        let urlString = "https://cdn.animenewsnetwork.com/encyclopedia/api.xml?anime=\(animeId)"
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                    return
                }

                do {
                    let xmlString = String(data: data, encoding: .utf8)
                    self?.animeParser.parseXML(xmlString: xmlString ?? "")
                    if let animeDetails = self?.animeParser.animeDetails as? [String: String] {
                        let anime = AnimeDetails(
                            id: animeDetails["id"] ?? "",
                            gid: animeDetails["gid"] ?? "",
                            type: animeDetails["type"] ?? "",
                            name: animeDetails["name"] ?? "",
                            precision: animeDetails["precision"] ?? "",
                            generatedOn: animeDetails["generated-on"] ?? "",
                            relatedPrev: nil,  // Parse related-prev details
                            infoList: [],  // Parse info details
                            ratings: Ratings(
                                nbVotes: Int(animeDetails["nb_votes"] ?? "") ?? 0,
                                weightedScore: Double(animeDetails["weighted_score"] ?? "") ?? 0.0,
                                bayesianScore: Double(animeDetails["bayesian_score"] ?? "") ?? 0.0
                            ),
                            episodes: [],  // Parse episode details
                            reviews: [],  // Parse review details
                            releases: [],  // Parse release details
                            newsList: [],  // Parse news details
                            staffList: [],  // Parse staff details
                            castList: [],  // Parse cast details
                            creditList: []  // Parse credit details
                        )

                        completion(.success(anime))
                    } else {
                        completion(.failure(NSError(domain: "ParsingError", code: 0, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
}
