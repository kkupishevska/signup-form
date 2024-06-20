import cs from 'classnames';

import Input from '../Input';

import { useForm } from '../../hooks/useForm';

import '../../theme/index.css';

enum PasswordHintsLabels {
  CASE = 'Uppercase and lowercase letters',
  LENGTH = '8-64 characters (no spaces)',
  DIGIT = 'At least one digit',
}

const SignUpForm = () => {
  const {formState, handleInputChange, isSubmitted, passwordValid, onSubmit} = useForm();

  return (
    <div className='wrapper'>
      <form onSubmit={onSubmit} className='form'>
        <div>
          <h1>Sign up</h1>
        </div>
        <div className='container'>
          <Input
            inputState={formState.email.inputState}
            value={formState.email.value}
            onChange={handleInputChange}
            placeholder='Enter email'
            name='email'
          />
          <Input
            inputState={formState.password.inputState}
            value={formState.password.value}
            placeholder='Enter your password'
            onChange={handleInputChange}
            name='password'
            type="password"
          />
          <div className='password-hints'>
            <span className={cs({'hint-green': passwordValid.length, 'hint-red': !passwordValid.length && isSubmitted})}>
              {PasswordHintsLabels.LENGTH}
            </span>
            <span className={cs({'hint-green': passwordValid.case, 'hint-red': !passwordValid.case && isSubmitted})}>
              {PasswordHintsLabels.CASE}
            </span>
            <span className={cs({'hint-green': passwordValid.digit, 'hint-red': !passwordValid.digit && isSubmitted})}>
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
