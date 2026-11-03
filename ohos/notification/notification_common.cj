/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.notification_manager

import ohos.business_exception.{BusinessException, getUniversalErrorMsg}
import ohos.ffi.*
import ohos.labels.APILevel
import std.deriving.Derive

/**
 * Enumerates the notification slot types.
 *
 * Different types correspond to different **SlotLevel** values, determining the reminder behavior of the
 * notification.
 */
@Derive[ToString, Equatable, Hashable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public enum SlotType {
    /**
     * Unknown type. This type corresponds to the **SlotLevel** of **LEVEL_MIN**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    UnknownType
    |
    /**
     * Social communication. This type corresponds to the **SlotLevel** of **LEVEL_HIGH**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    SocialCommunication
    |
    /**
     * Service information. This type corresponds to the **SlotLevel** of **LEVEL_HIGH**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    ServiceInformation
    |
    /**
     * Content information. This type corresponds to the **SlotLevel** of **LEVEL_MIN**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    ContentInformation
    |
    /**
     * Live view. A third-party application cannot directly create a notification of this type. Instead, after the
     * system proxy creates a notification, the third-party application can release the notification with the same ID
     * to update the specified content. This type corresponds to the **SlotLevel** of **LEVEL_DEFAULT**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    LiveView
    |
    /**
     * Customer service message. This type is used for messages between users and customer service providers. The
     * messages must be initiated by users. This type corresponds to the **SlotLevel** of **LEVEL_DEFAULT**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    CustomerService
    |
    /**
     * Emergency event.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    EmergencyInformation
    |
    /**
     * Other types. This type corresponds to the **SlotLevel** of **LEVEL_MIN**.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    OtherTypes

    prop value: Int32 {
        get() {
            match (this) {
                case UnknownType => 0
                case SocialCommunication => 1
                case ServiceInformation => 2
                case ContentInformation => 3
                case LiveView => 4
                case CustomerService => 5
                case EmergencyInformation => 6
                case OtherTypes => 0xFFFF
            }
        }
    }
}

/**
 * Enumerates the notification content types.
 */
@Derive[ToString, Equatable, Hashable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public enum ContentType {
    /**
     * Normal text notification.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentBasicText
    |
    /**
     * Long text notification.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentLongText
    |
    /**
     * Picture-attached notification.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentPicture
    |
    /**
     * Conversation notification.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentConversation
    |
    /**
     * Multi-line text notification.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentMultiline
    |
    /**
     * System live view notification. A third-party application cannot directly create a notification of this type.
     * After the system proxy creates a system live view, the third-party application publishes a notification with
     * the same ID to update the specified content.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentSystemLiveView
    |
    /**
     * Common live view notification. Available only to system applications.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentLiveView

    prop value: Int32 {
        get() {
            match (this) {
                case NotificationContentBasicText => 0
                case NotificationContentLongText => 1
                case NotificationContentPicture => 2
                case NotificationContentConversation => 3
                case NotificationContentMultiline => 4
                case NotificationContentSystemLiveView => 5
                case NotificationContentLiveView => 6
            }
        }
    }
}

func getErrorInfo(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    }
    return "Unknown error."
}

func throwIfNotSuccess(code: Int32): Unit {
    if (code != SUCCESS_CODE) {
        throw BusinessException(code, getErrorInfo(code))
    }
}

func safeMallocT<T>(count!: Int64 = 1): CPointer<T> where T <: CType {
    let ptr = LibC.malloc<T>(count: count)
    if (ptr.isNull()) {
        throw BusinessException(1600012, "No memory space.")
    }
    ptr
}
