//
//  ReportModels.swift
//  HomeworkAnimeAPI
//
//  Created by Журавлев Лев on 01.12.2023.
//

import Foundation

struct ReportItem: Codable, Identifiable {
    var id: String
    var gid: String
    var type: String
    var name: String
    var precision: String
    var vintage: String?
}

struct Report: Codable {
    var skipped: String
    var listed: String
    var args: ReportArgs
    var items: [ReportItem]
}

struct ReportArgs: Codable {
    var type: String
    var name: String
    var search: String
}
