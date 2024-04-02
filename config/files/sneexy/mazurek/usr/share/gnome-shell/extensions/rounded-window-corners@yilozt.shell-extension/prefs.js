import Gtk      from 'gi://Gtk'
import Gdk      from 'gi://Gdk'
import Adw      from 'gi://Adw'

import { connections } from './utils/connections.js'
import { init_settings, uninit_settings } from './utils/settings.js'
import { pages } from './preferences/index.js'
import { _log } from './utils/log.js'
import * as Utils from './utils/io.js'
import { ExtensionPreferences } from 'resource:///org/gnome/Shell/Extensions/js/extensions/prefs.js'

export default class RoundedWindowCornresPrefs extends ExtensionPreferences {
  constructor (metadata) {
    super (metadata)

    // Classical GTK4 template ui need this to make translatable string works
    imports.gettext.textdomain (this.uuid)
    this.initTranslations (this.uuid)
  }

  _load_css () {
    const display = Gdk.Display.get_default ()
    if (display) {
      const css = new Gtk.CssProvider ()
      const path = Utils.path (import.meta.url, 'stylesheet-prefs.css')
      css.load_from_path (path)
      Gtk.StyleContext.add_provider_for_display (display, css, 0)
    }
  }

  fillPreferencesWindow (win) {
    init_settings (this.getSettings ())

    for (const page of pages ()) {
      const pref_page = new Adw.PreferencesPage ({
        title: page.title,
        icon_name: page.icon_name,
      })
      const group = new Adw.PreferencesGroup ()
      pref_page.add (group)
      group.add (page.widget)
      win.add (pref_page)
    }

    // Disconnect all signal when close prefs
    win.connect ('close-request', () => {
      _log ('Disconnect Signals')
      connections.get ().disconnect_all ()
      connections.del ()
      uninit_settings ()
    })

    this._load_css ()
  }
}
