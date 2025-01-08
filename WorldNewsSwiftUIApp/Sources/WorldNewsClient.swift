//
//  WorldNewsClient.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import OpenAPIURLSession

public struct WorldNewsClient {
    let news: [Components.Schemas.Article] = []

    public init() {}

    public func getGreeting(name: String?) async throws -> String {

         "Hello, World!"
    }

    public func getNews() async throws  {
        let apiKey = "2fc50c684ad04a7e8dcf413c0d6e20a8"
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)]
        )
        let response = try await client.getLatestNews()
        print(response)

    }


}

