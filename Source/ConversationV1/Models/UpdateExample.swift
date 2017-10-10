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

/** UpdateExample. */
public struct UpdateExample {

    /// The text of the user input example.
    public let text: String?

    /**
     Initialize a `UpdateExample` with member variables.

     - parameter text: The text of the user input example.

     - returns: An initialized `UpdateExample`.
    */
    public init(text: String? = nil) {
        self.text = text
    }
}

extension UpdateExample: Codable {

    private enum CodingKeys: String, CodingKey {
        case text = "text"
        static let allValues = [text]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decodeIfPresent(String.self, forKey: .text)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(text, forKey: .text)
    }

}
