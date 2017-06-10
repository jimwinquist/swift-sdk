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

/** For internal use only. */
public struct RuntimeContext: JSONDecodable, JSONEncodable {

    /// The raw JSON object used to construct this model.
    public let json: [String: Any]

    /// The unique identifier of the conversation.
    public let conversationID: String?

    public let system: RuntimeSystemContext?

    // MARK: JSONDecodable
    /// Used internally to initialize a `RuntimeContext` model from JSON.
    public init(json: JSON) throws {
        self.json = try json.getDictionaryObject()
        conversationID = try? json.getString(at: "conversation_id")
        system = try? json.decode(at: "system", type: RuntimeSystemContext.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `RuntimeContext` model to JSON.
    public func toJSONObject() -> Any {
        return json
    }
}