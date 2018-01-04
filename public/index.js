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
        { apiName: "BBC Sport", displayName: "BBC Sport", checked: false },
        { apiName: "BBC Sport", displayName: "BBC Sport", checked: true },
        { apiName: "BBC Sport", displayName: "BBC Sport", checked: false },
        { apiName: "BBC Sport", displayName: "BBC Sport", checked: false },
        { apiName: "BBC Sport", displayName: "BBC Sport", checked: false },
        { apiName: "BBC Sport", displayName: "BBC Sport", checked: false }
      ],
      team: [],
      errors: []
    };
  },
  created: function() {
    axios.get("/v1/teams/" + this.$route.params.id).then(
      function(response) {
        this.team = response.data;
      }.bind(this)
    );

    // axios.get("v1/news_sources").then(
    //   function(response) {
    //     this.apiSources;
    //   }.bind(this)
    // );
  },
  methods: {
    apiSourceChanged: function(apiSource) {
      var params = {
        api_name: apiSource.apiName,
        display_name: apiSource.displayName,
        team_id: this.$route.params.id
      };
      if (apiSource.checked) {
        console.log("hello", params);
        axios
          .post("/v1/news_sources", params)
          .then(function(response) {})
          .catch(
            function(error) {
              this.errors = error.response.data.errors;
            }.bind(this)
          );
        console.log("did it work?");
      } else {
        console.log("goodbye", params);
        axios
          .delete("/v1/news_source_by_name", params)
          .then(function(response) {})
          .catch(
            function(error) {
              this.errors = error.response.data.errors;
            }.bind(this)
          );
        console.log("did it get removed?");
      }
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
  ]
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
