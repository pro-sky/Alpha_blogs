$(document).on 'turbolinks:load', ->
  userId = window.current_user_id
  console.log "current user", userId

  App.direct_message = App.cable.subscriptions.create { channel: "DirectMessageChannel", user_id: userId },
    connected: ->
      console.log "Connected to DirectMessageChannel"
      # Called when the subscription is ready for use on the server

    disconnected: ->
      console.log "Disconnected from DirectMessageChannel"
      # Called when the subscription has been terminated by the server

    received: (data) ->
      console.log "Received data:", data
      $('#messages').append data.message

