#!/usr/bin/python
# -*- coding: utf8 -*-
import sublime
import sublime_plugin

class FullPitchWhiteSpaceHighlightListener(sublime_plugin.EventListener):
    # highlight full-pitch white spaces
    def highlight_fullpitch_spaces(self, view):
        view.add_regions('FullPitchWhiteSpaceHighlight',
                         view.find_all(u'　+'),
                         "invalid",
                         sublime.DRAW_EMPTY_AS_OVERWRITE)
    # Called after changes have been made to a view.
    # @override
    def on_modified(self, view):
        self.highlight_fullpitch_spaces(view)

    # Called when a view gains input focus.
    # @override
    def on_activated(self, view):
        self.highlight_fullpitch_spaces(view)

    # Called when the file is finished loading.
    # @override
    def on_load(self, view):
        self.highlight_fullpitch_spaces(view)
