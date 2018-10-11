#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""Query the spotify client for currently playing

Help from http://stackoverflow.com/a/33923095/3213811

TODO can this be event driven rather than polled?
TODO volume control (C^upArrow, C^downArrow)

<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
                      "http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
<!-- GDBus 2.48.1 -->
<node>
  <interface name="org.freedesktop.DBus.Properties">
    <method name="Get">
      <arg type="s" name="interface_name" direction="in"/>
      <arg type="s" name="property_name" direction="in"/>
      <arg type="v" name="value" direction="out"/>
    </method>
    <method name="GetAll">
      <arg type="s" name="interface_name" direction="in"/>
      <arg type="a{sv}" name="properties" direction="out"/>
    </method>
    <method name="Set">
      <arg type="s" name="interface_name" direction="in"/>
      <arg type="s" name="property_name" direction="in"/>
      <arg type="v" name="value" direction="in"/>
    </method>
    <signal name="PropertiesChanged">
      <arg type="s" name="interface_name"/>
      <arg type="a{sv}" name="changed_properties"/>
      <arg type="as" name="invalidated_properties"/>
    </signal>
  </interface>
  <interface name="org.freedesktop.DBus.Introspectable">
    <method name="Introspect">
      <arg type="s" name="xml_data" direction="out"/>
    </method>
  </interface>
  <interface name="org.freedesktop.DBus.Peer">
    <method name="Ping"/>
    <method name="GetMachineId">
      <arg type="s" name="machine_uuid" direction="out"/>
    </method>
  </interface>
  <interface name="org.mpris.MediaPlayer2">
    <method name="Raise"/>
    <method name="Quit"/>
    <property type="b" name="CanQuit" access="read"/>
    <property type="b" name="CanRaise" access="read"/>
    <property type="b" name="HasTrackList" access="read"/>
    <property type="s" name="Identity" access="read"/>
    <property type="s" name="DesktopEntry" access="read"/>
    <property type="as" name="SupportedUriSchemes" access="read"/>
    <property type="as" name="SupportedMimeTypes" access="read"/>
  </interface>
  <interface name="org.mpris.MediaPlayer2.Player">
    <method name="Next"/>
    <method name="Previous"/>
    <method name="Pause"/>
    <method name="PlayPause"/>
    <method name="Stop"/>
    <method name="Play"/>
    <method name="Seek">
      <arg type="x" name="Offset" direction="in"/>
    </method>
    <method name="SetPosition">
      <arg type="o" name="TrackId" direction="in"/>
      <arg type="x" name="Position" direction="in"/>
    </method>
    <method name="OpenUri">
      <arg type="s" name="Uri" direction="in"/>
    </method>
    <signal name="Seeked">
      <arg type="x" name="Position"/>
    </signal>
    <property type="s" name="PlaybackStatus" access="read"/>
    <property type="s" name="LoopStatus" access="readwrite"/>
    <property type="d" name="Rate" access="readwrite"/>
    <property type="b" name="Shuffle" access="readwrite"/>
    <property type="a{sv}" name="Metadata" access="read"/>
    <property type="d" name="Volume" access="readwrite"/>
    <property type="x" name="Position" access="read"/>
    <property type="d" name="MinimumRate" access="read"/>
    <property type="d" name="MaximumRate" access="read"/>
    <property type="b" name="CanGoNext" access="read"/>
    <property type="b" name="CanGoPrevious" access="read"/>
    <property type="b" name="CanPlay" access="read"/>
    <property type="b" name="CanPause" access="read"/>
    <property type="b" name="CanSeek" access="read"/>
    <property type="b" name="CanControl" access="read"/>
  </interface>
</node>

"""

import dbus
import sys

def get_spotify_bus():
    session_bus = dbus.SessionBus()
    return session_bus.get_object("org.mpris.MediaPlayer2.spotify",
                                  "/org/mpris/MediaPlayer2")

def display():
    bus = get_spotify_bus()

    # Update properties
    properties = get_spotify_properties(bus)
    player_properties = properties.GetAll("org.mpris.MediaPlayer2.Player")
    metadata = player_properties['Metadata']
    playback_status = player_properties['PlaybackStatus']

    title = metadata['xesam:title']#.encode('utf-8')
    artists = ', '.join(metadata['xesam:artist'])#.encode('utf-8')
    status = '♪' if playback_status == 'Playing' else ' '
    print("{status} {title} - {artists}".format(**locals()))

def get_spotify_properties(bus):
    return dbus.Interface(bus, "org.freedesktop.DBus.Properties")

def control_player(action):
    bus = get_spotify_bus()

    player = get_player_proxy(bus)

    if action == 'ToggleStatus':
        properties = get_spotify_properties(bus)
        player_properties = properties.GetAll("org.mpris.MediaPlayer2.Player")
        playback_status = player_properties['PlaybackStatus']
        action = 'Play' if playback_status == 'Paused' else 'Pause'

    try:
        getattr(player, action)()
    except dbus.exceptions.DBusException:
        print("Unsupported action {}".format(action))

def get_player_proxy(bus):
    return dbus.Interface(bus, "org.mpris.MediaPlayer2.Player")

def main():
    if len(sys.argv) == 1:
        display()
    else:
        control_player(sys.argv[1])

if __name__ == '__main__':
    main()
