class window.AppView extends Backbone.View

  className: 'app-container'

  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="new-game">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game": -> @model.newGame()

  initialize: ->
    @render()
    @model.on 'all', @_displayResults, @
    @model.on 'newGame', @render, @


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  _displayResults: (event) ->
    switch event
      when 'dealer:win' then alert 'Dealer wins!'
      when 'player:win' then alert 'You win!'
      when 'push' then alert 'Push!'