(function () {
  $('.forecasts.new').ready(function () {
    var $searchEl = $('.city-and-country');
    var $form = $searchEl.closest('form');

    var sourceFunction = function (query, sync, asynq) {
      var service = new google.maps.places.AutocompleteService();
      if (query.trim() !== '') {
        service.getPlacePredictions({
          input: query,
          types: ['(cities)']
        }, function (predictions, status) {
          if (status === google.maps.places.PlacesServiceStatus.OK) {
            asynq(predictions);
          } else {
            asynq([]);
          }
        });
      }
    };

    var geocodeByPlaceId = function (placeID) {
      var geocoder = new google.maps.Geocoder();
      var deffered = $.Deferred();
      geocoder.geocode({'placeId': placeID}, function (results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
          var locLat = results[0].geometry.location.lat();
          var locLng = results[0].geometry.location.lng();
          deffered.resolve([locLat, locLng]);
        } else {
          deffered.reject();
        }
      });
      return deffered.promise();
    };

    var submitData = function (e, place) {
      var country = place.structured_formatting.secondary_text.split(',').pop().trim();
      var city = place.structured_formatting.main_text.trim();
      if (country != '' && city != '') {
        var $input = $('.city-and-country');
        $('#forecast_country').val(country);
        $('#forecast_name').val(city);
        geocodeByPlaceId(place.place_id).done(function (coords) {
          $input.attr('disabled', 'disabled');
          $('#forecast_lat').val(coords[0]);
          $('#forecast_lng').val(coords[1]);
          $('form').unbind('submit').submit();
        }).fail(function () {
          $input.removeAttr('disabled');
          $.growl.error({
            message: 'Something went wrong. Please search city again and select from the list.',
            location: 'bl'
          });
        });
      } else {
        $.growl.notice({message: 'Please specify correct country', location: 'bl'});
      }
    };

    $searchEl.on('click', function (e) {
      $searchEl.typeahead('open');
    });

    $searchEl.typeahead({
      hint: false,
      highlight: true,
      minLength: 0
    }, {
      display: 'description',
      limit: 12,
      async: true,
      name: 'weather',
      source: sourceFunction,
      templates: {
        suggestion: function (data) {
          var suggestions = data.description.split(',');
          var country = suggestions.pop();
          return '<div class="tt-suggestion tt-selectable"><strong class="tt-highlight">' + suggestions.join(' ') + '</strong> ' + country + '</div>';
        }
      }
    });


    $searchEl.on('typeahead:selected', submitData);

    $form.on('submit', function (e) {
      e.preventDefault();
    });
  });

})();

