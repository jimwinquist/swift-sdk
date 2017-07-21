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

/** An intent identified in the user input. */
public struct RuntimeIntent: JSONDecodable, JSONEncodable {

    /// The raw JSON object used to construct this model.
    public let json: [String: Any]

    /// The name of the recognized intent.
    public let intent: String

    /// A decimal percentage that represents Watson's confidence in the intent.
    public let confidence: Double

    // MARK: JSONDecodable
    /// Used internally to initialize a `RuntimeIntent` model from JSON.
    public init(json: JSON) throws {
        self.json = try json.getDictionaryObject()
        intent = try json.getString(at: "intent")
        confidence = try json.getDouble(at: "confidence")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `RuntimeIntent` model to JSON.
    public func toJSONObject() -> Any {
        return json
    }
}
