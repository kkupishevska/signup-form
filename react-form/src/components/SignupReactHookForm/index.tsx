import React from 'react';
import { valibotResolver } from '@hookform/resolvers/valibot';
import { useForm } from 'react-hook-form';
import * as v from 'valibot';
import { HideIcon, ShowIcon } from '../icons';
import '../../theme/index.css';

enum PasswordHintsLabels {
  CASE = 'Uppercase and lowercase letters',
  LENGTH = '8-64 characters (no spaces)',
  DIGIT = 'At least one digit',
}

const validationSchema = v.object({
  email: v.pipe(v.string(), v.email('Enter valid email')),
  password: v.pipe(
    v.string(),
    v.minLength(8, 'Password must have at least 8 characters'),
    v.maxLength(64, 'Password must not exceed 64 characters'),
    v.custom(
      // @ts-expect-error: Should expect string
      (value) => /[A-Z]/.test(value),
      'Password must contain at least one uppercase letter.'
    ),
    v.custom(
      // @ts-expect-error: Should expect string
      (value) => /[0-9]/.test(value),
      'Password must contain at least one number.'
    )
  ),
});

type FormValues = {
  password: string;
  email: string;
};

const SignupReactHookForm = () => {
  const {
    formState: { errors, isSubmitted },
    handleSubmit,
    setValue,
    register,
    watch,
  } = useForm<FormValues>({
    defaultValues: {
      password: '',
      email: '',
    },
    resolver: valibotResolver(validationSchema),
  });

  const [showText, setShowText] = React.useState(false);
  const [isTyping, setIsTyping] = React.useState(false);

  const onSubmit = (data: FormValues) => {
    console.log('Submitted data:', data);
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (isSubmitted) {
      setIsTyping(true);
    }
    setValue(e.target.name as 'password' | 'email', e.target.value);
  };

  const password = watch('password');

  return (
    <div className='wrapper'>
      <form onSubmit={handleSubmit(onSubmit)} className='form'>
        <div>
          <h1>Sign up</h1>
        </div>
        <div className='container'>
          <div className='form-wrapper'>
            <div className='form-input'>
              <input
                className={`input ${
                  errors.email && (isSubmitted || !isTyping) && 'input-error'
                } ${isSubmitted && !errors.email && 'input-success'}`}
                placeholder='Enter email'
                {...register('email')}
                onChange={handleInputChange}
              />
            </div>
            {!isTyping && errors.email && (
              <span className='error-message'>{errors.email.message}</span>
            )}
          </div>
          <div className='form-wrapper'>
            <div className='form-input'>
              <input
                className={`input ${
                  errors.password && (isSubmitted || !isTyping) && 'input-error'
                } ${isSubmitted && !errors.password && 'input-success'}`}
                type={showText ? 'text' : 'password'}
                placeholder='Enter your password'
                {...register('password')}
                onChange={handleInputChange}
              />
              <div
                onClick={() => setShowText((prevState) => !prevState)}
                className='icon'
              >
                {showText ? <HideIcon /> : <ShowIcon />}
              </div>
            </div>
            {!isTyping && errors.password && (
              <span className='error-message'>{errors.password.message}</span>
            )}
          </div>
          <div className='password-hints'>
            <span
              className={
                password.length >= 8 && password.length <= 64
                  ? 'hint-green'
                  : ''
              }
            >
              {PasswordHintsLabels.LENGTH}
            </span>
            <span
              className={
                /(?=.*[a-z])(?=.*[A-Z])/.test(password) ? 'hint-green' : ''
              }
            >
              {PasswordHintsLabels.CASE}
            </span>
            <span className={/(?=.*\d)/.test(password) ? 'hint-green' : ''}>
              {PasswordHintsLabels.DIGIT}
            </span>
          </div>
        </div>
        <button type='submit'>Sign Up</button>
      </form>
    </div>
  );
};

export default SignupReactHookForm;
