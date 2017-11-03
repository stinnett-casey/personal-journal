# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

onCtrlEnter = (e, func) ->
  func() if (e.ctrlKey || e.metaKey) && (e.keyCode == 13 || e.keyCode == 10)

$(document).on 'turbolinks:load', ->
  $('#new-entry textarea').keydown (e) ->
    onCtrlEnter e, ->
      $('#submit-entry').click()
      $(this).blur()

  $(".entry-text").blur ->
    console.log 'it worked'
  .keydown (e) ->
    onCtrlEnter e, ->
      console.log 'will save'

  $('.entry .edit').click ->
    # $entry_text = $(this).closest('.entry').find('.entry-text')
    # $entry_text.attr('contenteditable', true).trigger('focus')
    # cursorManager.setEndOfContenteditable($entry_text[0]);
    $title = $(this).closest('.entry').find('.title')
    $content = $(this).closest('.entry').find('.entry-text')
    $(this).closest('.entry').append("""
      <form id="current-edit" action="/entries" data-remote="true" method="post">
        <div class="input-field">
          <input id="current-edit-title" type="text" name="entry[title]">
          <label for="entry_title">Title</label>
        </div>
        <div class="input-field">
          <textarea id="current-edit-content" class="materialize-textarea" name="entry[entry]"></textarea>
          <label for="entry_entry">Entry</label>
        </div>
      </form>
    """)
    $('#current-edit-title').val $title.text()
    $('#current-edit-content').val($content.text()).focus()
    Materialize.updateTextFields()
    $title.hide()
    $content.hide()

  $(document).on 'keydown', '#current-edit-content', (e) ->
    $elem = $(this)
    onCtrlEnter e, ->
      $title = $elem.closest('.entry').find('.title')
      $content = $elem.closest('.entry').find('.entry-text')

      $content.html($elem.val().replace(/\r?\n/g, '<br/>')).show()
    