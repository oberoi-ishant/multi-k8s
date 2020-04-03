import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

/* Removing the test as it attempts to load the Fib component which
attemps to make a request to express server which is not running. */
it('renders without crashing', () => {
  // const div = document.createElement('div');
  // ReactDOM.render(<App />, div);
  // ReactDOM.unmountComponentAtNode(div);
});
