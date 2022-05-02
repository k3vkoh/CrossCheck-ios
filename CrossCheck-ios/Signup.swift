//
//  Signup.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/2/22.
//

import Foundation

class Signup {
    private struct Returned: Codable {
        var data: [Success]
    }

    var urlString: String
    var valid = ""
    
    init(inputUsername: String, inputPassword: String, canvasUsername: String, canvasPassword: String) {
        urlString = "http://127.0.0.1:5000/signup_db/\(inputUsername)/\(inputPassword)/\(canvasUsername)/\(canvasPassword)"
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
