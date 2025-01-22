//
//  MockDataLoader.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 22.01.25.
//

import Foundation


class MockDataLoader {
    static func loadNewsData() -> ArticleDTO? {
            // Get the URL of the mock data file in the app bundle
            guard let url = Bundle.main.url(forResource: "mockData", withExtension: "json") else {
                print("Couldn't find the file in the app bundle.")
                return nil
            }

            do {
                // Load the data from the file
                let data = try Data(contentsOf: url)

                // Decode the JSON into the NewsResponse model
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(ArticleDTO.self, from: data)
                return decodedData
            } catch {
                print("Error decoding JSON data: \(error)")
                return nil
            }
        }
}
