/**
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation
import RestKit

/** A term from the request that was identified as an entity. */
public struct RuntimeEntity {

    /// The recognized entity from a term in the input.
    public let entity: String

    /// Zero-based character offsets that indicate where the entity value begins and ends in the input text.
    public let location: [Int]

    /// The term in the input text that was recognized.
    public let value: String

    /// A decimal percentage that represents Watson's confidence in the entity.
    public let confidence: Double?

    /// The metadata for the entity.
    public let metadata: [String: JSONValue]?

    /// Additional properties associated with this model.
    public let additionalProperties: [String: JSONValue]?

    /**
     Initialize a `RuntimeEntity` with member variables.

     - parameter entity: The recognized entity from a term in the input.
     - parameter location: Zero-based character offsets that indicate where the entity value begins and ends in the input text.
     - parameter value: The term in the input text that was recognized.
     - parameter confidence: A decimal percentage that represents Watson's confidence in the entity.
     - parameter metadata: The metadata for the entity.

     - returns: An initialized `RuntimeEntity`.
    */
    public init(entity: String, location: [Int], value: String, confidence: Double? = nil, metadata: [String: JSONValue]? = nil, additionalProperties: [String: JSONValue]? = nil) {
        self.entity = entity
        self.location = location
        self.value = value
        self.confidence = confidence
        self.metadata = metadata
        self.additionalProperties = additionalProperties
    }
}

extension RuntimeEntity: Codable {

    private enum CodingKeys: String, CodingKey {
        case entity = "entity"
        case location = "location"
        case value = "value"
        case confidence = "confidence"
        case metadata = "metadata"
        static let allValues = [entity, location, value, confidence, metadata]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dynamic = try decoder.container(keyedBy: DynamicKeys.self)
        entity = try container.decode(String.self, forKey: .entity)
        location = try container.decode([Int].self, forKey: .location)
        value = try container.decode(String.self, forKey: .value)
        confidence = try container.decodeIfPresent(Double.self, forKey: .confidence)
        metadata = try container.decodeIfPresent([String: JSONValue].self, forKey: .metadata)
        additionalProperties = try dynamic.decodeIfPresent([String: JSONValue].self, excluding: CodingKeys.allValues)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var dynamic = encoder.container(keyedBy: DynamicKeys.self)
        try container.encode(entity, forKey: .entity)
        try container.encode(location, forKey: .location)
        try container.encode(value, forKey: .value)
        try container.encodeIfPresent(confidence, forKey: .confidence)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try dynamic.encodeIfPresent(additionalProperties)
    }

}
