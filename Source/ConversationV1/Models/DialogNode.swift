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

/** DialogNode. */
public struct DialogNode {

    /// How the dialog node is processed.
    public enum NodeType: String {
        case standard = "standard"
        case eventHandler = "event_handler"
        case frame = "frame"
        case slot = "slot"
        case responseCondition = "response_condition"
    }

    /// How an `event_handler` node is processed.
    public enum EventName: String {
        case focus = "focus"
        case input = "input"
        case filled = "filled"
        case validate = "validate"
        case filledMultiple = "filled_multiple"
        case generic = "generic"
        case nomatch = "nomatch"
        case nomatchResponsesDepleted = "nomatch_responses_depleted"
    }

    /// The dialog node ID.
    public let dialogNodeID: String

    /// The description of the dialog node.
    public let description: String

    /// The condition that triggers the dialog node.
    public let conditions: String

    /// The ID of the parent dialog node.
    public let parent: String

    /// The ID of the previous sibling dialog node.
    public let previousSibling: String

    /// The output of the dialog node.
    public let output: [String: JSONValue]

    /// The context (if defined) for the dialog node.
    public let context: [String: JSONValue]

    /// The metadata (if any) for the dialog node.
    public let metadata: [String: JSONValue]

    /// The next step to execute following this dialog node.
    public let nextStep: DialogNodeNextStep

    /// The timestamp for creation of the dialog node.
    public let created: String

    /// The timestamp for the most recent update to the dialog node.
    public let updated: String?

    /// The actions for the dialog node.
    public let actions: [DialogNodeAction]?

    /// The alias used to identify the dialog node.
    public let title: String

    /// How the dialog node is processed.
    public let nodeType: String?

    /// How an `event_handler` node is processed.
    public let eventName: String?

    /// The location in the dialog context where output is stored.
    public let variable: String?

    /**
     Initialize a `DialogNode` with member variables.

     - parameter dialogNodeID: The dialog node ID.
     - parameter description: The description of the dialog node.
     - parameter conditions: The condition that triggers the dialog node.
     - parameter parent: The ID of the parent dialog node.
     - parameter previousSibling: The ID of the previous sibling dialog node.
     - parameter output: The output of the dialog node.
     - parameter context: The context (if defined) for the dialog node.
     - parameter metadata: The metadata (if any) for the dialog node.
     - parameter nextStep: The next step to execute following this dialog node.
     - parameter created: The timestamp for creation of the dialog node.
     - parameter title: The alias used to identify the dialog node.
     - parameter updated: The timestamp for the most recent update to the dialog node.
     - parameter actions: The actions for the dialog node.
     - parameter nodeType: How the dialog node is processed.
     - parameter eventName: How an `event_handler` node is processed.
     - parameter variable: The location in the dialog context where output is stored.

     - returns: An initialized `DialogNode`.
    */
    public init(dialogNodeID: String, description: String, conditions: String, parent: String, previousSibling: String, output: [String: JSONValue], context: [String: JSONValue], metadata: [String: JSONValue], nextStep: DialogNodeNextStep, created: String, title: String, updated: String? = nil, actions: [DialogNodeAction]? = nil, nodeType: String? = nil, eventName: String? = nil, variable: String? = nil) {
        self.dialogNodeID = dialogNodeID
        self.description = description
        self.conditions = conditions
        self.parent = parent
        self.previousSibling = previousSibling
        self.output = output
        self.context = context
        self.metadata = metadata
        self.nextStep = nextStep
        self.created = created
        self.title = title
        self.updated = updated
        self.actions = actions
        self.nodeType = nodeType
        self.eventName = eventName
        self.variable = variable
    }
}

extension DialogNode: Codable {

    private enum CodingKeys: String, CodingKey {
        case dialogNodeID = "dialog_node"
        case description = "description"
        case conditions = "conditions"
        case parent = "parent"
        case previousSibling = "previous_sibling"
        case output = "output"
        case context = "context"
        case metadata = "metadata"
        case nextStep = "next_step"
        case created = "created"
        case updated = "updated"
        case actions = "actions"
        case title = "title"
        case nodeType = "type"
        case eventName = "event_name"
        case variable = "variable"
        static let allValues = [dialogNodeID, description, conditions, parent, previousSibling, output, context, metadata, nextStep, created, updated, actions, title, nodeType, eventName, variable]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dialogNodeID = try container.decode(String.self, forKey: .dialogNodeID)
        description = try container.decode(String.self, forKey: .description)
        conditions = try container.decode(String.self, forKey: .conditions)
        parent = try container.decode(String.self, forKey: .parent)
        previousSibling = try container.decode(String.self, forKey: .previousSibling)
        output = try container.decode([String: JSONValue].self, forKey: .output)
        context = try container.decode([String: JSONValue].self, forKey: .context)
        metadata = try container.decode([String: JSONValue].self, forKey: .metadata)
        nextStep = try container.decode(DialogNodeNextStep.self, forKey: .nextStep)
        created = try container.decode(String.self, forKey: .created)
        updated = try container.decodeIfPresent(String.self, forKey: .updated)
        actions = try container.decodeIfPresent([DialogNodeAction].self, forKey: .actions)
        title = try container.decode(String.self, forKey: .title)
        nodeType = try container.decodeIfPresent(String.self, forKey: .nodeType)
        eventName = try container.decodeIfPresent(String.self, forKey: .eventName)
        variable = try container.decodeIfPresent(String.self, forKey: .variable)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dialogNodeID, forKey: .dialogNodeID)
        try container.encode(description, forKey: .description)
        try container.encode(conditions, forKey: .conditions)
        try container.encode(parent, forKey: .parent)
        try container.encode(previousSibling, forKey: .previousSibling)
        try container.encode(output, forKey: .output)
        try container.encode(context, forKey: .context)
        try container.encode(metadata, forKey: .metadata)
        try container.encode(nextStep, forKey: .nextStep)
        try container.encode(created, forKey: .created)
        try container.encodeIfPresent(updated, forKey: .updated)
        try container.encodeIfPresent(actions, forKey: .actions)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(nodeType, forKey: .nodeType)
        try container.encodeIfPresent(eventName, forKey: .eventName)
        try container.encodeIfPresent(variable, forKey: .variable)
    }

}
