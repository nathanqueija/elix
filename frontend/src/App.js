import React, { Component } from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import Header from "./components/Header";
import Footer from "./components/Footer";
import Home from "./pages/Home";
import Search from "./pages/Search";
import Place from "./pages/Place";
import MyBookings from "./pages/MyBookings";
import Signup from "./pages/Signup";
import SignupRest from "./pages/SignupRest";
import Signin from "./pages/Signin";
import NotFound from "./pages/NotFound";

class App extends Component {
  render() {
    return (
      <BrowserRouter>
        <div id="app">
          <Header />
          <div id="content">
            <Switch>
              <Route path="/" exact component={Home} />
              <Route path="/places" exact component={Search} />
              <Route path="/places/:slug" component={Place} />
              <Route path="/bookings" component={MyBookings} />
              <Route path="/sign-up" component={Signup} />
              <Route path="/sign-up-rest" component={SignupRest} />
              <Route path="/sign-in" component={Signin} />
              <Route component={NotFound} />
            </Switch>
          </div>
          <Footer />
        </div>
      </BrowserRouter>
    );
  }
}

export default App;
