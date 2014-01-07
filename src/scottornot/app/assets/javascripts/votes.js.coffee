# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



jQuery ($) ->
  $('form#voting-form').on "ajax:success", (e, data, status, xhr) =>
    old_hero_src = $('#hero').attr('src')
    $('#prior-hero').attr('src', old_hero_src)

    $( "body" ).data('prior-percentage', data.prior_percentage)

    $('#hero').attr('src', data.picture.url)
    $('#picture_id').val(data.picture.id)
