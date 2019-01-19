#!/usr/bin/env python

import os, gi
gi.require_version('Nautilus', '3.0')
from gi.repository import GObject, Nautilus, Gtk, Gio, GLib

def ok():
  app = Gtk.Application.get_default()
  app.set_accels_for_action('view.rename', ['<control>Return', 'F2'])
  app.set_accels_for_action('view.open-with-default-application', ['Return', 'KP_Enter', '<control>o', '<alt>Down'])
  app.set_accels_for_action('view.open-item-new-tab', ['<shift>Return', '<control><shift>o'])
  app.set_accels_for_action('view.open-item-new-window', ['<control><shift>Return'])
  app.set_accels_for_action('view.move-to-trash', ['Delete', 'KP_Delete', '<control>BackSpace'])

class Shortcuts(GObject.GObject, Nautilus.LocationWidgetProvider):
  def __init__(self):
    pass

  def get_widget(self, uri, window):
    ok()
    return None
