import React, { Component } from 'react';
import logo from './logo.png';
import fetch from 'isomorphic-fetch';
import './App.css';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      valueX: 1,
      valueY: 1,
      valueAns: 2
    };

    this.handleChange = this.handleChange.bind(this);
    this.fetchRest    = this.fetchRest.bind(this);
  }

  fetchRest() {
    var x = this.state.valueX;
    var y = this.state.valueY;
    var url = "../rest/add?x="+x+"&y="+y;
    fetch(url)
      .then(response => response.json())
      .then(data => {
        this.setState({"valueAns":data.result})
      })
  }

  handleChange(event) {
    let fieldName = event.target.name;
    let fieldVal = event.target.value;
    this.setState({[fieldName]: fieldVal});
  }
 
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
        </header>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
            <input name="valueX" value={this.state.valueX} onChange={this.handleChange} />
            +
            <input name="valueY" value={this.state.valueY} onChange={this.handleChange} />
            =            
            <input name="valueAns" value={this.state.valueAns} readOnly/>

            <button onClick={this.fetchRest} >Calculate</button>
      </div>
    );
  }
}

export default App;
