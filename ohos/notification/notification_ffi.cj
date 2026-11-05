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


foreign {
    func FfiOHOSNotificationManagerPublishV2(request: CNotificationRequestV2): Int32

    func FfiOHOSNotificationManagerCancelAllV2(): Int32

    func FfiOHOSNotificationManagerIsNotificationEnabledV2(): CNotificationRetBool

    func FfiOHOSNotificationManagerSetBadgeNumberV2(badgeNumber: Int32): Int32

    func FfiOHOSNotificationManagerRequestEnableNotificationV2(): Int32

    func FfiOHOSNotificationManagerRequestEnableNotificationWithContextV2(id: Int64): Int32
}

@C
struct CNotificationRetBool {
    CNotificationRetBool(
        let code: Int32,
        let data: Bool
    ) {}
}

@C
struct CNotificationFlags {
    CNotificationFlags(
        let soundEnabled: Int32,
        let vibrationEnabled: Int32
    ) {}
}

@C
struct CDistributedOptions {
    var devices: CPointer<CString>
    var size: Int64

    init() {
        devices = CPointer<CString>()
        size = 0
    }

    func free() {
        unsafe {
            if (!devices.isNull()) {
                LibC.free(devices)
            }
        }
    }
}

@C
struct CNotificationBasicContent {
    var title: CString
    var text: CString
    var additionalText: CString
    var lockscreenPicture: Int64

    init() {
        title = CString(CPointer<UInt8>())
        text = CString(CPointer<UInt8>())
        additionalText = CString(CPointer<UInt8>())
        lockscreenPicture = -1
    }

    func free() {
        unsafe {
            LibC.free(title)
            LibC.free(text)
            LibC.free(additionalText)
        }
    }
}

@C
struct CNotificationContent {
    var notificationContentType: Int32
    var normal: CPointer<CNotificationBasicContent>
    var longText: CPointer<CNotificationBasicContent>
    var multiLine: CPointer<CNotificationBasicContent>
    var picture: CPointer<CNotificationBasicContent>
    var systemLiveView: CPointer<CNotificationBasicContent>

    init() {
        notificationContentType = 0
        normal = CPointer<CNotificationBasicContent>()
        longText = CPointer<CNotificationBasicContent>()
        multiLine = CPointer<CNotificationBasicContent>()
        picture = CPointer<CNotificationBasicContent>()
        systemLiveView = CPointer<CNotificationBasicContent>()
    }

    func free() {
        unsafe {
            if (normal.isNotNull()) {
                normal.read().free()
            }
            LibC.free<CNotificationBasicContent>(normal)
            if (longText.isNotNull()) {
                longText.read().free()
            }
            LibC.free<CNotificationBasicContent>(longText)
            if (multiLine.isNotNull()) {
                multiLine.read().free()
            }
            LibC.free<CNotificationBasicContent>(multiLine)
            if (picture.isNotNull()) {
                picture.read().free()
            }
            LibC.free<CNotificationBasicContent>(picture)
            if (systemLiveView.isNotNull()) {
                systemLiveView.read().free()
            }
            LibC.free<CNotificationBasicContent>(systemLiveView)
        }
    }
}

@C
struct CNotificationRequestV2 {
    CNotificationRequestV2(
        var content: CNotificationContent,
        let id: Int32,
        let notificationSlotType: Int32,
        let isOngoing: Bool,
        let isUnremovable: Bool,
        let deliveryTime: Int64,
        let tapDismissed: Bool,
        let autoDeletedTime: Int64,
        let color: UInt32,
        let colorEnabled: Bool,
        let isAlertOnce: Bool,
        let isStopwatch: Bool,
        let isCountDown: Bool,
        let isFloatingIcon: Bool,
        var label: CString,
        let badgeIconStyle: Int32,
        let showDeliveryTime: Bool,
        var smallIcon: Int64,
        var largeIcon: Int64,
        var creatorBundleName: CString,
        let creatorUid: Int32,
        let creatorPid: Int32,
        let creatorUserId: Int32,
        var hashCode: CString,
        var groupName: CString,
        var distributedOption: CPointer<CDistributedOptions>,
        var notificationFlags: CNotificationFlags,
        let badgeNumber: UInt32,
        var appMessageId: CString
    ) {}

    func free() {
        content.free()
        unsafe {
            LibC.free(label)
            LibC.free(creatorBundleName)
            LibC.free(groupName)
            LibC.free(appMessageId)
            LibC.free(hashCode)
            if (!distributedOption.isNull()) {
                distributedOption.read().free()
            }
            LibC.free<CDistributedOptions>(distributedOption)
        }
    }
}
