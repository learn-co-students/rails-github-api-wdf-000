# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.ajax
  url: "https://api.github.com/users/ozPop/repos"
  dataType: "json"
  error: (jqXHR, textStatus, errorThrown) ->
    $('body').append "AJAX Error: #{textStatus}"
  success: (data, textStatus, jqXHR) ->
    for repo in data
      do ->
        $('.container').append "<div>#{repo.name}</div>"