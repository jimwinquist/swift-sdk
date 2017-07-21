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

/** A response from the Conversation service. */
public struct MessageResponse: JSONDecodable, JSONEncodable {

    /// The raw JSON object used to construct this model.
    public let json: [String: Any]

    /// The user input from the request.
    public let input: MessageInput?

    /// An array of intents recognized in the user input, sorted in descending order of confidence.
    public let intents: [RuntimeIntent]

    /// An array of entities identified in the user input.
    public let entities: [RuntimeEntity]

    /// Whether to return more than one intent. `true` indicates that all matching intents are returned.
    public let alternateIntents: Bool?

    /// State information for the conversation.
    public let context: Context

    /// Output from the dialog, including the response to the user, the nodes that were triggered, and log messages.
    public let output: OutputData

    // MARK: JSONDecodable
    /// Used internally to initialize a `MessageResponse` model from JSON.
    public init(json: JSON) throws {
        self.json = try json.getDictionaryObject()
        input = try? json.decode(at: "input", type: MessageInput.self)
        intents = try json.decodedArray(at: "intents", type: RuntimeIntent.self)
        entities = try json.decodedArray(at: "entities", type: RuntimeEntity.self)
        alternateIntents = try? json.getBool(at: "alternate_intents")
        context = try json.decode(at: "context", type: Context.self)
        output = try json.decode(at: "output", type: OutputData.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `MessageResponse` model to JSON.
    public func toJSONObject() -> Any {
        return json
    }
}
