//
//  Team.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/28/26.
//

import Foundation
import SwiftData

enum ViolationType : Codable {
    case FirstVerbalWarning
    case RepeatedVerbalWarning
    case YellowCard
    case RedCard
    case OtherSevere
    case OtherNote
}

struct Rule : Codable {
    var id: String
    var friendlyName: String
    var longDesc: String
}

struct Violation : Codable {
    var id: UUID
    var rule: Rule
    var type: ViolationType
}

@Model
class Team {
    var teamNumber: Int
    var teamShortName: String
    var violations: [Violation]

    init(teamNumber: Int, teamShortName: String, violations: [Violation] = []) {
        self.teamNumber = teamNumber
        self.teamShortName = teamShortName
        self.violations = violations
    }
}

extension Team {
    static var sampleData: [Team] {
        [
            Team(teamNumber: 111, teamShortName: "WildStang"),
            Team(teamNumber: 254, teamShortName: "The Cheesy Poofs"),
            Team(teamNumber: 2056, teamShortName: "OP Robotics")
        ]
    }
}
