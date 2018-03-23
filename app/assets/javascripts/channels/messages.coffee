App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    room_id = $("#chat-box").data("room-id")
    @check_in(room_id)

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    posts = $(".message-row").length
    if posts == 10
      $(".message-row").first().remove()

    $("#chat-box").append(data)
    $("#message-field").val('')


  check_in: (room_id) ->
    if room_id
      @perform 'check_in', room_id: room_id
    else
      @perform 'check_out'
