# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
(($) ->
  $(window).load ->
    fetch_location = (pos) ->
      $.ajax(
        type: "get"
        url: "/projects/fetch"
        data:
          lat: pos.lat()
          lng: pos.lng()
      ).done (msg) ->
        alert "Project info: " + msg


    Gmaps.map.HandleDragend = (pos) ->
      fetch_location pos
      geocoder = new google.maps.Geocoder()
      geocoder.geocode
        latLng: pos
      , (responses) ->
        if responses and responses.length > 0
          alert "Project Address: " + responses[0].formatted_address
        else
          alert "Cannot determine address at this location."


    Gmaps.map.callback = ->
      i = 0

      while i < @markers.length
        google.maps.event.addListener Gmaps.map.markers[i].serviceObject, "click", ->
          Gmaps.map.HandleDragend @getPosition()

        ++i

    $ ->
      items1 = []
      items2 = []
      items3 = []
      items4 = []
      $("#myTable tr").each ->
        items1.push parseFloat($.trim($(this).find("td").eq(5).text()))
        items2.push parseFloat($.trim($(this).find("td").eq(6).text()))
        items3.push parseFloat($.trim($(this).find("td").eq(7).text()))
        items4.push parseFloat($.trim($(this).find("td").eq(8).text()))

      items1.splice 0, 1
      items2.splice 0, 1
      items3.splice 0, 1
      items4.splice 0, 1
      $("#charts").highcharts
        chart:
          type: "line"
          marginRight: 130
          marginBottom: 25

        legend:
          layout: "vertical"
          align: "right"
          verticalAlign: "top"
          x: -10
          y: 100
          borderWidth: 0

        series: [
          name: "Salinity"
          data: items1
        ,
          name: "Temperature"
          data: items2
        ,
          name: "Oxygen"
          data: items3
        ,
          name: "Saturation"
          data: items4
        ]



) jQuery
