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

/** UpdateDialogNode. */
public struct UpdateDialogNode {

    /// How the node is processed.
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
    public let dialogNode: String

    /// The description of the dialog node.
    public let description: String?

    /// The condition that will trigger the dialog node.
    public let conditions: String?

    /// The ID of the parent dialog node (if any).
    public let parent: String?

    /// The previous dialog node.
    public let previousSibling: String?

    /// The output of the dialog node.
    public let output: [String: JSONValue]?

    /// The context for the dialog node.
    public let context: [String: JSONValue]?

    /// The metadata for the dialog node.
    public let metadata: [String: JSONValue]?

    /// The next step to execute following this dialog node.
    public let nextStep: DialogNodeNextStep?

    /// The alias used to identify the dialog node.
    public let title: String?

    /// How the node is processed.
    public let nodeType: String?

    /// How an `event_handler` node is processed.
    public let eventName: String?

    /// The location in the dialog context where output is stored.
    public let variable: String?

    /// The actions for the dialog node.
    public let actions: [DialogNodeAction]?

    /**
     Initialize a `UpdateDialogNode` with member variables.

     - parameter dialogNode: The dialog node ID.
     - parameter description: The description of the dialog node.
     - parameter conditions: The condition that will trigger the dialog node.
     - parameter parent: The ID of the parent dialog node (if any).
     - parameter previousSibling: The previous dialog node.
     - parameter output: The output of the dialog node.
     - parameter context: The context for the dialog node.
     - parameter metadata: The metadata for the dialog node.
     - parameter nextStep: The next step to execute following this dialog node.
     - parameter title: The alias used to identify the dialog node.
     - parameter nodeType: How the node is processed.
     - parameter eventName: How an `event_handler` node is processed.
     - parameter variable: The location in the dialog context where output is stored.
     - parameter actions: The actions for the dialog node.

     - returns: An initialized `UpdateDialogNode`.
    */
    public init(dialogNode: String, description: String? = nil, conditions: String? = nil, parent: String? = nil, previousSibling: String? = nil, output: [String: JSONValue]? = nil, context: [String: JSONValue]? = nil, metadata: [String: JSONValue]? = nil, nextStep: DialogNodeNextStep? = nil, title: String? = nil, nodeType: String? = nil, eventName: String? = nil, variable: String? = nil, actions: [DialogNodeAction]? = nil) {
        self.dialogNode = dialogNode
        self.description = description
        self.conditions = conditions
        self.parent = parent
        self.previousSibling = previousSibling
        self.output = output
        self.context = context
        self.metadata = metadata
        self.nextStep = nextStep
        self.title = title
        self.nodeType = nodeType
        self.eventName = eventName
        self.variable = variable
        self.actions = actions
    }
}

extension UpdateDialogNode: Codable {

    private enum CodingKeys: String, CodingKey {
        case dialogNode = "dialog_node"
        case description = "description"
        case conditions = "conditions"
        case parent = "parent"
        case previousSibling = "previous_sibling"
        case output = "output"
        case context = "context"
        case metadata = "metadata"
        case nextStep = "next_step"
        case title = "title"
        case nodeType = "type"
        case eventName = "event_name"
        case variable = "variable"
        case actions = "actions"
        static let allValues = [dialogNode, description, conditions, parent, previousSibling, output, context, metadata, nextStep, title, nodeType, eventName, variable, actions]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dialogNode = try container.decode(String.self, forKey: .dialogNode)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        conditions = try container.decodeIfPresent(String.self, forKey: .conditions)
        parent = try container.decodeIfPresent(String.self, forKey: .parent)
        previousSibling = try container.decodeIfPresent(String.self, forKey: .previousSibling)
        output = try container.decodeIfPresent([String: JSONValue].self, forKey: .output)
        context = try container.decodeIfPresent([String: JSONValue].self, forKey: .context)
        metadata = try container.decodeIfPresent([String: JSONValue].self, forKey: .metadata)
        nextStep = try container.decodeIfPresent(DialogNodeNextStep.self, forKey: .nextStep)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        nodeType = try container.decodeIfPresent(String.self, forKey: .nodeType)
        eventName = try container.decodeIfPresent(String.self, forKey: .eventName)
        variable = try container.decodeIfPresent(String.self, forKey: .variable)
        actions = try container.decodeIfPresent([DialogNodeAction].self, forKey: .actions)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dialogNode, forKey: .dialogNode)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(conditions, forKey: .conditions)
        try container.encodeIfPresent(parent, forKey: .parent)
        try container.encodeIfPresent(previousSibling, forKey: .previousSibling)
        try container.encodeIfPresent(output, forKey: .output)
        try container.encodeIfPresent(context, forKey: .context)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(nextStep, forKey: .nextStep)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(nodeType, forKey: .nodeType)
        try container.encodeIfPresent(eventName, forKey: .eventName)
        try container.encodeIfPresent(variable, forKey: .variable)
        try container.encodeIfPresent(actions, forKey: .actions)
    }

}
