//
//  RepresentativeController.swift
//  Representative
//
//  Created by Michael Moore on 8/14/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static let baseURL = URL(string: "https://whoismyrepresentative.com/getall_reps_bystate.php")
    
    static func searchRepresentativeFor(state: String, completion: @escaping ([Representative]) -> Void) {
        
        guard let unwrappedBaseURL = baseURL else { return }
        // creates a dictionary of search parameters, as passed in when calling function
        let urlParameters = ["state" : state,
                             "output" : "json"]
        // returns a single array of of urlParameters of single name-value pairs
        let queryItems = urlParameters.compactMap( { URLQueryItem(name: $0.key, value: $0.value) })
        // adds components to baseURL
        var urlComponents = URLComponents(url: unwrappedBaseURL, resolvingAgainstBaseURL: true)
        // sets those components based on the queryItems
        urlComponents?.queryItems = queryItems
        // builds the final URL
        guard let url = urlComponents?.url else { return }

        print(url.absoluteString)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error with the URLSession. \(error): \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("There was no data")
                completion([])
                return
            }
            
            do {
                // turn data into a string to handle odd characters in the rep names
                let dataAsString = String(data: data, encoding: .utf8)
                // turn that string back into data so that JSONDecoder can decode it
                guard let data = dataAsString?.data(using: .utf8) else { completion([]); return }
                // decodes
                let repObject = try JSONDecoder().decode([String : [Representative]].self, from: data)
                // goes one layer deep to create an array of "results"
                guard let repArray = repObject["results"] else {completion([]); return}
                print("Success")
                completion(repArray)
            } catch {
                print("There was an error decoding. \(error): \(error.localizedDescription)")
                completion([])
                return
            }
        } .resume()
    }
}
