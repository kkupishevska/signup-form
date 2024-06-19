import React, { useState } from 'react';

import { HideIcon, ShowIcon } from '../icons';

import '../../theme/index.css';

enum PasswordHintsLabels {
  CASE = 'Uppercase and lowercase letters',
  LENGTH = '8-64 characters (no spaces)',
  DIGIT = 'At least one digit',
}

export type PasswordErrors = {
  length: boolean | null;
  digit: boolean | null;
  case: boolean | null;
};

type FormState = {
  email: string;
  password: string;
};

const SignUpForm = () => {
  const [formState, setFormState] = useState<FormState>({
    password: '',
    email: '',
  });
  const [isFormSubmitted, setFormSubmitted] = useState(false);
  const [emailValid, setEmailValid] = useState(false);
  const [showText, setShowText] = useState(false);
  const passwordValid = React.useMemo(
    () => ({
      case:
        /[A-Z]/.test(formState.password) && /[a-z]/.test(formState.password),
      length: formState.password.length >= 8 && formState.password.length <= 64,
      digit: /[0-9]/.test(formState.password),
    }),
    [formState.password]
  );

  const handleInputChange = ({
    target,
  }: React.ChangeEvent<HTMLInputElement>) => {
    setFormSubmitted(false);
    const { value, name } = target;
    setFormState((prevState) => ({ ...prevState, [name]: value }));
    if (name === 'email') setEmailValid(validateEmail(value));
  };

  const validateEmail = (email: string) => {
    return /\S+@\S+\.\S+/.test(email);
  };

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setFormSubmitted(true);
    if (
      emailValid &&
      passwordValid.length &&
      passwordValid.case &&
      passwordValid.digit
    ) {
      console.log('Form submitted');
    } else {
      console.log('Form validation failed');
    }
  };

  return (
    <div className='wrapper'>
      <form onSubmit={handleSubmit} className='form'>
        <div>
          <h1>Sign up</h1>
        </div>
        <div className='container'>
          <div className='form-input'>
            <input
              className={`input ${
                emailValid && isFormSubmitted && 'input-success'
              } ${isFormSubmitted && 'input-error'}`}
              onChange={handleInputChange}
              placeholder='Enter email'
              value={formState.email}
              name="email"
            />
          </div>
          <div className='form-input'>
            <input
              type={showText ? 'text' : 'password'}
              onChange={handleInputChange}
              value={formState.password}
              className={`input ${
                passwordValid.length &&
                passwordValid.case &&
                passwordValid.digit &&
                isFormSubmitted &&
                'input-success'
              } ${isFormSubmitted && 'input-error'}`}
              placeholder='Enter your password'
              name="password"
            />
            <div
              className='icon'
              onClick={() => setShowText((prevState) => !prevState)}
            >
              {showText ? <HideIcon /> : <ShowIcon />}
            </div>
          </div>
          <div className='password-hints'>
            <span className={passwordValid.length ? 'hint-green' : ''}>
              {PasswordHintsLabels.LENGTH}
            </span>
            <span className={passwordValid.case ? 'hint-green' : ''}>
              {PasswordHintsLabels.CASE}
            </span>
            <span className={passwordValid.digit ? 'hint-green' : ''}>
              {PasswordHintsLabels.DIGIT}
            </span>
          </div>
        </div>
        <button type='submit'>Sign Up</button>
      </form>
    </div>
  );
};

export default SignUpForm;
