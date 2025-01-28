//
//  PlistDataStore.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 28.01.25.
//

import Foundation

protocol DataStore: Actor {
    associatedtype D

    func save(_ data: D)
    func load() -> D?
}

actor PlistDataStore<T: Codable>: DataStore where T: Equatable {

    private var saved: T?
    let fileName: String

    private var dataURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("\(fileName).plist")
    }

    init(filename: String) {
        self.fileName = filename
    }

    func save(_ data: T) {
        if let saved = self.saved, saved == data {
            return
        }

        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .binary
            let encodedData = try encoder.encode(data)
            try encodedData.write(to: dataURL, options: .atomic)
            self.saved = data
        } catch {
            print("Fail to save data: \(error.localizedDescription)")
        }


    }

    func load() -> D? {
        do {
            let data = try Data(contentsOf: dataURL)
            let decoder = PropertyListDecoder()
            let decodedData = try! decoder.decode(T.self, from: data)
            self.saved = decodedData
            return decodedData
        } catch {
            print("Fail to load data: \(error.localizedDescription)")
            return nil
        }
    }
}
