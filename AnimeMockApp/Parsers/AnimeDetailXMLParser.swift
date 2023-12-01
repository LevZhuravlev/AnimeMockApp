//
//  AnimeDetailXMLParser.swift
//  HomeworkAnimeAPI
//
//  Created by Журавлев Лев on 01.12.2023.
//

import Foundation

class AnimeDetailXMLParser: NSObject, XMLParserDelegate {
    var currentElement: String?
    var animeDetails: AnimeDetails?
    var relatedPrev: Related?
    var infoList: [Info] = []
    var ratings: Ratings?
    var episodes: [Episode] = []
    var reviews: [Review] = []
    var releases: [Release] = []
    var newsList: [News] = []
    var staffList: [Staff] = []
    var castList: [Cast] = []
    var creditList: [Credit] = []
    var currentImageURL: String?

    func parseXML(xmlString: String) {
        if let data = xmlString.data(using: .utf8) {
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
    }

    // MARK: - XMLParserDelegate methods

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        currentElement = elementName

        switch elementName {
        case "anime":
            animeDetails = AnimeDetails(
                id: attributeDict["id"] ?? "",
                gid: attributeDict["gid"] ?? "",
                type: attributeDict["type"] ?? "",
                name: attributeDict["name"] ?? "",
                precision: attributeDict["precision"] ?? "",
                generatedOn: attributeDict["generated-on"] ?? "",
                relatedPrev: nil,
                infoList: [],
                ratings: nil,
                episodes: [],
                reviews: [],
                releases: [],
                newsList: [],
                staffList: [],
                castList: [],
                creditList: []
            )
        case "related-prev":
            relatedPrev = Related(rel: attributeDict["rel"] ?? "", id: attributeDict["id"] ?? "")
        case "info":
            infoList.append(Info(gid: attributeDict["gid"] ?? "", type: attributeDict["type"] ?? "", lang: attributeDict["lang"], value: ""))
        case "ratings":
            ratings = Ratings(
                nbVotes: Int(attributeDict["nb_votes"] ?? "") ?? 0,
                weightedScore: Double(attributeDict["weighted_score"] ?? "") ?? 0.0,
                bayesianScore: Double(attributeDict["bayesian_score"] ?? "") ?? 0.0
            )
        case "episode":
            episodes.append(Episode(num: Int(attributeDict["num"] ?? "") ?? 0, title: Title(gid: "", lang: "", value: "")))
        case "review":
            reviews.append(Review(href: attributeDict["href"] ?? "", value: ""))
        case "release":
            releases.append(Release(date: attributeDict["date"] ?? "", href: attributeDict["href"] ?? ""))
        case "news":
            newsList.append(News(datetime: attributeDict["datetime"] ?? "", href: attributeDict["href"] ?? "", value: ""))
        case "staff":
            staffList.append(Staff(task: "", person: Person(id: attributeDict["id"] ?? "", value: "")))
        case "cast":
            castList.append(Cast(gid: attributeDict["gid"] ?? "", lang: attributeDict["lang"] ?? "", role: "", person: Person(id: attributeDict["id"] ?? "", value: "")))
        case "credit":
            creditList.append(Credit(task: "", company: Company(id: attributeDict["id"] ?? "", value: "")))
        case "img":
            currentImageURL = attributeDict["src"]
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let currentElement = currentElement {
            switch currentElement {
            case "info":
                if let currentInfo = infoList.last {
                    infoList[infoList.count - 1] = Info(gid: currentInfo.gid, type: currentInfo.type, lang: currentInfo.lang, value: string)
                }
            case "episode":
                if let currentEpisode = episodes.last {
                    episodes[episodes.count - 1] = Episode(num: currentEpisode.num, title: Title(gid: "", lang: "", value: string))
                }
            case "cast":
                if let currentCast = castList.last {
                    castList[castList.count - 1] = Cast(gid: currentCast.gid, lang: currentCast.lang, role: string, person: currentCast.person)
                }
            case "credit":
                if let currentCredit = creditList.last {
                    creditList[creditList.count - 1] = Credit(task: string, company: currentCredit.company)
                }
            default:
                break
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement = nil
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        animeDetails?.relatedPrev = relatedPrev
        animeDetails?.infoList = infoList
        animeDetails?.ratings = ratings
        animeDetails?.episodes = episodes
        animeDetails?.reviews = reviews
        animeDetails?.releases = releases
        animeDetails?.newsList = newsList
        animeDetails?.staffList = staffList
        animeDetails?.castList = castList
        animeDetails?.creditList = creditList
        animeDetails?.currentImageURL = currentImageURL

        // Use the 'animeDetails' instance as needed
        if let animeDetails = animeDetails {
            print(animeDetails)
        }
    }
}
