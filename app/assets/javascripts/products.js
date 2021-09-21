$(document).on("turbolinks:load",function(){
  $('body').on('change', '.year_filter, .team_filter', function(){
    var year      = $('.year_filter').val();
    var team_name = $('.team_filter').val();

    $.ajax({
      url: '/',
      data: { year: year, team_name: team_name }
    })
  });
});
