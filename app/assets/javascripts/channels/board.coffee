App.board = App.cable.subscriptions.create "BoardChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if $('.is-searching').length == 0
      identifier = '.boards-list div.board-'+data['slug']
      if data['action'] == 'add-board'
        $('.count-of-boards').html(data['count_of_boards'])
        $('.boards-list').prepend(data['content'])
        $(identifier).fadeOut 1000, ->
          $(identifier).fadeIn 1000
          return
      else if data['action'] == 'remove-board'
        $('.count-of-boards').html(data['count_of_boards'])
        $(identifier).fadeOut 1000, ->
          $(this).remove()
          return
        return
