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

import ohos.labels.APILevel

/**
 * Describes the notification contents.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public class NotificationContent {
    private let notificationContentImpl: NotificationContentImpl

    /**
     * A constructor used to create a NotificationContent.
     *
     * @param { ContentType } notificationContentType - Notification content type, used to specify the content layout
     *     type of the notification, which determines the display style of the notification in the notification
     *     center.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public init(notificationContentType: ContentType) {
        notificationContentImpl = NotificationContentImpl(notificationContentType)
    }

    /**
     * Notification content type, used to specify the content layout type of the notification, which determines the
     * display style of the notification in the notification center. It must be used together with the corresponding
     * notification content object. For example, when this parameter is set to
     * **NOTIFICATION_CONTENT_BASIC_TEXT**, the **normal** field must be specified at the same time.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop notificationContentType: ContentType {
        get() {
            notificationContentImpl.notificationContentType
        }
        set(v) {
            notificationContentImpl.notificationContentType = v
        }
    }

    /**
     * Basic notification content. This parameter is used when **notificationContentType** is
     * **NOTIFICATION_CONTENT_BASIC_TEXT**. The notification displays the title and body in a plain text style.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop normal: ?NotificationBasicContent {
        get() {
            notificationContentImpl.normal
        }
        set(v) {
            notificationContentImpl.normal = v
        }
    }

    func toCNotificationContent(): CNotificationContent {
        var cContent = CNotificationContent()
        cContent.notificationContentType = notificationContentImpl.notificationContentType.value
        unsafe {
            if (let Some(content) <- notificationContentImpl.normal) {
                cContent.normal = safeMallocT<CNotificationBasicContent>()
                cContent.normal.write(content.toCNotificationBasicContent())
            }
        }
        return cContent
    }
}

class NotificationContentImpl {
    var notificationContentType: ContentType
    var normal: ?NotificationBasicContent

    init(notificationContentType: ContentType) {
        this.notificationContentType = notificationContentType
        this.normal = None
    }
}
