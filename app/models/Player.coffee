class window.Player extends Backbone.Model

  defaults:
    dealer: false
    winner: false
    scores: [0]
    hand: []

  initialize: ->
    @get('hand').on 'add', @_updateScore, @

  _updateScore: ->
    score = @get('hand').scores()
    @set('scores', score)