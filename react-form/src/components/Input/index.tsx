import { InputHTMLAttributes, useState } from 'react';
import cs from 'classnames';

import { HideIcon, ShowIcon } from '../icons';
import { InputState } from './types';

import '../../theme/index.css';

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  showMessages?: boolean;
  inputState: InputState;
}

const Input = ({ type, inputState, ...props }: InputProps) => {
  const [inputType, setInputType] = useState(type);

  const toggleTextVisibility = () =>
    setInputType((prevState) =>
      prevState === 'password' ? 'text' : 'password'
    );

  return (
    <div>
      <div className='form-input'>
        <input
          {...props}
          type={inputType}
          className={cs('input', `input-${inputState}`)}
        />
        {type === 'password' && (
          <div className='icon' onClick={toggleTextVisibility}>
            {inputType === 'text' ? (
              <HideIcon fill={`var(--${inputState})`} />
            ) : (
              <ShowIcon fill={`var(--${inputState})`} />
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default Input;
