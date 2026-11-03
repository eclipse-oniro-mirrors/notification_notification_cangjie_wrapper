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

import ohos.business_exception.AsyncCallback
import ohos.labels.APILevel
import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.multimedia.image.PixelMap
import std.deriving.Derive

@Derive[ToString, Equatable, Hashable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public enum SlotType {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    UnknownType
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    SocialCommunication
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    ServiceInformation
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    ContentInformation
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    LiveView
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    CustomerService
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    EmergencyInformation
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    OtherTypes
}

@Derive[ToString, Equatable, Hashable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public enum ContentType {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentBasicText
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentLongText
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentPicture
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentConversation
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentMultiline
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentSystemLiveView
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    NotificationContentLiveView
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public open class NotificationBasicContent {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public init(title: String, text: String) {
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop title: String {
        get() {
            ""
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop text: String {
        get() {
            ""
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop additionalText: ?String {
        get() {
            None
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop lockscreenPicture: ?PixelMap {
        get() {
            None
        }
        set(v) {
        }
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public class NotificationContent {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public init(notificationContentType: ContentType) {
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop notificationContentType: ContentType {
        get() {
            ContentType.NotificationContentBasicText
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop normal: ?NotificationBasicContent {
        get() {
            None
        }
        set(v) {
        }
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public class NotificationRequest {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public init(content: NotificationContent) {
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop content: NotificationContent {
        get() {
            NotificationContent(ContentType.NotificationContentBasicText)
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop id: ?Int32 {
        get() {
            Some(0)
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop notificationSlotType: ?SlotType {
        get() {
            Some(SlotType.OtherTypes)
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop label: ?String {
        get() {
            Some("")
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop smallIcon: ?PixelMap {
        get() {
            None
        }
        set(v) {
        }
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func publish(request: NotificationRequest, callback: AsyncCallback<Unit>): Unit {
    callback(None, Some(()))
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func cancelAll(callback: AsyncCallback<Unit>): Unit {
    callback(None, Some(()))
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func isNotificationEnabledSync(): Bool {
    true
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func requestEnableNotification(context: UIAbilityContext, callback: AsyncCallback<Unit>): Unit {
    callback(None, Some(()))
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func setBadgeNumber(badgeNumber: Int32, callback: AsyncCallback<Unit>): Unit {
    callback(None, Some(()))
}
