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

import ohos.business_exception.{BusinessException, AsyncCallback}
import ohos.ffi.*
import ohos.labels.APILevel
import ohos.app.ability.ui_ability.UIAbilityContext

/**
 * Publishes a notification. This API uses an asynchronous callback to return the result.
 *
 * After a notification is published, it will be displayed as a notification widget in the device's notification
 * center, status bar, etc. If the ID and tag of the newly published notification are the same as those of an already
 * published notification, the new notification will replace the original one, achieving a notification update
 * effect.
 *
 * @param { NotificationRequest } request - Content and related configuration of the notification to publish.
 * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the operation is successful,
 *     **err** is **undefined**; otherwise, **err** is an error object.
 * @throws { BusinessException } 1600001 - Internal error.
 * @throws { BusinessException } 1600002 - Marshalling or unmarshalling error.
 * @throws { BusinessException } 1600003 - Failed to connect to the service.
 * @throws { BusinessException } 1600004 - Notification disabled.
 * @throws { BusinessException } 1600005 - Notification slot disabled.
 * @throws { BusinessException } 1600007 - The notification does not exist.
 * @throws { BusinessException } 1600009 - The notification sending frequency reaches the upper limit.
 * @throws { BusinessException } 1600012 - No memory space.
 * @throws { BusinessException } 1600014 - No permission.
 * @throws { BusinessException } 1600015 - The current notification status does not support duplicate configurations.
 * @throws { BusinessException } 1600016 - The notification version for this update is too low.
 * @throws { BusinessException } 1600020 - The application is not allowed to send notifications due to permission
 *     settings.
 * @throws { BusinessException } 1600029 - The system failed to find the ExtensionAbility instance for the custom Live
 *     View widget template.
 * @throws { BusinessException } 2300007 - Network unreachable.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func publish(request: NotificationRequest, callback: AsyncCallback<Unit>): Unit {
    spawn {
        let cRequest = request.toCNotificationRequest()
        let code = unsafe { FfiOHOSNotificationManagerPublishV2(cRequest) }
        cRequest.free()
        if (code == SUCCESS_CODE) {
            callback(None, Some(()))
        } else {
            callback(Some(BusinessException(code, getErrorInfo(code))), None)
        }
    }
}

/**
 * Cancels all notifications of this application. This API uses an asynchronous callback to return the result.
 *
 * After cancellation, all notifications of the current application will be removed from the notification center,
 * status bar, and other locations, and will no longer be visible to the user. This is suitable for scenarios such as
 * application exit or when the user manually clears all notifications.
 *
 * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the operation is successful,
 *     **err** is **undefined**; otherwise, **err** is an error object.
 * @throws { BusinessException } 1600001 - Internal error.
 * @throws { BusinessException } 1600002 - Marshalling or unmarshalling error.
 * @throws { BusinessException } 1600003 - Failed to connect to the service.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func cancelAll(callback: AsyncCallback<Unit>): Unit {
    spawn {
        let code = unsafe { FfiOHOSNotificationManagerCancelAllV2() }
        if (code == SUCCESS_CODE) {
            callback(None, Some(()))
        } else {
            callback(Some(BusinessException(code, getErrorInfo(code))), None)
        }
    }
}

/**
 * Synchronously queries the notification authorization status of the current application.
 *
 * This API is used to quickly check whether the current application is allowed to send notifications before
 * publishing. It is synchronous and returns the result immediately after being called, suitable for scenarios where
 * the enabled status needs to be obtained in a synchronous code flow.
 *
 * @returns { Bool } Result of the notification enabling status. The value **true** means that the notification is
 *     enabled, and **false** means the opposite.
 * @throws { BusinessException } 1600001 - Internal error.
 * @throws { BusinessException } 1600002 - Marshalling or unmarshalling error.
 * @throws { BusinessException } 1600003 - Failed to connect to the service.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func isNotificationEnabledSync(): Bool {
    let cValue = unsafe { FfiOHOSNotificationManagerIsNotificationEnabledV2() }
    throwIfNotSuccess(cValue.code)
    return cValue.data
}

/**
 * Requests notification to be enabled for this application. You can call this API to display a dialog box prompting
 * the user to enable notification for your application before publishing a notification. This API uses an asynchronous
 * callback to return the result.
 *
 * This API can be called only after the application UI is loaded (that is, **loadContent** is successfully called).
 *
 * @param { UIAbilityContext } context - Ability context bound to the notification dialog box.
 * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the operation is successful,
 *     **err** is **undefined**; otherwise, **err** is an error object.
 * @throws { BusinessException } 1600001 - Internal error.
 * @throws { BusinessException } 1600002 - Marshalling or unmarshalling error.
 * @throws { BusinessException } 1600003 - Failed to connect to the service.
 * @throws { BusinessException } 1600004 - Notification disabled.
 * @throws { BusinessException } 1600013 - A notification dialog box is already displayed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func requestEnableNotification(context: UIAbilityContext, callback: AsyncCallback<Unit>): Unit {
    spawn {
        let code = unsafe { FfiOHOSNotificationManagerRequestEnableNotificationWithContextV2(context.getID()) }
        if (code == SUCCESS_CODE) {
            callback(None, Some(()))
        } else {
            callback(Some(BusinessException(code, getErrorInfo(code))), None)
        }
    }
}

/**
 * Sets the notification badge number. This API uses an asynchronous callback to return the result.
 *
 * A badge is a numeric identifier displayed in the upper right corner of an application's desktop icon, used to
 * prompt the user about the number of unprocessed notifications. After setting, the desktop icon will display the
 * corresponding badge number. This is suitable for scenarios where the number of pending messages needs to be
 * prompted on the desktop icon, such as the number of unread messages and to-do items.
 *
 * This API can be properly called on devices other than wearables. If it is called on wearables, error code 801 is
 * returned.
 *
 * @param { Int32 } badgeNumber - Notification badge number to set. If **badgeNumber** is set to a value less than or
 *     equal to **0**, badges are cleared; if the value is greater than **99**, **99+** is displayed on the badge.
 * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the operation is successful,
 *     **err** is **undefined**; otherwise, **err** is an error object.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 1600001 - Internal error.
 * @throws { BusinessException } 1600002 - Marshalling or unmarshalling error.
 * @throws { BusinessException } 1600003 - Failed to connect to the service.
 * @throws { BusinessException } 1600012 - No memory space.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Notification.Notification",
    throwexception: true
]
public func setBadgeNumber(badgeNumber: Int32, callback: AsyncCallback<Unit>): Unit {
    spawn {
        let code = unsafe { FfiOHOSNotificationManagerSetBadgeNumberV2(badgeNumber) }
        if (code == SUCCESS_CODE) {
            callback(None, Some(()))
        } else {
            callback(Some(BusinessException(code, getErrorInfo(code))), None)
        }
    }
}
