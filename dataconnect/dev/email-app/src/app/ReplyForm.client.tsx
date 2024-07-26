"use client"; // This is a client component 👈🏽

import {SetStateAction, useState, useEffect} from "react";
import Spinner from "./Spinner";

const ReplyForm = () => {
	const [AIResponseLoading, setAIResponseLoading] = useState(false);
	const [textAreaValue, setTextAreaValue] = useState('');

  useEffect(() => {
		// setTimeout here to simulate AI response time
		const timer = setTimeout(() => {
			setAIResponseLoading(false);
		}, 3000); 

		return () => clearTimeout(timer);
	}, [AIResponseLoading]);


  const handleTextAreaChange = (event: { target: { style: { height: string; }; scrollHeight: number; value: SetStateAction<string>; }; }) => {
		let textAreaHeight = event.target.scrollHeight >= 64 ? event.target.scrollHeight : 42; 
		event.target.style.height = `${textAreaHeight}px`;
		setTextAreaValue(event.target.value);
	};

  const handleAIClick = (e: React.MouseEvent<HTMLButtonElement>) => {
		e.preventDefault();
		setAIResponseLoading(true);
	}

  return (
    <form className="flex flex-col mt-auto transition-transform duration-300 ease-in-out sticky bottom-0 bg-white pb-8 rounded-t">
      {/* Relpy Buttons Container */}
      <div className="overflow-hidden absolute right-0 bottom-[34px] z-10">

        <div className={`ml-auto flex gap-1
          transform transition-transform duration-300 ease-out
          ${textAreaValue !== '' ? '-translate-x-1' : 'translate-x-6'}
        `}>
          {/* Reply with AI Button */}
          <button 
            onClick={(e) => handleAIClick(e)}
            className="fill-gray-800 hover:fill-google-yellow transition duration-300 ease-out h-[34px] aspect-square p-2" 
            aria-label="Reply with AI"
          >
            {AIResponseLoading ? (
              <Spinner />
            ) :(
              // AI Charm Icon
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 512 512"
                className="w-4"
              >
                <path d="M384 64L320 96l64 32 32 64 32-64 64-32L448 64 416 0 384 64zM256 320l74.3-37.2L384 256l-53.7-26.8L256 192l-37.2-74.3L192 64l-26.8 53.7L128 192 53.7 229.2 0 256l53.7 26.8L128 320l37.2 74.3L192 448l26.8-53.7L256 320zm-64 20.7l-21.1-42.1-7.2-14.3-14.3-7.2L107.3 256l42.1-21.1 14.3-7.2 7.2-14.3L192 171.3l21.1 42.1 7.2 14.3 14.3 7.2L276.7 256l-42.1 21.1-14.3 7.2-7.2 14.3L192 340.7zM416 320l-32 64-64 32 64 32 32 64 32-64 64-32-64-32-32-64z" />
              </svg>
            )}
            
          </button>
          {/* Submit Button */}
          <button 
            type="submit" 
            className={`transition duration-300 ease-out disabled:fill-gray-400 pl-0 p-2
              hover:fill-google-blue
              ${textAreaValue === '' ? 'opacity-0' : 'opacity-100'}
            `}
            disabled={textAreaValue === ''}
            aria-label="Submit Reply"
          >
            <svg 
              xmlns="http://www.w3.org/2000/svg" 
              viewBox="0 -960 960 960"
              className='w-[18px]'
            >
              <path d="M120-160v-640l760 320-760 320Zm80-120 474-200-474-200v140l240 60-240 60v140Zm0 0v-400 400Z"/>
            </svg>
          </button>
        </div>
      </div>
      {/*  */}
      <textarea 
        className={`animated-border relative h-[42px] max-h-72 w-full rounded px-3 py-2 pr-16 resize-none 
          ${textAreaValue !== '' ? 'lock-animated-border' : ''}
        `}
        value={textAreaValue}
        onChange={handleTextAreaChange}
      />
    </form>
  )
}

export default ReplyForm;