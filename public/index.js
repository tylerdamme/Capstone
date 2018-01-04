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
      team: []
    };
  },
  created: function() {
    axios.get("/v1/teams/" + this.$route.params.id).then(
      function(response) {
        this.team = response.data;
      }.bind(this)
    );
  },
  methods: {
    apiSourceChanged: function(apiSource) {
      if (apiSource.checked === true) {
        console.log("hello");
      } else if (apiSource.checked === false) {
        console.log("goodbye");
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
  router: router
});
