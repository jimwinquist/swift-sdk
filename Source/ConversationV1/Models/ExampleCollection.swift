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

/** ExampleCollection. */
public struct ExampleCollection: JSONDecodable, JSONEncodable {

    /// An array of Example objects describing the examples defined for the intent.
    public let examples: [Example]

    /// An object defining the pagination data for the returned objects.
    public let pagination: Pagination

    /**
     Initialize a `ExampleCollection` with member variables.

     - parameter examples: An array of Example objects describing the examples defined for the intent.
     - parameter pagination: An object defining the pagination data for the returned objects.

     - returns: An initialized `ExampleCollection`.
    */
    public init(examples: [Example], pagination: Pagination) {
        self.examples = examples
        self.pagination = pagination
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `ExampleCollection` model from JSON.
    public init(json: JSON) throws {
        examples = try json.decodedArray(at: "examples", type: Example.self)
        pagination = try json.decode(at: "pagination", type: Pagination.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `ExampleCollection` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["examples"] = examples.map { $0.toJSONObject() }
        json["pagination"] = pagination.toJSONObject()
        return json
    }
}
