# describe "AppView", ->
#   deck = null
#   hand = null

#   beforeEach ->
#     deck = new Deck()
#     hand = deck.dealPlayer()

#   describe "When busted", ->
#     it "Bust should be true", ->
#       debugger;
#       spyOn(hand, "scores").andReturn([22])
#       hand.trigger('add')
#       expect(hand.bust).toEqual true