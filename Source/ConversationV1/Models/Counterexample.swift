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

/** Counterexample. */
public struct Counterexample: JSONDecodable, JSONEncodable {

    /// The text of the counterexample.
    public let text: String

    /// The timestamp for creation of the counterexample.
    public let created: String

    /// The timestamp for the last update to the counterexample.
    public let updated: String

    /**
     Initialize a `Counterexample` with member variables.

     - parameter text: The text of the counterexample.
     - parameter created: The timestamp for creation of the counterexample.
     - parameter updated: The timestamp for the last update to the counterexample.

     - returns: An initialized `Counterexample`.
    */
    public init(text: String, created: String, updated: String) {
        self.text = text
        self.created = created
        self.updated = updated
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `Counterexample` model from JSON.
    public init(json: JSON) throws {
        text = try json.getString(at: "text")
        created = try json.getString(at: "created")
        updated = try json.getString(at: "updated")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `Counterexample` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["text"] = text
        json["created"] = created
        json["updated"] = updated
        return json
    }
}
