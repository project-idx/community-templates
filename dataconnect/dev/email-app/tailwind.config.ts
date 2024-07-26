import type {Config} from "tailwindcss";
const colors = require("tailwindcss/colors");

const config: Config = {
	content: [
		"./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
		"./src/components/**/*.{js,ts,jsx,tsx,mdx}",
		"./src/app/**/*.{js,ts,jsx,tsx,mdx}",
	],
	theme: {
		fontFamily: {
			sans: ["Google Sans", "sans-serif"],
			display: ["Google Sans Display", "sans-serif"],
		},
		extend: {
			colors: {
				gray: {...colors.neutral},
				"google-blue": "#4285F4",
				"google-green": "#34A853",
				"google-yellow": "#FBBC05",
				"google-red": "#EA4335",
			},transitionTimingFunction: {
        'custom-out': 'cubic-bezier(0, 0.52, 0.17, 0.96)',
        'custom-in': 'cubic-bezier(0.7, 0.1, 0.9, 0.47)',
				'm-ease': 'cubic-bezier(0.86, 0, 0.07, 1)'
      },
		},
	},
	plugins: [],
};
export default config;
