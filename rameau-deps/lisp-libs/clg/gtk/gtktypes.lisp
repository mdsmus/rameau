;; Common Lisp bindings for GTK+ v2.x
;; Copyright 1999-2005 Espen S. Johnsen <espen@users.sf.net>
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;; $Id: gtktypes.lisp,v 1.65 2008/10/27 18:42:01 espen Exp $

(in-package "GTK")

(defclass requisition (boxed)
  ((width
    :allocation :alien
    :accessor requisition-width
    :initarg :width
    :type int)
   (height
    :allocation :alien
    :accessor requisition-height
    :initarg :height
    :type int))
  (:metaclass boxed-class))


(defclass allocation (struct)
  ((x
    :allocation :alien
    :accessor allocation-x
    :initarg :x
    :type int)
   (y
    :allocation :alien
    :accessor allocation-y
    :initarg :y
    :type int)
   (width
    :allocation :alien
    :accessor allocation-width
    :initarg :width
    :type int)
   (height
    :allocation :alien
    :accessor allocation-height
    :initarg :height
    :type int))
  (:metaclass struct-class))

(defclass border (boxed)
  ((left
    :allocation :alien
    :accessor border-left
    :initarg :left
    :type int)
   (right
    :allocation :alien
    :accessor border-right
    :initarg :right
    :type int)
   (top
    :allocation :alien
    :accessor border-top
    :initarg :top
    :type int)
   (bottom
    :allocation :alien
    :accessor border-bottom
    :initarg :bottom
    :type int))
  (:metaclass boxed-class))

(defclass stock-item (struct)
  ((id
    :allocation :alien
    :accessor stock-item-id
    :initarg :id
    :type string)
   (label
    :allocation :alien
    :accessor stock-item-label
    :initarg :label
    :type string)
   (modifier
    :allocation :alien
    :accessor stock-item-modifier
    :initarg :modifier
    :type gdk:modifier-type)
   (keyval
    :allocation :alien
    :accessor stock-item-keyval
    :initarg :keyval
    :type int)
   (translation-domain
    :allocation :alien
    :accessor stock-item-translation-domain
    :initarg :translation-domain
    :type string))
  (:metaclass struct-class)
  (:ref stock-item-copy)
  (:unref stock-item-free))

(defclass tree-iter (boxed)  
  ((stamp :allocation :alien :type int)
   (user-data :allocation :alien :type pointer)
   (user-data2 :allocation :alien :type pointer)
   (user-data3 :allocation :alien :type pointer))
  (:metaclass boxed-class))


;; (defclass tree-path (boxed)
;;   ((depth :allocation :alien :type int)
;;    (indices  :allocation :alien :type pointer))
;;   (:metaclass boxed-class))

(deftype tree-path () '(vector integer))
(register-type 'tree-path '|gtk_tree_path_get_type|)

(deftype position () 
  '(or int (enum (:start 0) (:end -1) (:first 0) (:last -1))))

(define-type-method from-alien-form ((type position) form &key ref)
  (declare (ignore type ref))
  (from-alien-form 'int form))

(define-type-method from-alien-function ((type position) &key ref)
  (declare (ignore type ref))
  (from-alien-function 'int))

(define-type-method reader-function ((type position) &optional ref)
  (declare (ignore type ref))
  (reader-function 'int))

(define-types-by-introspection "Gtk"
  ;; Manually defined
  ("GtkObject" :ignore t)
  ("GtkRequisition" :ignore t)
  ("GtkBorder" :ignore t)
  ("GtkTreeIter" :ignore t)
  ("GtkTreePath" :ignore t)
;  ("GtkStyle" :ignore t)

  ("GtkMountOperation" :ignore t) ; Needs GIO

  ;; Manual override
  ("GtkWidget"
   :slots
   ((child-properties
     :special t
     :accessor widget-child-properties
     :type container-child)
    (window
     :allocation :virtual
     :getter "gtk_widget_get_window"
     :reader widget-window
     :type gdk:window)
    (parent :merge t :initarg nil)
    (visible :merge t :initarg nil)
    (parent-window
     :allocation :virtual
     :getter %widget-parent-window
     :setter "gtk_widget_set_parent_window"
     :accessor widget-parent-window
     :initarg :parent-window
     :type gdk:window)
    (state
     :allocation :virtual
     :getter "gtk_widget_get_state"
     :setter "gtk_widget_set_state"
     :accessor widget-state
     :initarg :state
     :type state-type)
    (colormap
     :allocation :virtual
     :getter "gtk_widget_get_colormap"
     :setter "gtk_widget_set_colormap"
     :initarg :colormap
     :accessor widget-colormap
     :type gdk:colormap)
    (visual
     :allocation :virtual
     :getter "gtk_widget_get_visual"
     :reader widget-visual
     :type gdk:visual)
    (direction
     :allocation :virtual
     :getter "gtk_widget_get_direction"
     :setter "gtk_widget_set_direction"
     :accessor widget-direction
     :initarg :direction
     :type text-direction)
    (composite-name
     :allocation :virtual
     :getter "gtk_widget_get_composite_name"
     :setter "gtk_widget_set_composite_name"
     :accessor widget-composite-name
     :initarg :composite-name
     :type (copy-of string)) ; will leak the string when setting
    (settings
     :allocation :virtual
     :getter "gtk_widget_get_settings"
     :accessor widget-settings
     :type settings)
    (child-visible
     :allocation :virtual
     :getter "gtk_widget_get_child_visible"
     :setter "gtk_widget_set_child_visible"
     :accessor widget-child-visible-p
     :initarg :child-visible
     :type boolean)
    (width-request
     :merge t :unbound -1)
    (height-request
     :merge t :unbound -1)
    #?-(pkg-exists-p "gtk+-2.0" :atleast-version "2.12.0")
    (tooltip-window
     :allocation :virtual
     :getter "gtk_widget_get_tooltip_window"
     :setter "gtk_widget_set_tooltip_window"
     :accessor widget-tooltip-window
     :initarg :tooltip-window
     :type window)))
     
  ("GtkContainer"
   :slots
   ((child :ignore t)
    (children
     :allocation :virtual
     :setter (setf container-children)
     :getter "gtk_container_get_children"
     :reader container-children
     :type (glist (copy-of widget)))
    (internal-children ; for debugging
     :allocation :virtual
     :getter container-internal-children)
    (child-type
     :allocation :virtual
     :getter "gtk_container_child_type"
     :reader container-child-type
     :type gtype)
    (focus-child
     :allocation :virtual
     :getter "gtk_container_get_focus_child"
     :setter "gtk_container_set_focus_child"
     :accessor container-focus-child
     :initarg :focus-child
     :type widget)
    (focus-chain
     :allocation :virtual
     :getter container-focus-chain
     :setter (setf container-focus-chain))
    (focus-hadjustment
     :allocation :virtual
     :getter "gtk_container_get_focus_hadjustment"
     :setter "gtk_container_set_focus_hadjustment"
     :accessor container-focus-hadjustment
     :initarg :focus-hadjustment
     :type adjustment)
    (focus-vadjustment
     :allocation :virtual
     :getter "gtk_container_get_focus_vadjustment"
     :setter "gtk_container_set_focus_vadjustment"
     :accessor container-focus-vadjustment
     :initarg :focus-vadjustment
     :type adjustment)
    (reallocate-redraws
     :allocation :virtual
     :getter "gtk_container_get_reallocate_redraws"
     :setter "gtk_container_set_reallocate_redraws"
     :accessor container-reallocate-redraws
     :initarg :reallocate-redraws
     :type boolean)))
      
  ("GtkBin"
   :slots
   ((child
     :allocation :virtual
     :getter "gtk_bin_get_child"
     :setter (setf bin-child)
     :reader bin-child
     :type widget)))

  ("GtkWindow"
   :slots
   ((focus-widget
     :allocation :virtual
     :getter "gtk_window_get_focus"
     :setter "gtk_window_set_focus"
     :accessor window-focus-widget
     :initarg :focus-widget
     :type widget)
    (default-widget
     :allocation :virtual
     :getter "gtk_window_get_default"
     :setter "gtk_window_set_default"
     :accessor window-default-widget
     :initarg :default-widget
     :type widget)
    (has-frame
     :allocation :virtual
     :getter "gtk_window_get_has_frame"
     :setter "gtk_window_set_has_frame"
     :accessor window-has-frame-p
     :initarg :has-frame
     :type boolean)
    (icon-list
     :allocation :virtual
     :getter %window-get-icon-list
     :setter "gtk_window_set_icon_list"
     :accessor window-icon-list
     :initarg :icon-list
     :type (glist gdk:pixbuf))
    (mnemonic-modifier
     :allocation :virtual
     :getter "gtk_window_get_mnemonic_modifier"
     :setter "gtk_window_set_mnemonic_modifier"
     :accessor window-mnemonic-modifier
     :initarg :mnemonic-modifier
     :type gdk:modifier-type)
    #?-(pkg-exists-p "gtk+-2.0" :atleast-version "2.10.0")
    (transient-for
     :allocation :virtual
     :getter "gtk_window_get_transient_for"
     :setter "gtk_window_set_transient_for"
     :accessor window-transient-for
     :initarg :transient-for
     :type window)
    (group
     :allocation :virtual
     :getter "gtk_window_get_group"
     :setter (setf window-group)
     :reader window-group
     :initarg :group
     :type window-group)
    (default-width :merge t :unbound -1)
    (default-height :merge t :unbound -1)))
  
  ("GtkWindowGroup"
   :dependencies (window)
   :slots
   ((grabs
     :allocation :alien
     :accessor window-group-grabs
     :type (gslist window))))

  ("GtkTooltips"
   :slots
   ((enabled
     :allocation :virtual
     :getter "gtk_tooltips_get_enabled"
     :setter (setf tooltips-enabled-p)
     :reader tooltips-enabled-p
     :initarg :enabled
     :type boolean)))
  
  ("GtkMenuItem"
   :slots
   ((label
     :allocation :virtual
     :getter menu-item-label
     :setter (setf menu-item-label)
     :type string)
    (use-underline
     :allocation :user-data
     :initform nil
     :initarg :use-underline
     :accessor menu-item-use-underline-p)
    (right-justified
     :allocation :virtual
     :getter "gtk_menu_item_get_right_justified"
     :setter "gtk_menu_item_set_right_justified"
     :accessor menu-item-right-justified-p
     :initarg :right-justified
     :type boolean)
    #?-(pkg-exists-p "gtk+-2.0" :atleast-version "2.12.0")
    (submenu
     :allocation :virtual
     :getter "gtk_menu_item_get_submenu"
     :setter "gtk_menu_item_set_submenu"
     :accessor menu-item-submenu
     :initarg :submenu
     :type widget)))

  ("GtkMenuShell"
   :slots
   ((take-focus-p
     :allocation :virtual
     :getter "gtk_menu_shell_get_take_focus"
     :setter "gtk_menu_shell_set_take_focus"
     :accessor menu-shell-take-focus-p
     :type boolean)))

  ("GtkColorSelectionDialog"
   :slots
   ((colorsel
     :allocation :alien
     :reader color-selection-dialog-colorsel
     :type widget)
    (ok-button
     :allocation :alien
     :reader color-selection-dialog-ok-button
     :type widget)
    (cancel-button
     :allocation :alien
     :reader color-selection-dialog-cancel-button
     :type widget)
    (help-button
     :allocation :alien
     :reader color-selection-dialog-help-button
     :type widget)))

  ("GtkScrolledWindow"
   :slots
   (#?-(pkg-exists-p "gtk+-2.0" :atleast-version "2.8.0")
    (hscrollbar
     :allocation  :alien
     :reader scrolled-window-hscrollbar
     :type widget)
    #?-(pkg-exists-p "gtk+-2.0" :atleast-version "2.8.0")
    (vscrollbar
     :allocation :alien
     :reader scrolled-window-vscrollbar
     :type widget)
    #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.8.0")
    (hscrollbar
     :allocation :virtual
     :getter "gtk_scrolled_window_get_hscrollbar"
     :reader scrolled-window-hscrollbar
     :type widget)
    #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.8.0")
    (vscrollbar
     :allocation :virtual
     :getter "gtk_scrolled_window_get_vscrollbar"
     :reader scrolled-window-vscrollbar
     :type widget)))

  ("GtkPaned"
   :slots
   ((child1
    :allocation :virtual
    :getter "gtk_paned_get_child1"
    :setter "gtk_paned_add1"
    :accessor paned-child1
    :initarg :child1
    :type widget)
   (child2
    :allocation :virtual
    :getter "gtk_paned_get_child2"
    :setter "gtk_paned_add2"
    :accessor paned-child2
    :initarg :child2
    :type widget)))

  ("GtkMenu"
   :slots
   ((accel-group
     :allocation :virtual
     :getter "gtk_menu_get_accel_group"
     :setter "gtk_menu_set_accel_group"
     :accessor menu-accel-group
     :initarg :accel-group
     :type accel-group)
    (active
     :allocation :virtual
     :getter "gtk_menu_get_active"
     :setter (setf menu-active)
     :reader menu-active
     :initarg :active
     :type widget)
    (screen
     :allocation :virtual
     :getter "gtk_menu_get_screen"
     :setter "gtk_menu_set_screen"
     :accessor menu-screen
     :initarg :screen
     :type gdk:screen)
    (attach-widget
     :allocation :virtual
     :getter "gtk_menu_get_attach_widget"
     :reader menu-attach-widget
     :type widget)
    #?-(pkg-exists-p "gtk+-2.0" :atleast-version "2.6.0")
    (tearoff-state
     :allocation :virtual
     :getter "gtk_menu_get_tearoff_state"
     :setter "gtk_menu_set_tearoff_state"
     :accessor menu-tearoff-state-p
     :initarg :tearoff-state
     :type boolean)))

  ("GtkPlug"
   :slots
   ((id
     :allocation :virtual
     :getter "gtk_plug_get_id"
     :reader plug-id
     :type gdk:native-window)))

  ("GtkSocket"
   :slots
   ((id
     :allocation :virtual
     :getter "gtk_socket_get_id"
     :reader socket-id
     :type gdk:native-window)))

  ("GtkToolbar"
   :slots
   ((show-tooltips         ;; this slot is equivalent to the property
     :allocation :virtual  ;; "tooltips" in Gtk+ 2.8
     :getter "gtk_toolbar_get_tooltips"
     :setter "gtk_toolbar_set_tooltips"
     :accessor toolbar-show-tooltips-p
     :initarg :show-tooltips
     :type boolean)
    (tooltips
     :allocation :virtual
     :getter "gtk_toolbar_get_tooltips_object"
     :reader toolbar-tooltips
     :type tooltips)
    (toolbar-style ; defined manually to get the accesssor name correct
     :allocation :property
     :pname "toolbar-style"
     :initarg :toolbar-style
     :accessor toolbar-style
     :type toolbar-style)
    (n-items
     :allocation :virtual
     :getter "gtk_toolbar_get_n_items"
     :reader toolbar-n-items
     :type int)))

  ("GtkToolItem"
   :slots
   ((use-drag-window
     :allocation :virtual
     :getter "gtk_tool_item_get_use_drag_window"
     :setter "gtk_tool_item_set_use_drag_window"
     :accessor tool-item-use-drag-window-p
     :initarg :drag-window
     :type boolean)
    (tip-text 
     :allocation :user-data
     :setter (setf tool-item-tip-text)
     :initarg :tip-text
     :reader tool-item-tip-text)
    (tip-private
     :allocation :user-data
     :setter (setf tool-item-tip-private)
     :initarg :tip-private
     :reader tool-item-tip-private)))

  ("GtkToolButton"
   :slots
   ((stock-id :merge t :initarg :stock)
    (icon-widget :merge t :initarg :icon)))

  ("GtkToggleToolButton"
   :slots
   ((active
     :allocation :virtual
     :getter "gtk_toggle_tool_button_get_active"
     :setter "gtk_toggle_tool_button_set_active"
     :accessor toggle-tool-button-active-p
     :initarg :active
     :type boolean)))

  ("GtkRadioToolButton"
   :slots
   ((group
     :allocation :virtual
     :getter "gtk_radio_tool_button_get_group"
     :reader radio-tool-button-group
     :type (copy-of (gslist widget)))
    (value 
     :allocation :user-data
     :initarg :value
     :accessor radio-tool-button-value
     :documentation "Value passed as argument to the activate callback")))

  ("GtkNotebook"
   :slots
   ((current-page
     :allocation :virtual
     :getter %notebook-current-page
     :setter (setf notebook-current-page)
     :reader notebook-current-page
     :type widget
     :initarg :current-page)
    (current-page-num
     :allocation :virtual
     :getter "gtk_notebook_get_current_page"
     :setter "gtk_notebook_set_current_page"
     :unbound -1
     :initarg :current-page-num
     :accessor notebook-current-page-num
     :type position)))
  
  ("GtkRuler"
   :slots
   ((metric
     :allocation :virtual
     :getter "gtk_ruler_get_metric"
     :setter "gtk_ruler_set_metric"
     :accessor ruler-metric
     :initarg :metric
     :type metric-type)))

  ("GtkProgressBar"
   :slots
   ; deprecated properties
   ((bar-style :ignore t)
    (adjustment :ignore t)
    (activity-step :ignore t)
    (activity-blocks :ignore t)
    (discrete-blocks :ignore t)))

  ("GtkHandleBox"
   :slots
   ; deprecated property
   ((shadow :ignore t)))

  ("GtkFrame"
   :slots
   ; deprecated property
   ((shadow :ignore t)))

  ("GtkTable"
   :slots
   ((column-spacing
     :allocation :property :pname "column-spacing"
     :initarg :column-spacing
     :type unsigned-int)
    (row-spacing
     :allocation :property :pname "row-spacing"
     :initarg :row-spacing
     :type unsigned-int)))

  ("GtkDialog"
   :slots
   ((vbox
     :allocation :virtual
     :getter "gtk_dialog_get_vbox"
     :reader dialog-vbox
     :type widget)
    (action-area
     :allocation :virtual
     :getter "gtk_dialog_get_action_area"
     :reader dialog-action-area
     :type widget)))

  ("GtkEntry"
   :slots
   ((layout
     :allocation :virtual
     :getter "gtk_entry_get_layout"
     :reader entry-layout
     :type pango:layout)
    (completion
     :allocation :virtual
     :getter "gtk_entry_get_completion"
     :setter "gtk_entry_set_completion"
     :initarg :completion
     :accessor entry-completion
     :type entry-completion)
    (max-length :merge t :unbound 0)
    (alignment
     :allocation :virtual
     :getter "gtk_entry_get_alignment"
     :setter "gtk_entry_set_alignment"
     :initarg :alignment
     :accessor entry-alignment
     :type single-float)
    #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.6.0")
    (width-chars :merge t :unbound -1)
    #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.12.0")
    (cursor-adjustment
     :allocation :virtual
     :getter "gtk_entry_get_cursor_hadjustment"
     :setter "gtk_entry_set_cursor_hadjustment"
     :initarg :cursor-hadjustment
     :accessor entry-cursor-hadjustment
     :type adjustment)))

  ("GtkEntryCompletion"
   :slots
   ((entry
     :allocation :virtual
     :getter "gtk_entry_completion_get_entry"
     :reader entry-completion-entry
     :type entry)
    (minimum-key-length :merge t :unbound -1)
    ;; Need to be manually defined, as this value through the property
    ;; mechanism doesn't work
    #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.6.0")
    (text-column
     :allocation :virtual
     :getter "gtk_entry_completion_get_text_column"
     :setter "gtk_entry_completion_set_text_column"
     :unbound -1
     :accessor entry-completion-text-column
     :type int)))

  ("GtkRadioButton"
   :slots
   ((group
     :allocation :virtual
     :getter "gtk_radio_button_get_group"
     :reader radio-button-group
     :type (copy-of (gslist widget)))
    (value 
     :allocation :user-data
     :initarg :value
     :accessor radio-button-value
     :documentation "Value passed as argument to the activate callback")))

  ("GtkRadioMenuItem"
   :slots
   ((group
     :allocation :virtual
     :getter "gtk_radio_menu_item_get_group"
     :reader radio-menu-item-group
     :type (copy-of (gslist widget)))
    (value 
     :allocation :user-data
     :initarg :value
     :accessor radio-menu-item-value
     :documentation "Value passed as argument to the activate callback")))

  ("GtkLayout"
   :slots
   ((bin-window
     :allocation :virtual
     :getter "gtk_layout_get_bin_window"
     :reader layout-bin-window
     :type gdk:window)))

  ("GtkFixed"
   :slots
   ((has-window
     :allocation :virtual
     :getter "gtk_fixed_get_has_window"
     :setter "gtk_fixed_set_has_window"
     :reader fixed-has-window-p
     :initarg :has-window
     :type boolean)))

  ("GtkRange"
   :slots
   ((value
     :allocation :virtual
     :getter "gtk_range_get_value"
     :setter "gtk_range_set_value"
     :initarg :value
     :accessor range-value
     :type double-float)
   (upper
     :allocation :virtual
     :getter range-upper
     :setter (setf range-upper)
     :initarg :upper)
   (lower
     :allocation :virtual
     :getter range-lower
     :setter (setf range-lower)
     :initarg :lower)
   (step-increment
     :allocation :virtual
     :getter range-step-increment
     :setter (setf range-step-increment)
     :initarg :step-increment)
   (page-increment
     :allocation :virtual
     :getter range-page-increment
     :setter (setf range-page-increment)
     :initarg :page-increment)))

  ("GtkImage"
   :slots
   ((file :ignore t)
    #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.6.0")
    (pixel-size :merge t :unbound -1)))

  ("GtkLabel"
   :slots
   ((layout
     :allocation :virtual
     :getter "gtk_label_get_layout"
     :reader label-layout
     :type pango:layout)))

  ("GtkScale"
   :slots
   ((layout
     :allocation :virtual
     :getter "gtk_scale_get_layout"
     :reader scale-layout
     :type pango:layout)))

  ("GtkEditable"
   :slots
   ((editable
     :allocation :virtual
     :getter "gtk_editable_get_editable"
     :setter "gtk_editable_set_editable"
     :reader editable-editable-p
     :initarg :editable
     :type boolean)
    (position
     :allocation :virtual
     :getter "gtk_editable_get_position"
     :setter "gtk_editable_set_position"
     :reader editable-position
     :initarg :position
     :type position)
    (text
     :allocation :virtual
     :getter editable-text
     :setter (setf editable-text)
     :initarg text)))

  ("GtkFileChooser"
   :slots
   ((filename
     :allocation :virtual
     :getter "gtk_file_chooser_get_filename"
     :setter "gtk_file_chooser_set_filename"
     :accessor file-chooser-filename
     :initarg :filename
     :type string)
    (current-name
     :allocation :virtual
     :setter "gtk_file_chooser_set_current_name"
     :accessor file-chooser-current-name
     :initarg :current-name
     :type string)
    (current-folder
     :allocation :virtual
     :setter "gtk_file_chooser_set_current_folder"
     :getter "gtk_file_chooser_get_current_folder"
     :accessor file-chooser-current-folder
     :initarg :current-folder
     :type string)
    (uri
     :allocation :virtual
     :getter "gtk_file_chooser_get_uri"
     :setter "gtk_file_chooser_set_uri"
     :accessor file-chooser-uri
     :initarg :uri
     :type string)
    (current-folder-uri
     :allocation :virtual
     :setter "gtk_file_chooser_set_current_folder_uri"
     :getter "gtk_file_chooser_get_current_folder_uri"
     :accessor file-chooser-current-folder-uri
     :initarg :current-folder-uri
     :type string)))

  ("GtkFileFilter"
   :slots
   ((name
     :allocation :virtual
     :getter "gtk_file_filter_get_name"
     :setter "gtk_file_filter_set_name"
     :accessor file-filter-name
     :initarg :name
     :type string)))

  ("GtkTreeView"
   :slots
   ((columns
     :allocation :virtual
     :getter "gtk_tree_view_get_columns"
     :reader tree-view-columns 
     :type (glist (copy-of tree-view-column)))
    (selection
     :allocation :virtual
     :getter "gtk_tree_view_get_selection"
     :reader tree-view-selection
     :type tree-selection)))

  ("GtkTreeModel"
   :slots
   ((n-columns
     :allocation :virtual
     :getter "gtk_tree_model_get_n_columns"
     :reader tree-model-n-columns 
     :type int)))

  ("GtkTreeModelFilter"
   :slots
   ((virtual-root :merge t :type tree-path)))

  ("GtkTreeSelection"
   :slots
   ((mode
     :allocation :virtual
     :getter "gtk_tree_selection_get_mode"
     :setter "gtk_tree_selection_set_mode"
     :accessor tree-selection-mode
     :initarg :mode
     :type selection-mode)
    (tree-view
     :allocation :virtual
     :getter "gtk_tree_selection_get_tree_view"
     :reader tree-selection-tree-view
     :type tree-view)))

  ("GtkComboBox"
   :slots
   ((active-iter
     :allocation :virtual
     :getter "gtk_combo_box_get_active_iter"
     :setter "gtk_combo_box_set_active_iter"
     :accessor combo-box-active-iter 
     :type tree-iter)))

  ("GtkTextBuffer"
   :slots
   ((line-count
     :allocation :virtual
     :getter "gtk_text_buffer_get_line_count"
     :reader text-buffer-line-count
     :type int)
    (char-count
     :allocation :virtual
     :getter "gtk_text_buffer_get_char_count"
     :reader text-buffer-char-count
     :type int)
    (modified
     :allocation :virtual
     :getter "gtk_text_buffer_get_modified"
     :setter "gtk_text_buffer_set_modified"
     :accessor text-buffer-modifed-p
     :type boolean)))

  ("GtkTextView"
   :slots
   ((default-attributes
     :allocation :virtual
     :getter "gtk_text_view_get_default_attributes"
     :reader text-view-default-attributes
     :type text-attributes)))

  ("GtkTextTagTable"
   :slots
   ((size
     :allocation :virtual
     :getter "gtk_text_tag_table_get_size"
     :reader text-tag-table-size
     :type int)))

  ("GtkTextTag"
   :slots
   ((priority
     :allocation :virtual
     :getter "gtk_text_tag_get_priority"
     :setter "gtk_text_tag_set_priority"
     :accessor text-tag-priority
     :type int)
    (weight
     :merge t :type pango:weight)))

  ("GtkTextMark"
   :slots
   ((buffer
     :allocation :virtual
     :getter "gtk_text_mark_get_buffer"
     :reader text-mark-buffer
     :type text-buffer)
    (name
     :allocation :virtual
     :getter "gtk_text_mark_get_name"
     :reader text-mark-name
     :type (copy-of string))
    (visible
     :allocation :virtual
     :getter "gtk_text_mark_get_visible"
     :setter "gtk_text_mark_set_visible"
     :accessor text-mark-visible-p
     :type boolean)
    (deleted
     :allocation :virtual
     :getter "gtk_text_mark_get_deleted"
     :reader text-mark-deleted-p
     :type boolean)
    (left-gravity
     :allocation :virtual
     :getter "gtk_text_mark_get_left_gravity"
     :reader text-mark-left-gravity-p
     :type boolean)))

  ("GtkUIManager"
   :type ui-manager
   :slots
   ((action-groups
     :allocation :virtual
     :getter "gtk_ui_manager_get_action_groups"
     :reader ui-manager-action-groups
     :type (copy-of (glist action-group)))
    (accel-group
     :allocation :virtual
     :getter "gtk_ui_manager_get_accel_group"
     :reader ui-manager-accel-group
     :type accel-group)))

  ("GtkUIManagerItemType"
   :type ui-manager-item-type)

  ("GtkAction"
   :slots
   ((accelerator
     :allocation :user-data :initarg :accelerator 
     :reader action-accelerator)))

  #?-(pkg-exists-p "gtk+-2.0" :atleast-version "2.10.0")
  ("GtkToggleAction"
   :slots
   ((active
     :allocation :virtual
     :getter "gtk_toggle_action_get_active"
     :setter "gtk_toggle_action_set_active"
;     :initarg :active ;; Handled by initialize-instance
     :accessor toggle-action-active-p
     :type boolean)))

  ("GtkRadioAction"
   :slots
   ((group
     :allocation :virtual
     :getter "gtk_radio_button_get_group"
     :reader radio-action-group
     :type (copy-of (gslist widget)))
    (self
     :allocation :property :pname "value" :type int
     :documentation "A hack so we can use the alien function gtk_radio_action_get_current_value to retrieve the active radio action in a group.")
    (value 
     :allocation :user-data :initarg :value :accessor radio-action-value)
    #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.10.0")
    ;; Use radio-action-get-current-value to get the current value of
    ;; a radio action group
    (current-value :ignore t)))

  ("GtkColorSelection"
   :slots
   ((previous-alpha
     :allocation :virtual
     :getter "gtk_color_selection_get_previous_alpha"
     :setter "gtk_color_selection_set_previous_alpha"
     :initarg :previous-alpha
     :accessor color-selection-previous-alpha
     :type (unsigned 16))
    (previous-color
     :allocation :virtual
     :getter color-selection-previous-color
     :setter "gtk_color_selection_set_previous_color"
     :initarg :previous-color
     :writer (setf color-selection-previous-color)
     :type gdk:color)))

  ("GtkFontSelection"
   :slots
   ; deprecated property
   ((font :ignore t)))

  ("GtkClipboard"
   :slots
   ((display
     :allocation :virtual
     :getter "gtk_clipboard_get_display"
     :reader clipboard-display
     :type gdk:display)))

  #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.6.0")
  ("GtkIconView"
   :slots
   ((text-column
     :allocation :virtual
     :getter %icon-view-get-text-column
     :setter %icon-view-set-text-column
     :boundp %icon-view-text-column-boundp
     :initarg :text-column
     :accessor icon-view-text-column)
    (markup-column
     :allocation :virtual
     :getter %icon-view-get-markup-column
     :setter %icon-view-set-markup-column
     :boundp %icon-view-markup-column-boundp
     :initarg :markup-column
     :accessor icon-view-markup-column)
    (pixbuf-column
     :allocation :virtual
     :getter %icon-view-get-pixbuf-column
     :setter %icon-view-set-pixbuf-column
     :boundp %icon-view-pixbuf-column-boundp
     :initarg :pixbuf-column
     :accessor icon-view-pixbuf-column)))

  #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.10.0")
  ("GtkAssistant"
   :slots
   ((current-page 
     :allocation :virtual
     :getter "gtk_assistant_get_current_page"
     :setter "gtk_assistant_set_current_page"
     :accessor assistant-current-page
     :type int)
    (num-pages
     :allocation :virtual
     :getter "gtk_assistant_get_n_page"
     :reader assistant-current-page
     :type int)))

  #?(pkg-exists-p "gtk+-2.0" :atleast-version "2.10.0")
  ("GtkRecentChooser"
   :slots
   ((current-item
     :allocation :virtual
     :getter "gtk_recent_chooser_get_current_item"
     :reader recent-chooser-current-item
     :type recent-info)
    (current-uri
     :allocation :virtual
     :getter "gtk_recent_chooser_get_current_uri"
     :setter %recent-chooser-set-current-uri
     :accessor recent-chooser-current-uri
     :type string)))

  ;; Not needed
  ("GtkFundamentalType" :ignore t)
  ("GtkArgFlags" :ignore t)

  
  ;; Deprecated widgets
  ("GtkCList" :ignore-prefix t)
  ("GtkCTree" :ignore-prefix t)
  ("GtkList" :ignore t)
  ("GtkListItem" :ignore t)
  ("GtkTree" :ignore t)
  ("GtkTreeItem" :ignore t)
  ("GtkItemFactory" :ignore t)
  ("GtkText" :ignore t)
  ("GtkPacker" :ignore-prefix t)
  ("GtkPixmap" :ignore t)
  ("GtkPreview" :ignore-prefix t)
  ("GtkProgres" :ignore t)
  ("GtkTipsQuery" :ignore t)
  ("GtkOldEditable" :ignore t)
  ("GtkCombo" :ignore t)
  ("GtkOptionMenu" :ignore t)
  ("GtkFileSelection" :ignore t)
  ("GtkInputDialog")

  ;; What are these?
  ("GtkFileSystemModule" :ignore t)
  ("GtkIMModule" :ignore t)
  ("GtkThemeEngine" :ignore t))


(defclass text-iter (boxed)
  ((buffer
    :allocation :virtual
    :getter "gtk_text_iter_get_buffer"
    :reader text-iter-buffer
    :type pointer) ;text-buffer)
   (offset
    :allocation :virtual
    :getter "gtk_text_iter_get_offset"
    :setter "gtk_text_iter_set_offset"
    :accessor text-iter-offset
    :type int)
   (line
    :allocation :virtual
    :getter "gtk_text_iter_get_line"
    :setter "gtk_text_iter_set_line"
    :accessor text-iter-line
    :type int)
   (line-offset
    :allocation :virtual
    :getter "gtk_text_iter_get_line_offset"
    :setter "gtk_text_iter_set_line_offset"
    :accessor text-iter-line-offset
    :type int)
   (line-index
    :allocation :virtual
    :getter "gtk_text_iter_get_line_index"
    :setter "gtk_text_iter_set_line_index"
    :accessor text-iter-line-index
    :type int)
   (visible-line-index
    :allocation :virtual
    :getter "gtk_text_iter_get_visible_line_index"
    :setter "gtk_text_iter_set_visible_line_index"
    :accessor text-iter-visible-line-index
    :type int)
   (visible-line-offset
    :allocation :virtual
    :getter "gtk_text_iter_get_visible_line_offset"
    :setter "gtk_text_iter_set_visible_line_offset"
    :accessor text-iter-visible-line-offset
    :type int))
  (:metaclass boxed-class)
  (:size #.(* 14 (size-of 'pointer))))


(defclass tooltips-data (struct)
  ((tooltips
    :allocation :alien
    :reader tooltips-data-tooltips
    :type tooltips)
   (widget
    :allocation :alien
    :reader tooltips-data-widget
    :type widget)
   (tip-text
    :allocation :alien
    :reader tooltips-data-tip-text
    :type string)
   (tip-private
    :allocation :alien
    :reader tooltips-data-tip-private
    :type string))
  (:metaclass struct-class))

(defclass file-filter-info (struct)
  ((contains
    :allocation :alien 
    :initarg :contains
    :type file-filter-flags)
   (filename 
    :allocation :alien 
    :initarg :filename
    :type string)
   (uri 
    :allocation :alien 
    :initarg :uri
    :type string)
   (display-name 
    :allocation :alien 
    :initarg :display-name
    :type string)
   (mime-type 
    :allocation :alien 
    :initarg :mime-type
    :type string))
  (:metaclass struct-class))


(defclass accel-key (struct)
  ((key
    :allocation :alien
    :type unsigned-int)
   (modifiers
    :allocation :alien
    :type gdk:modifier-type)
   (flags
    :allocation :alien
    :type (unsigned 16)))
  (:metaclass struct-class))

(defclass accel-group-entry (struct)
  ((key
    :allocation :alien
    :setter nil
    :type (inlined accel-key))
   (gclosure
    :allocation :alien
    :type gclosure)
   (accel_path_quark
    :allocation :alien
    :type quark))
  (:metaclass struct-class))

#?(pkg-exists-p "gtk+-2.0" :atleast-version "2.8.0")
(define-enum-type drop-position
  :no-drop :drop-into :drop-left :drop-right :drop-above :drop-below)


(defclass target-entry (struct)
  ((target
    :allocation :alien
    :accessor target-entry-target
    :initarg :target
    :type string)
   (flags
    :allocation :alien
    :accessor target-entry-flags
    :initarg :flags
    :type target-flags)
   (id
    :allocation :alien
    :accessor target-entry-id
    :initarg :id
    :type unsigned-int))
  (:metaclass struct-class))


(defclass selection-data (boxed)
  ((selection
    :allocation :alien :type gdk:atom
    :reader selection-data-selection)
   (target
    :allocation :alien :type gdk:atom
    :reader selection-data-target)
   (type
    :allocation :alien :type gdk:atom
    :reader selection-data-type)
   (format 
    :allocation :alien :type int
    :reader selection-data-format)
   (data
    :allocation :alien :type pointer
    :reader selection-data-data)
   (length 
    :allocation :alien :type int
    :reader selection-data-length)
   (display 
    :allocation :alien :type gdk:display
    :reader selection-data-display))
  (:metaclass boxed-class))


#?-(pkg-exists-p "gtk+-2.0" :atleast-version "2.10.0")
(defclass target-list (proxy)
  ()
  (:metaclass proxy-class)
  (:ref target-list-ref)
  (:unref target-list-unref))

#?(pkg-exists-p "gtk+-2.0" :atleast-version "2.10.0")
(defclass target-list (boxed)
  ()
  (:metaclass boxed-class))
