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

/** An output object that includes the response to the user, the nodes that were hit, and messages from the log. */
public struct OutputData: JSONDecodable, JSONEncodable {

    /// The raw JSON object used to construct this model.
    public let json: [String: Any]

    /// Up to 50 messages logged with the request.
    public let logMessages: [LogMessage]

    /// An array of responses to the user.
    public let text: [String]

    /// An array of the nodes that were triggered to create the response.
    public let nodesVisited: [String]?

    // MARK: JSONDecodable
    /// Used internally to initialize a `OutputData` model from JSON.
    public init(json: JSON) throws {
        self.json = try json.getDictionaryObject()
        logMessages = try json.decodedArray(at: "log_messages", type: LogMessage.self)
        text = try json.decodedArray(at: "text", type: String.self)
        nodesVisited = try? json.decodedArray(at: "nodes_visited", type: String.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `OutputData` model to JSON.
    public func toJSONObject() -> Any {
        return json
    }
}
