//
//  XMLParser.swift
//  HomeworkAnimeAPI
//
//  Created by Журавлев Лев on 26.11.2023.
//

import Foundation

class ReportXMLParserDelegate: NSObject, XMLParserDelegate {
    var report: Report?
    var currentItem: ReportItem?
    var currentElement: String?

    func parse(data: Data) -> Report? {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return report
    }

    // MARK: - ReportXMLParserDelegate methods

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        currentElement = elementName

        if elementName == "report" {
            report = Report(
                skipped: attributeDict["skipped"] ?? "",
                listed: attributeDict["listed"] ?? "", 
                args: ReportArgs(type: "", name: "", search: ""),
                items: []
            )
        } else if elementName == "item" {
            currentItem = ReportItem(id: "", gid: "", type: "", name: "", precision: "", vintage: nil)
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "type":
            currentItem?.type += string
        case "name":
            currentItem?.name += string
        case "id":
            currentItem?.id += string
        case "gid":
            currentItem?.gid += string
        case "precision":
            currentItem?.precision += string
        case "vintage":
            currentItem?.vintage = string
        case "args":
            // Handle args element
            break
        default:
            break
        }
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        if elementName == "item" {
            if let currentItem = currentItem {
                report?.items.append(currentItem)
            }
            currentItem = nil
        }
        currentElement = nil
    }
}



