//
//  WorldNewsClient.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import OpenAPIURLSession

public struct WorldNewsClient {

    public init() {}

    public func getGreeting(name: String?) async throws -> String {
        let apiKey = "2fc50c684ad04a7e8dcf413c0d6e20a8"

        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)]
            )
        let response = try await client.getGreeting(query: .init(name: name))

        switch response {
            case .ok(let okResponse):
            switch okResponse.body {
            case .json(let greeting):
                return greeting.message
            }
        case .undocumented(statusCode: let statusCode, _):
            return "Undocumented status code: \(statusCode)"
        }
    }


}

