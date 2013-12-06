class window.Player extends Backbone.Model

  defaults:
    name: 'Player'
    dealer: false
    winner: false
    scores: [0]
    hand: []

  initialize: ->
    @get('hand').on 'add', @_updateScore, @

  _updateScore: ->
    score = @get('hand').scores()
    if score[2]
    @set('scores', score)