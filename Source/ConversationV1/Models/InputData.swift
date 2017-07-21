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

/** An object defining the user input. */
public struct InputData: JSONDecodable, JSONEncodable {

    /// The text of the user input.
    public let text: String

    /**
     Initialize a `InputData` with member variables.

     - parameter text: The text of the user input.

     - returns: An initialized `InputData`.
    */
    public init(text: String) {
        self.text = text
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `InputData` model from JSON.
    public init(json: JSON) throws {
        text = try json.getString(at: "text")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `InputData` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["text"] = text
        return json
    }
}
