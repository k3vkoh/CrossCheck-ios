//
//  Assignments.swift
//  CrossCheck-ios
//
//  Created by Chino on 4/29/22.
//

import Foundation

private let inputDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "y-MM-dd"
    return dateFormatter
} ()

private let outputDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/y"
    return dateFormatter
} ()

class Assignments {
    private struct Returned: Codable {
        var data: [Assignment]
    }
    
    var urlString = "http://127.0.0.1:5000/get_schedule/kohke@bc.edu/abc"
    var assignmentArray: [Assignment] = []
    var uniqueDateString: [String] = []
    var uniqueDate: [Date] = []
    var uniqueClass: [String] = []
    
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
//                print(returned.data)
                self.assignmentArray = returned.data
                for line in self.assignmentArray {
                    if !(self.uniqueDateString.contains(line.due_date)) {
                        self.uniqueDateString.append(line.due_date)
                    }
                    if !(self.uniqueClass.contains(line.course_name)) {
                        self.uniqueClass.append(line.course_name)
                    }
                }
                
                let filteredDates = self.uniqueDateString.filter({ $0 != "" })
                for dateString in filteredDates {
                    let date = inputDateFormatter.date(from: dateString)
                    let resultString = outputDateFormatter.string(from: date!)
                    let resultDate = outputDateFormatter.date(from: resultString)!
                    self.uniqueDate += [resultDate]
                }
                let ready = self.uniqueDate.sorted(by: { $0.compare($1) == .orderedAscending })
                self.uniqueDateString = ["No Due Date"]

                for dateUnconverted in ready {
                    let resultString = outputDateFormatter.string(from: dateUnconverted)
                    self.uniqueDateString += [resultString]
                }

                print("\(self.uniqueDateString)")
                print("\(self.uniqueClass)")
                print("\(self.assignmentArray.filter({$0.due_date == "2022-01-29" && $0.course_name == "GLOB 2"}))")
                
            } catch {
                print("JSON ERROR \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}
