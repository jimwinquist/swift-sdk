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
public struct RuntimeEntity: JSONDecodable, JSONEncodable {

    /// The raw JSON object used to construct this model.
    public let json: [String: Any]

    /// The recognized entity from a term in the input.
    public let entity: String

    /// Zero-based character offsets that indicate where the entity value begins and ends in the input text.
    public let location: [Int]

    /// The term in the input text that was recognized.
    public let value: String

    /// A decimal percentage that represents Watson's confidence in the entity.
    public let confidence: Double?

    /// The metadata for the entity.
    public let metadata: [String: Any]?

    // MARK: JSONDecodable
    /// Used internally to initialize a `RuntimeEntity` model from JSON.
    public init(json: JSON) throws {
        self.json = try json.getDictionaryObject()
        entity = try json.getString(at: "entity")
        location = try json.decodedArray(at: "location", type: Int.self)
        value = try json.getString(at: "value")
        confidence = try? json.getDouble(at: "confidence")
        metadata = try? json.getDictionaryObject(at: "metadata")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `RuntimeEntity` model to JSON.
    public func toJSONObject() -> Any {
        return json
    }
}
