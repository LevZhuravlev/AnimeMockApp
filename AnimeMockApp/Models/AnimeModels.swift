//
//  AnimeModels.swift
//  HomeworkAnimeAPI
//
//  Created by Журавлев Лев on 01.12.2023.
//

import Foundation

struct AnimeDetails {
    var id: String
    var gid: String
    var type: String
    var name: String
    var currentImageURL: String?
    var precision: String
    var generatedOn: String
    var relatedPrev: Related?
    var infoList: [Info]
    var ratings: Ratings?
    var episodes: [Episode]
    var reviews: [Review]
    var releases: [Release]
    var newsList: [News]
    var staffList: [Staff]
    var castList: [Cast]
    var creditList: [Credit]
}

struct Related {
    let rel: String
    let id: String
}

struct Info {
    let gid: String
    let type: String
    let lang: String?
    let value: String
}

struct Ratings {
    let nbVotes: Int
    let weightedScore: Double
    let bayesianScore: Double
}

struct Episode {
    let num: Int
    let title: Title
}

struct Title {
    let gid: String
    let lang: String
    let value: String
}

struct Review {
    let href: String
    let value: String
}

struct Release {
    let date: String
    let href: String
}

struct News {
    let datetime: String
    let href: String
    let value: String
}

struct Staff {
    let task: String
    let person: Person
}

struct Person {
    let id: String
    let value: String
}

struct Cast {
    let gid: String
    let lang: String
    let role: String
    let person: Person
}

struct Credit {
    let task: String
    let company: Company
}

struct Company {
    let id: String
    let value: String
}

enum TypesOfAnimeContent: String {
    case anime
    case manga
    case TV
    case ONA
}
