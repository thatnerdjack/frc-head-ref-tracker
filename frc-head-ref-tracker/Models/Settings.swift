//
//  Settings.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/28/26.
//


import SwiftData

@Model
final class Settings {
    var apiKey: String
    var eventCode: String

    init(apiKey: String = "", eventCode: String = "") {
        self.apiKey = apiKey
        self.eventCode = eventCode
    }
}
