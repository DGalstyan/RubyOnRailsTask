$('.forecasts.index ').ready(function () {
  $('.delete-forecast').on('click', function (e) {
    e.preventDefault();
    var $button = $(e.currentTarget);
    var url = '/forecasts/' + $button.data('forecast-id') + '.json';
    $.ajax({
      url: url,
      method: 'DELETE',
      contentType: 'application/json'
    }).done(function () {
      $button.closest('.weather-widget').remove();
      $.growl.notice({message: 'Forecast successfuly removed', location: 'bl'});
    }).fail(function () {
      $.growl.warning({message: 'Forecast can\'t be removed', location: 'bl'});
    })
  });

});