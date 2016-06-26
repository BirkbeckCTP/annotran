Annotator = require('annotator')
$ = Annotator.$
xpathRange = Annotator.Range

RangeAnchor = require('../../../../../../h/h/static/scripts/annotator/anchoring/types').RangeAnchor
FragmentAnchor = require('../../../../../../h/h/static/scripts/annotator/anchoring/types').FragmentAnchor
TextPositionAnchor = require('../../../../../../h/h/static/scripts/annotator/anchoring/types').TextPositionAnchor
TextQuoteAnchor = require('../../../../../../h/h/static/scripts/annotator/anchoring/types').TextQuoteAnchor


# This plugin implements the UI code for selecting sentences by clicking
module.exports = class SentenceSelection extends Annotator.Plugin

  pluginInit: ->
    # Register the event handlers required for creating a selection
    $(document).bind({
      "click": @makeSentenceSelection
    })

    null

  destroy: ->
    $(document).unbind({
      "click": @makeSentenceSelection
    })
    super

  # This is called when the mouse is clicked on a DOM element.
  # Checks to see if there is a sentence that we can select, if so
  # calls Annotator's onSuccessfulSelection method.
  #
  # event - The event triggered this. Usually it's a click Event
  #
  # Returns nothing.
  makeSentenceSelection: (event = {}) =>
    # Get the currently selected ranges.

    desiredText = event.target.innerText || event.target.textContent
    desiredText = desiredText.split('.')[0]

    range = document.createRange()
    range.selectNodeContents(event.target)

    selector = new Selector_Class(event.target, event.target, 0, desiredText.length)

    data = {
      start: event.target
      startOffset: 0
      end: event.target
      endOffset: desiredText.length
      commonAncestor: event.target
      commonAncestorContainer: event.target
      startContainer: event.target
      endContainer: event.target
    }

    anchor = new xpathRange.BrowserRange(data).normalize(event.target.parent)

    alert(typeof anchor)

    #new_range = new RangeAnchor(event.target, anchor)

    window.getSelection().removeAllRanges()
    window.getSelection().addRange(anchor.toRange())

class Selector_Class
  constructor: (startC, endC, startO, endO) ->
    @startContainer = -> startC
    @endContainer = -> endC
    @startOffset = -> startO
    @endOffset = -> endO
