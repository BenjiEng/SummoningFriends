//This class is contains the user interaction to create a new friend
//after making the external API call to Riot
// var friendsForm = new function () {
 var emptyFriend = {
    summoner_id: 0,
    summoner_name: "empty",
    summoner_icon_id: 0,
    revision_date: 0,
    summoner_level: 0,
    tier: "unranked"
  };


  var initNameListener = function(nameInput) {
    nameInput.focus(function () {
      if (nameInput.val() != "") {
        nameInput.val("");
      }
    })
  };

  //Changes the map on change of the dropdown selecter
  var initRegionListener = function (searchRegion, regionImage) {
      var self = this;
      searchRegion.change(function (){
        region = $(this).find(":selected").val();
        regionImage.html('<img src="/images/regions/'+region+'.png">"');
      });
  };

  //On click of submit button this method finds the elements needed for API call
  var findFriend = function () {
    var self = this;
    event.preventDefault();
    var region = $("#search-region").val().toLowerCase();
    var summonerName = $("#search-name").val();

    self.riotAPICall(region, summonerName);
  };

  //calls to the riotAPI and returns the summoner object or error
  var riotAPICall = function(region, summonerName) {

      $.ajax({
        name: summonerName.toLowerCase(),
        type: "GET",
        url: "https://"+region+".api.pvp.net/api/lol/"+region+"/v1.4/summoner/by-name/"+summonerName+"?api_key=5e9b0f51-4139-4c8a-bc4d-864cdefae73f",
        dataType: 'json',
        success: function(response) {
          var id = response[this.name].id;
          var name = response[this.name].name;
          var icon = response[this.name].profileIconId;
          var level = response[this.name].summonerLevel;
          var revision = response[this.name].revisionDate;

          $("#response-status").css({'color': 'green'}).html("We found your friend!").fadeIn(3000);
          $("#friend-name").html(name);
          $("#friend-level").html(level);
          $("#friend-icon").html('<img src="http://ddragon.leagueoflegends.com/cdn/6.10.1/img/profileicon/'+icon+'.png">');
          $(".add-friend").show();

          emptyFriend.summoner_id = id;
          emptyFriend.summoner_name = name;
          emptyFriend.summoner_icon_id = icon;
          emptyFriend.revision_date = revision
          emptyFriend.summoner_level = level;
          riotAPILeague(region, id);
        },
        error: function(response) {
          $("#response-status").css({'color':'red'}).html("Incorrect Summoner Name or Region.").fadeIn(3000);
        }
      });

  };

  //calls to Riot API to get the summoner's league tier
  var riotAPILeague = function(region, id) {

    $.ajax({
      type: "GET",
      url: "https://"+region+".api.pvp.net/api/lol/"+region+"/v2.5/league/by-summoner/"+id+"?api_key=5e9b0f51-4139-4c8a-bc4d-864cdefae73f",
      dataType: 'json',
      success: function(response) {
        var tier = response[id][0].tier
        emptyFriend.tier = tier;
        debugger
        $(".tier-icon").attr('id', tier);
      },
      error: function(response) {
        $("#response-status").css({'color':'red'}).html("Incorrect Summoner Name or Region.").fadeIn(3000).fadeOut(3000);
      }
    });
  }

  var riotAPICallLastGame = function(summonerId) {
    var self = this;
    var region = $("#search-region").find(":selected").val();

    $.ajax({
      type: "GET",
      url: "https://"+region+".api.pvp.net/api/lol/na/v1.3/game/by-summoner/"+summonerId+"/recent?api_key=5e9b0f51-4139-4c8a-bc4d-864cdefae73f",
      dataType: 'json',
      success: function(response) {
        debugger
        var lastGame = response.games[0];

        //need to create a new model
      },
      error: function(response) {
        debugger
        // $("#response-status").css({'color':'red'}).html("Incorrect Summoner Name or Region.").fadeIn(3000).fadeOut(3000);
      }
    });
  };


  //AJAX post to controller to add friend to database
  var addFriend = function() {
    var self = this;
    //new blank object to be populated with data from UI
    $.ajax({
      url: "/friends",
      type: "POST",
      data: {friend:
              {summoner_id: self.emptyFriend.summoner_id,
               summoner_name: self.emptyFriend.summoner_name,
               summoner_icon_id: self.emptyFriend.summoner_icon_id,
               summoner_level: self.emptyFriend.summoner_level,
               revision_date: self.emptyFriend.revision_date,
               tier: self.emptyFriend.tier,
               user_id: 0}
            },
      success: function (data) {
        $("#friends-list").html(data);
        riotAPICallLastGame(self.emptyFriend.summoner_id);
      },
      error: function (textStatus, errorThrown) {
        alert("error");
      }
    });
  };

  //calls the confirm delete
  var deleteFriend = function(id) {
    var deleteURL = "/friends/"+id;
    $.ajax({
      url: deleteURL,
      type: "DELETE",
      data: {id: id},
      success: function (data) {
        $("#friends-list").html(data);
        $('#deleteModal').modal('toggle');
      },
      error: function (textStatus, errorThrown) {
        alert("error");
      }
    })
  }
  // Resets the friend model upon sucessful save to the DB
  var resetFriendModel = function(emptyFriend) {
    emptyFriend.summoner_id = 0;
    emptyFriend.summoner_name = "";
    emptyFriend.summoner_icon_id = 0;
    emptyFriend.revision_date = 0;
    emptyFriend.summoner_level = 0;
    emptyFriend.tier = "";
  };

// };
