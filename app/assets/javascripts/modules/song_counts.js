//  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
//  hitobito_ejv and licensed under the Affero General Public License version 3
//  or later. See the COPYING file at the top-level directory or at
//  https://github.com/hitobito/hitobito_ejv.


var app;

app = window.App || (window.App = {});

app.SongCounts = {
  update: function(e) {
    var song;
    song = JSON.parse(e);
    if (song.id) {
      $("form.new_song_count :input[name='song_count[song_id]']").val(song.id);
      $("form.new_song_count").submit();
      song.label;
    } else {
      $('form#new_song').show().find('#song_title').focus();
    }
    return $(":input[data-updater='Songs.update']")[0].value = '';
  },
  add: function(e) {
    var exisiting_songs, song;
    song = JSON.parse(e);
    if (!song.id) {
      $('form#new_song').show().find('#song_title').focus();
      return;
    }
    exisiting_songs = $(`#song_counts_fields .song_id:input[value='${song.id}']`);
    if (exisiting_songs.length > 0) {
      app.SongCounts.incExistingCount(exisiting_songs[0]);
      return;
    }
    app.SongCounts.new(song);
    return $(":input[data-updater='SongCounts.add']")[0].value = '';
  },
  new: function(song) {
    var fields;
    $('.add_nested_fields').first().click(); // add new lineitem
    fields = $('#song_counts_fields .fields').last().find('input, label');
    fields.each(function(idx, elm) {
      var name;
      if (elm.name) {
        name = elm.name.match(/\d\]\[(.*)\]$/)[1];
        if (song[name]) {
          elm.value = song[name];
        }
        if (name === 'song_id') {
          return elm.value = song.id;
        }
      } else {
        return $(elm).append(song.label);
      }
    });
    fields = $('#song_counts_fields .fields').last();
    return app.SongCounts.highlight(fields);
  },
  incExistingCount: function(elm) {
    var fields;
    fields = $(elm).closest('.fields');
    fields.find('.inc_song_count').trigger('click');
    return app.SongCounts.highlight(fields);
  },
  highlight: function(elm) {
    elm.prependTo('#song_counts_fields');
    return elm.effect('highlight', {}, 3000);
  },
  inc: function(e) {
    return app.SongCounts.changeCount(e, +1);
  },
  dec: function(e) {
    return app.SongCounts.changeCount(e, -1);
  },
  changeCount: function(e, action) {
    var count, counter;
    counter = $(e.target).closest('.count').find('input');
    count = parseInt(counter.val());
    if (isNaN(count)) {
      count = 0;
    }
    counter.val(count + action);
    counter.trigger('change');
    return false;
  },
  validate: function(e) {
    var count, elm;
    elm = $(e.target);
    count = parseInt(elm.val());
    if (count > 30) {
      elm.val(30);
    }
    if (count < 0) {
      return elm.val(0);
    }
  }
};

$(document).on('click', '.inc_song_count', app.SongCounts.inc);
$(document).on('click', '.dec_song_count', app.SongCounts.dec);
$(document).on('change', '.count input', app.SongCounts.validate);
