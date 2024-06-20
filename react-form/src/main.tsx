import React from 'react'
import ReactDOM from 'react-dom/client'
import SignUpForm from './components/SignupForm'
// import SignupReactHookForm from './components/SignupReactHookForm'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <SignUpForm />
    {/* <SignupReactHookForm /> */}
  </React.StrictMode>,
)
