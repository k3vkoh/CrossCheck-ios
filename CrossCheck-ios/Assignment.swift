//
//  Assignment.swift
//  CrossCheck-ios
//
//  Created by Chino on 4/29/22.
//

import Foundation

struct Assignment: Codable {
    var email: String
    var course_num: String
    var course_name: String
    var assignment_name: String
    var due_date: String
    var due_time: String
    var day_name: String
    var method: String
    var submission_status: String
}
