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
 * Describes the basic text notification, which is used to display the title and body content. It serves as the basic
 * content structure for other notification types. Other notification types (such as long text, multi-line text,
 * picture, and live view) inherit this API and extend their own specific fields on this basis.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification"
]
public open class NotificationBasicContent {
    private let notificationBasicContentImpl: NotificationBasicContentImpl

    /**
     * A constructor used to create a NotificationBasicContent.
     *
     * @param { String } title - Notification title, displayed at the top of the notification.
     * @param { String } text - Notification body content, displayed below the title.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public init(title: String, text: String) {
        notificationBasicContentImpl = NotificationBasicContentImpl(title, text)
    }

    /**
     * Notification title, displayed at the top of the notification. It cannot be an empty string. The size does not
     * exceed 1024 bytes, and the excess part will be truncated.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop title: String {
        get() {
            notificationBasicContentImpl.title
        }
        set(v) {
            notificationBasicContentImpl.title = v
        }
    }

    /**
     * Notification body content, displayed below the title. It cannot be an empty string. The size does not exceed
     * 3072 bytes, and the excess part will be truncated.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop text: String {
        get() {
            notificationBasicContentImpl.text
        }
        set(v) {
            notificationBasicContentImpl.text = v
        }
    }

    /**
     * Additional notification content, which supplements the notification content and is not displayed in the
     * notification center. It defaults to empty. The size does not exceed 3072 bytes, and the excess part will be
     * truncated.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop additionalText: ?String {
        get() {
            notificationBasicContentImpl.additionalText
        }
        set(v) {
            notificationBasicContentImpl.additionalText = v
        }
    }

    /**
     * Picture displayed on the lock screen. This parameter is left empty by default. Currently, only the live view
     * notification is supported. The total number of the icon pixel bytes cannot exceed 192 KB (which is obtained
     * through **getPixelBytesNumber**). The recommended icon size is 128 x 128 pixels. The display effect depends on
     * the device capability and notification center UI style.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Notification.Notification"
    ]
    public mut prop lockscreenPicture: ?PixelMap {
        get() {
            notificationBasicContentImpl.lockscreenPicture
        }
        set(v) {
            notificationBasicContentImpl.lockscreenPicture = v
        }
    }

    func toCNotificationBasicContent(): CNotificationBasicContent {
        var basicContent = CNotificationBasicContent()
        if (let Some(pix) <- notificationBasicContentImpl.lockscreenPicture) {
            basicContent.lockscreenPicture = pix.getID()
        }
        unsafe {
            basicContent.title = LibC.mallocCString(notificationBasicContentImpl.title)
            basicContent.text = LibC.mallocCString(notificationBasicContentImpl.text)
            basicContent.additionalText = LibC.mallocCString(notificationBasicContentImpl.additionalText ?? "")
        }
        return basicContent
    }
}

class NotificationBasicContentImpl {
    var title: String
    var text: String
    var additionalText: ?String
    var lockscreenPicture: ?PixelMap

    init(title: String, text: String) {
        this.title = title
        this.text = text
        this.additionalText = None
        this.lockscreenPicture = None
    }
}
