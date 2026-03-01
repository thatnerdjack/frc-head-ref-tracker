//
//  Rule.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/28/26.
//


//
//  Rule.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/28/26.
//

import Foundation

struct Rule: Identifiable, Codable, Hashable {
    let id: String
    let friendlyName: String
    let longDesc: String
}