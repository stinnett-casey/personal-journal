# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

onCtrlEnter = (e, func) ->
  func() if (e.ctrlKey || e.metaKey) && (e.keyCode == 13 || e.keyCode == 10)

$(document).on 'turbolinks:load', ->
  # Allows for cmd + enter to submit form
  $(document).on 'keydown', '#new-entry textarea', (e) ->
    onCtrlEnter e, ->
      $('#submit-entry').click()
      $(this).blur()

  # Allows for cmd + enter to submit form
  $(document).on 'blur', '.entry-text', ->
    # save on blur
    console.log 'it worked'
  .keydown (e) ->
    onCtrlEnter e, ->
      console.log 'will save'

  # to edit an entry
  $(document).on 'click', '.entry .edit', ->
    if $('#current-edit').length == 0
      id = $(this).closest('.entry').attr('data-id') # get id of entry
      $title = $(this).closest('.entry').find('.title') # get title
      $content = $(this).closest('.entry').find('.entry-text') # get entry
      $(this).closest('.entry').append("""
        <form id="current-edit" action="/entries/#{id}" accept-charset="UTF-8" data-remote="true" method="post">
          <input name="utf8" type="hidden" value="✓">
          <input type="hidden" name="_method" value="patch">
          <div class="input-field">
            <input id="current-edit-title" type="text" name="entry[title]">
            <label for="entry_title" class="active">Title</label>
          </div>
          <div class="input-field">
            <textarea id="current-edit-content" class="materialize-textarea" name="entry[entry]"></textarea>
            <label for="entry_entry" class="active">Entry</label>
          </div>
          <div class="input-field">
            <input type="submit" name="commit" value="Save" class="btn btn-waves" id="submit-entry" data-disable-with="Save">
          </div>
        </form>
      """);
      $('#current-edit-title').val($title.text())
      $('#current-edit-content').val($content.text()).trigger('autoresize').focus()
      Materialize.updateTextFields()
      $title.hide()
      $content.hide()
    else
      $('#current-edit').find('#current-edit-content').focus()

  # to destroy en entry
  $(document).on 'ajax:success', '.entry .destroy', ->
    $(this).closest('.entry').slideUp 'slow', ->
      $(this).remove()


  $(document).on 'keydown', '#current-edit-content', (e) ->
    $elem = $(this)
    onCtrlEnter e, ->
      $('#current-edit').find('[type=submit]').click()
    