# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#new-entry textarea').keydown (e) ->
    if (e.ctrlKey || e.metaKey) && (e.keyCode == 13 || e.keyCode == 10)
      $('#submit-entry').click()
      $(this).blur()
    