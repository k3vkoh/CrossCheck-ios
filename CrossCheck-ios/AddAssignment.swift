//
//  AddAssignment.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/2/22.
//

import Foundation

class AddAssignment {
    private struct Returned: Codable {
        var data: [Success]
    }

    var urlString: String
    var valid = ""
    
    init(inputUsername: String, course_name: String, course_num: String, assignmentName: String, dueDate: String, dueTime: String, dayName: String) {
        urlString = "http://127.0.0.1:5000//add_assignment_db/\(inputUsername)/\(course_name)/\(course_num)/\(assignmentName)/\(dueDate)/\(dueTime)/\(dayName)"
        urlString = urlString.replacingOccurrences(of: " ", with: "_")
    }

    func getData(completed: @escaping() -> ()) {

        print("accessing the url \(urlString)")

        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create URL from \(urlString)")
            completed()
            return
        }

        let session = URLSession.shared

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }

            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.valid = returned.data[0].success
            } catch {
                print("JSON ERROR \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}

