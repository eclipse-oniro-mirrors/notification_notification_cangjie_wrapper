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
import ohos.multimedia.image.PixelMap

/**
 * Defines the data structure of a notification request, which is used to describe all information about a
 * notification, including the notification content, identifier, display style, and interaction behavior.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public class NotificationRequest {
    private let notificationRequestImpl: NotificationRequestImpl

    /**
     * A constructor used to create a NotificationRequest.
     *
     * @param { NotificationContent } content - Notification display content, including the notification title and
     *     body.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public init(content: NotificationContent) {
        notificationRequestImpl = NotificationRequestImpl(content)
    }

    /**
     * Notification display content, including the notification title and body.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop content: NotificationContent {
        get() {
            notificationRequestImpl.content
        }
        set(v) {
            notificationRequestImpl.content = v
        }
    }

    /**
     * Notification ID. The default value is **0**. If a notification with the same ID exists, the notification is
     * updated. If no notification with the same ID exists, a new notification is created.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop id: ?Int32 {
        get() {
            notificationRequestImpl.id
        }
        set(v) {
            notificationRequestImpl.id = v
        }
    }

    /**
     * Notification slot type. The default value is **OTHER_TYPES**. The notification reminder mode varies depending on
     * the notification slot type.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop notificationSlotType: ?SlotType {
        get() {
            notificationRequestImpl.notificationSlotType
        }
        set(v) {
            notificationRequestImpl.notificationSlotType = v
        }
    }

    /**
     * Notification label. The **label** field functions similarly to an ID and can be used alone or combined with the
     * ID to serve as the notification identifier. It is recommended to use the ID. If the **label** is not empty when a
     * notification is published, the corresponding **label** must also be specified when the notification is updated or
     * deleted. The size does not exceed 202 bytes, and the excess part will be truncated. The value is empty by default.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop label: ?String {
        get() {
            notificationRequestImpl.label
        }
        set(v) {
            notificationRequestImpl.label = v
        }
    }

    /**
     * Small notification icon. This parameter is left empty by default. The total number of the icon pixel bytes
     * cannot exceed 192 KB (which is obtained through **getPixelBytesNumber**). The setting does not take effect if
     * the limit is exceeded. When **smallIcon** is not set, the notification displays the default application icon.
     * The recommended icon size is 128 × 128 pixels. The display effect depends on the device capability and
     * notification center UI style.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop smallIcon: ?PixelMap {
        get() {
            notificationRequestImpl.smallIcon
        }
        set(v) {
            notificationRequestImpl.smallIcon = v
        }
    }

    func toCNotificationRequest(): CNotificationRequestV2 {
        var request = CNotificationRequestV2(CNotificationContent(), notificationRequestImpl.id.getOrDefault({ => 0 }),
            notificationRequestImpl.notificationSlotType.getOrDefault({ => SlotType.OtherTypes }).value, false, false,
            0, false, 0, 0, false, false, false, false, false, CString(CPointer<UInt8>()), 0, false, -1, -1,
            CString(CPointer<UInt8>()), 0, 0, 0, CString(CPointer<UInt8>()), CString(CPointer<UInt8>()),
            CPointer<CDistributedOptions>(), CNotificationFlags(0, 0), 0, CString(CPointer<UInt8>()))
        request.content = notificationRequestImpl.content.toCNotificationContent()
        unsafe {
            request.label = LibC.mallocCString(notificationRequestImpl.label ?? "")
            request.groupName = LibC.mallocCString("")
            request.creatorBundleName = LibC.mallocCString("")
            request.hashCode = LibC.mallocCString("")
            request.appMessageId = LibC.mallocCString("")
        }
        if (let Some(icon) <- notificationRequestImpl.smallIcon) {
            request.smallIcon = icon.getID()
        }
        return request
    }
}

class NotificationRequestImpl {
    var content: NotificationContent
    var id: ?Int32
    var notificationSlotType: ?SlotType
    var label: ?String
    var smallIcon: ?PixelMap

    init(content: NotificationContent) {
        this.content = content
        this.id = Some(0)
        this.notificationSlotType = Some(SlotType.OtherTypes)
        this.label = Some("")
        this.smallIcon = None
    }
}
