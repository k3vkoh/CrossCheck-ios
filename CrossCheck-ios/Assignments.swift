//
//  Assignments.swift
//  CrossCheck-ios
//
//  Created by Chino on 4/29/22.
//

import Foundation

class Assignments {
    private struct Returned: Codable {
        var data: [Assignment]
    }
    
    var urlString = "http://127.0.0.1:5000/get_schedule/kohke@bc.edu/abc"
    var assignmentArray: [Assignment] = []
    
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
                print(returned.data)
                self.assignmentArray = returned.data
            } catch {
                print("JSON ERROR \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}
