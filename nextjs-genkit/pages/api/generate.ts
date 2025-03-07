import type { NextApiRequest, NextApiResponse } from "next";
import * as fs from 'fs/promises';
import { recipiePrompt } from "@/genkit/ai";

type Data = {
    error: string;
};

export default async function handler(
    req: NextApiRequest,
    res: NextApiResponse<Data>,
) {
    const { image, userPrompt } = req.body;
    if (!image || !userPrompt) {
        return res.send({ error: 'Missing required fields' });
    }

    let imageUrl = `./public${image}`;
    const imageBase64 = await fs.readFile(imageUrl, { encoding: 'base64' });

    const result = await recipiePrompt({
        photoUrl: `data:image/jpeg;base64,${imageBase64}`,
        userPrompt: userPrompt
    });

    return res.send(result.output);
}
