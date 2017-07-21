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

/** CounterexampleCollection. */
public struct CounterexampleCollection: JSONDecodable, JSONEncodable {

    /// An array of objects describing the examples marked as irrelevant input.
    public let counterexamples: [Counterexample]

    /// An object defining the pagination data for the returned objects.
    public let pagination: Pagination

    /**
     Initialize a `CounterexampleCollection` with member variables.

     - parameter counterexamples: An array of objects describing the examples marked as irrelevant input.
     - parameter pagination: An object defining the pagination data for the returned objects.

     - returns: An initialized `CounterexampleCollection`.
    */
    public init(counterexamples: [Counterexample], pagination: Pagination) {
        self.counterexamples = counterexamples
        self.pagination = pagination
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `CounterexampleCollection` model from JSON.
    public init(json: JSON) throws {
        counterexamples = try json.decodedArray(at: "counterexamples", type: Counterexample.self)
        pagination = try json.decode(at: "pagination", type: Pagination.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `CounterexampleCollection` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["counterexamples"] = counterexamples.map { $0.toJSONObject() }
        json["pagination"] = pagination.toJSONObject()
        return json
    }
}
