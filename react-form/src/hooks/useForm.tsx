import { useMemo, useState } from 'react';
import { InputState } from '../components/Input/types';

type SignupInputState = {
  inputState: InputState;
  value: string;
};

type PasswordErrors = {
  length: boolean | null;
  digit: boolean | null;
  case: boolean | null;
};

export const useForm = () => {
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [formState, setFormState] = useState<Record<string, SignupInputState>>({
    email: {
      inputState: InputState.initial,
      value: '',
    },
    password: {
      inputState: InputState.initial,
      value: '',
    },
  });

  const passwordValid = useMemo<PasswordErrors>(
    () => ({
      case:
        /[A-Z]/.test(formState.password.value) &&
        /[a-z]/.test(formState.password.value),
      length:
        formState.password.value.length >= 8 &&
        formState.password.value.length <= 64,
      digit: /[0-9]/.test(formState.password.value),
    }),
    [formState.password.value]
  );

  const validateEmail = (email: string) => {
    return /\S+@\S+\.\S+/.test(email);
  };


  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    const isValidEmail = validateEmail(formState.email.value);
    const isPasswordValid = Object.values(passwordValid).some((value) => value === true);

    setFormState((prevState) => ({
      email: {
        ...prevState.email,
        inputState: isValidEmail ? InputState.success : InputState.error,
      },
      password: {
        ...prevState.password,
        inputState: isPasswordValid ? InputState.success : InputState.error,
      },
    }));

    setIsSubmitted(true);
  };

  const handleInputChange = ({
    target,
  }: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = target;
    setIsSubmitted(false);
    setFormState((prevState) => ({
      ...prevState,
      [name]: { value, inputState: InputState.initial },
    }));
  };

  return {formState, passwordValid, isSubmitted, onSubmit, handleInputChange};
};
