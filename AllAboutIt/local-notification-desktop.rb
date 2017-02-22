#!/usr/bin/ruby
# @Author: SJK
# @Date:   2016-09-15 00:13:49
# @Last Modified by:   Samuel Kerr
# @Last Modified time: 2016-09-17 18:43:23

require 'libnotify'
require 'rb-inotify'
require 'rubygems'
require 'redis'
require 'json'
$SYSTEMSTACK0 = '10.0.1.75'
$logpubsubhub = 'hub:logsub'
$alerthub = 'hub:alerts'


$redis = Redis.new({host: $SYSTEMSTACK0, port: 6379, db: 1})

$redis.subscribe($alerthub) do |on|
  on.message do |channel, msg|
    data = JSON.parse(msg)

    p "#{Time.now.to_s}:#{channel}: Received #{data}"




    n = Libnotify.new do |notify|
      notify.summary    = data.slice(0..15)
      notify.body       = data
      notify.timeout    = 5         # 1.5 (s), 1000 (ms), "2", nil, false
      notify.urgency    = :critical #msg[:urgency] ? msg[:urgency].to_sym : :critical   # :low, :normal, :critical
      notify.append     = false       # default true - append onto existing notification
      notify.transient  = true        # default false - keep the notifications around after display
      notify.icon_path  = "/usr/share/icons/gnome/scalable/emblems/emblem-default.svg"
    end

    n.show!



def notify

  system('gdbus call "${NOTIFY_ARGS[@]}"  --method org.freedesktop.Notifications.Notify \
          "$APP_NAME" "$REPLACE_ID" "$ICON" "$SUMMARY" "$BODY" \
          [] "$(concat_hints "${HINTS[@]}")" "int32 $EXPIRE_TIME" | handle_ouput')

end

def notify_close(*args) ## fix the param issues
  gdbus call "${NOTIFY_ARGS[@]}"  --method org.freedesktop.Notifications.CloseNotification "$1" >/dev/null
