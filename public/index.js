/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Your Home Page",
      teams: []
    };
  },
  created: function() {
    axios.get("/v1/teams").then(
      function(response) {
        this.teams = response.data;
        // this.teams.forEach(
        //   function(team) {
        //     axios.get("/v1/info?team_id=" + team.id).then(function(response) {
        //       team.info = response.data;
        //       console.log("team info: ", team.info);
        //     });
        //   }.bind(this)
        // );
        for (var i = 0; i < this.teams.length; i++) {
          let team = this.teams[i];
          axios.get("/v1/info?team_id=" + team.id).then(
            function(response) {
              Vue.set(team, "badgeUrl", response.data.teams[0].strTeamBadge);
              // team.info = response.data;
              // console.log("...", this.teams);
              // this.$forceUpdate();
            }.bind(this)
          );
        }
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var TeamsShowPage = {
  template: "#teams-show-page",
  data: function() {
    return {
      apiSources: [
        {
          apiName: "abc-news",
          displayName: "ABC News",
          checked: false
        },
        {
          apiName: "associated-press",
          displayName: "Associated Press",
          checked: false
        },
        { apiName: "bbc-sport", displayName: "BBC Sport", checked: false },
        { apiName: "bild", displayName: "Bild", checked: false },
        {
          apiName: "bleacher-report",
          displayName: "Bleacher Report",
          checked: false
        },
        { apiName: "espn", displayName: "ESPN", checked: false },
        {
          apiName: "four-four-two",
          displayName: "FourFourTwo",
          checked: false
        },
        { apiName: "fox-sports", displayName: "Fox Sports", checked: false },
        { apiName: "lequipe", displayName: "L'equipe", checked: false },
        { apiName: "marca", displayName: "Marca", checked: false },
        { apiName: "mirror", displayName: "Mirror", checked: false },
        { apiName: "nfl-news", displayName: "NFL News", checked: false },
        { apiName: "nhl-news", displayName: "NHL News", checked: false },
        { apiName: "talksport", displayName: "TalkSport", checked: false },
        {
          apiName: "the-guardian-uk",
          displayName: "The Guardian (UK)",
          checked: false
        },
        {
          apiName: "the-sport-bible",
          displayName: "The Sport Bible",
          checked: false
        },
        {
          apiName: "the-new-york-times",
          displayName: "The New York Times",
          checked: false
        },
        {
          apiName: "the-washington-post",
          displayName: "The Washington Post",
          checked: false
        }
      ],
      team: [],
      articles: [],
      errors: [],
      message: "Test"
    };
  },
  created: function() {
    axios.get("/v1/teams/" + this.$route.params.id).then(
      function(response) {
        this.team = response.data;
      }.bind(this)
    );

    axios.get("v1/news_sources?team_id=" + this.$route.params.id).then(
      function(response) {
        console.log(response.data);
        var newsSources = response.data;
        newsSources.forEach(
          function(newsSource) {
            this.apiSources.forEach(function(apiSource) {
              if (apiSource.apiName === newsSource.api_name) {
                apiSource.checked = true;
              }
            });
          }.bind(this)
        );
        this.getNews();
      }.bind(this)
    );
  },
  methods: {
    apiSourceChanged: function(apiSource) {
      var params = {
        api_name: apiSource.apiName,
        display_name: apiSource.displayName,
        team_id: this.$route.params.id
      };
      if (apiSource.checked) {
        axios
          .post("/v1/news_sources", params)
          .then(
            function(response) {
              this.getNews();
            }.bind(this)
          )
          .catch(
            function(error) {
              this.errors = error.response.data.errors;
            }.bind(this)
          );
      } else {
        console.log("goodbye", params);
        axios
          .delete("/v1/news_source_by_name", { params: params })
          .then(
            function(response) {
              this.getNews();
            }.bind(this)
          )
          .catch(
            function(error) {
              this.errors = error.response.data.errors;
            }.bind(this)
          );
      }
    },
    getNews: function() {
      axios.get("/v1/news_api?team_id=" + this.$route.params.id).then(
        function(response) {
          console.log(response.data);
          this.articles = response.data.articles.sort(
            (a, b) => new Date(b.publishedAt) - new Date(a.publishedAt)
          );
        }.bind(this)
      );
    }
  },
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/v1/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/teams/:id", component: TeamsShowPage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
