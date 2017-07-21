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

/** A request formatted for the Conversation service. */
public struct MessageRequest: JSONDecodable, JSONEncodable {

    /// An input object that includes the input text.
    public let input: InputData?

    /// Whether to return more than one intent. Set to `true` to return all matching intents.
    public let alternateIntents: Bool?

    /// State information for the conversation. Continue a conversation by including the context object from the previous response.
    public let context: Context?

    /// Include the entities from the previous response when they do not need to change and to prevent Watson from trying to identify them.
    public let entities: [RuntimeEntity]?

    /// An array of name-confidence pairs for the user input. Include the intents from the previous response when they do not need to change and to prevent Watson from trying to identify them.
    public let intents: [RuntimeIntent]?

    /// System output. Include the output from the request when you have several requests within the same Dialog turn to pass back in the intermediate information.
    public let output: OutputData?

    /**
     Initialize a `MessageRequest` with member variables.

     - parameter input: An input object that includes the input text.
     - parameter alternateIntents: Whether to return more than one intent. Set to `true` to return all matching intents.
     - parameter context: State information for the conversation. Continue a conversation by including the context object from the previous response.
     - parameter entities: Include the entities from the previous response when they do not need to change and to prevent Watson from trying to identify them.
     - parameter intents: An array of name-confidence pairs for the user input. Include the intents from the previous response when they do not need to change and to prevent Watson from trying to identify them.
     - parameter output: System output. Include the output from the request when you have several requests within the same Dialog turn to pass back in the intermediate information.

     - returns: An initialized `MessageRequest`.
    */
    public init(input: InputData? = nil, alternateIntents: Bool? = nil, context: Context? = nil, entities: [RuntimeEntity]? = nil, intents: [RuntimeIntent]? = nil, output: OutputData? = nil) {
        self.input = input
        self.alternateIntents = alternateIntents
        self.context = context
        self.entities = entities
        self.intents = intents
        self.output = output
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `MessageRequest` model from JSON.
    public init(json: JSON) throws {
        input = try? json.decode(at: "input", type: InputData.self)
        alternateIntents = try? json.getBool(at: "alternate_intents")
        context = try? json.decode(at: "context", type: Context.self)
        entities = try? json.decodedArray(at: "entities", type: RuntimeEntity.self)
        intents = try? json.decodedArray(at: "intents", type: RuntimeIntent.self)
        output = try? json.decode(at: "output", type: OutputData.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `MessageRequest` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        if let input = input { json["input"] = input.toJSONObject() }
        if let alternateIntents = alternateIntents { json["alternate_intents"] = alternateIntents }
        if let context = context { json["context"] = context.toJSONObject() }
        if let entities = entities {
            json["entities"] = entities.map { $0.toJSONObject() }
        }
        if let intents = intents {
            json["intents"] = intents.map { $0.toJSONObject() }
        }
        if let output = output { json["output"] = output.toJSONObject() }
        return json
    }
}
