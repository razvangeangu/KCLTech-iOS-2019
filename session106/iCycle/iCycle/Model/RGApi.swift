//
//  RGApi.swift
//  iCycle
//
//  Created by Răzvan-Gabriel Geangu on 26/11/2018.
//  Copyright © 2018 Răzvan-Gabriel Geangu. All rights reserved.
//

import Foundation

class RGApi: NSObject {
    
    private var stations: [Station] = [Station]()
    private var lastUpdate: Date?
    private var foundCharacters: NSString = ""
    
    static let shared = {
        return RGApi()
    }()
    
    func getStationsFeed(onSuccess: @escaping (_ stations: [Station]?, _ lastUpdate: Date?) -> Void) {
        stations.removeAll()

        if let urlString = URL(string: RGUtil.urlPath) {
            if let xmlParser = XMLParser(contentsOf: urlString) {
                xmlParser.delegate = self
                
                if xmlParser.parse() {
                    onSuccess(stations, lastUpdate)
                }
            }
        }
    }
}

extension RGApi: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "stations":
            for attribute in attributeDict {
                if attribute.key == "lastUpdate" {
                    self.lastUpdate = Date(timeIntervalSince1970: (Double(attribute.value) ?? 0) * 0.001)
                }
            }
            break
        case "station":
            let station = Station()
            stations.append(station)
            break
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case StationAttributes.name.rawValue:
            stations.last!.name = self.foundCharacters as String
            break
        case StationAttributes.lat.rawValue:
            stations.last!.lat = self.foundCharacters.doubleValue
            break
        case StationAttributes.long.rawValue:
            stations.last!.long = self.foundCharacters.doubleValue
            break
        default:
            break
        }
        
        self.foundCharacters = "" as NSString
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.foundCharacters = self.foundCharacters.appending(string) as NSString
    }
}
