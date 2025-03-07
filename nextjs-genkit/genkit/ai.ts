import { googleAI } from "@genkit-ai/googleai";
import { genkit } from 'genkit';
import { logger } from 'genkit/logging'

export const ai = genkit({
    plugins: [googleAI()],
    promptDir: './genkit/prompts',
});

logger.setLogLevel('debug');

export const recipiePrompt = ai.prompt('generateRecipe');