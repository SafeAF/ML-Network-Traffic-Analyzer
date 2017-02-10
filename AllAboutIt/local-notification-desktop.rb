






}



def notify

  system('gdbus call "${NOTIFY_ARGS[@]}"  --method org.freedesktop.Notifications.Notify \
          "$APP_NAME" "$REPLACE_ID" "$ICON" "$SUMMARY" "$BODY" \
          [] "$(concat_hints "${HINTS[@]}")" "int32 $EXPIRE_TIME" | handle_ouput')

end

def notify_close(*args) ## fix the param issues
  gdbus call "${NOTIFY_ARGS[@]}"  --method org.freedesktop.Notifications.CloseNotification "$1" >/dev/null
