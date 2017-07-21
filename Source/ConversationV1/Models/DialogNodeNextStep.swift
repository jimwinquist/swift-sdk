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

/** DialogNodeNextStep. */
public struct DialogNodeNextStep: JSONDecodable, JSONEncodable {

    /// How the `next_step` reference is processed.
    public enum Behavior: String {
        case to = "jump_to"
    }

    /// Which part of the dialog node to process next.
    public enum Selector: String {
        case condition = "condition"
        case client = "client"
        case userInput = "user_input"
        case body = "body"
    }

    /// How the `next_step` reference is processed.
    public let behavior: String

    /// The ID of the dialog node to process next.
    public let dialogNode: String?

    /// Which part of the dialog node to process next.
    public let selector: String?

    /**
     Initialize a `DialogNodeNextStep` with member variables.

     - parameter behavior: How the `next_step` reference is processed.
     - parameter dialogNode: The ID of the dialog node to process next.
     - parameter selector: Which part of the dialog node to process next.

     - returns: An initialized `DialogNodeNextStep`.
    */
    public init(behavior: String, dialogNode: String? = nil, selector: String? = nil) {
        self.behavior = behavior
        self.dialogNode = dialogNode
        self.selector = selector
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `DialogNodeNextStep` model from JSON.
    public init(json: JSON) throws {
        behavior = try json.getString(at: "behavior")
        dialogNode = try? json.getString(at: "dialog_node")
        selector = try? json.getString(at: "selector")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `DialogNodeNextStep` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["behavior"] = behavior
        if let dialogNode = dialogNode { json["dialog_node"] = dialogNode }
        if let selector = selector { json["selector"] = selector }
        return json
    }
}
