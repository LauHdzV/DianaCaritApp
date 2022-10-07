//
//  Model.swift
//  CaritAppLogin
//
//  Created by Alumno on 29/09/22.
//

import Foundation

// MARK: -
struct Result: Codable {
    let celular: String
    let contrasena: String
    let correo: String
    let domicilio: String
    let edad: Int
    let id: Int
    let nombre: String
    let validado: Bool
}

struct Request: Codable{
    let correo: String
    let contrasena: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
