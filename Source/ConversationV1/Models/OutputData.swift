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
public struct OutputData {

    /// Up to 50 messages logged with the request.
    public let logMessages: [LogMessage]

    /// An array of responses to the user.
    public let text: [String]

    /// An array of the nodes that were triggered to create the response.
    public let nodesVisited: [String]?

    /// Additional properties associated with this model.
    public let additionalProperties: [String: JSONValue]?

    /**
     Initialize a `OutputData` with member variables.

     - parameter logMessages: Up to 50 messages logged with the request.
     - parameter text: An array of responses to the user.
     - parameter nodesVisited: An array of the nodes that were triggered to create the response.

     - returns: An initialized `OutputData`.
    */
    public init(logMessages: [LogMessage], text: [String], nodesVisited: [String]? = nil, additionalProperties: [String: JSONValue]? = nil) {
        self.logMessages = logMessages
        self.text = text
        self.nodesVisited = nodesVisited
        self.additionalProperties = additionalProperties
    }
}

extension OutputData: Codable {

    private enum CodingKeys: String, CodingKey {
        case logMessages = "log_messages"
        case text = "text"
        case nodesVisited = "nodes_visited"
        static let allValues = [logMessages, text, nodesVisited]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dynamic = try decoder.container(keyedBy: DynamicKeys.self)
        logMessages = try container.decode([LogMessage].self, forKey: .logMessages)
        text = try container.decode([String].self, forKey: .text)
        nodesVisited = try container.decodeIfPresent([String].self, forKey: .nodesVisited)
        additionalProperties = try dynamic.decodeIfPresent([String: JSONValue].self, excluding: CodingKeys.allValues)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var dynamic = encoder.container(keyedBy: DynamicKeys.self)
        try container.encode(logMessages, forKey: .logMessages)
        try container.encode(text, forKey: .text)
        try container.encodeIfPresent(nodesVisited, forKey: .nodesVisited)
        try dynamic.encodeIfPresent(additionalProperties)
    }

}
