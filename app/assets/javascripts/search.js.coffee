delay = (ms, func) -> setTimeout func, ms
delayed_submit = (initial_value, input_handle, input_form) ->
  input_value = $(input_handle).val()
  $(input_form).submit() if input_value == initial_value

$ ->
  $('#site_search').keyup (e) ->
    input_value = $(@).val()
    delay 700, ->
      delayed_submit(input_value, '#site_search', '#new_site')

