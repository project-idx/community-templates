import Image from "next/image";
import { FormEvent, useCallback, useMemo, useState } from "react";
import markdownit from 'markdown-it';
import '../styles/home.css';

export default function Home() {
	const images = useMemo(() => {
		return [
			{
				src: "/images/baked_goods_1.jpeg",
				alt: "Blueberry Buckle",
			},
			{
				src: "/images/baked_goods_2.jpeg",
				alt: "Artisan Seeded Bread",
			},
			{
				src: "/images/baked_goods_3.jpeg",
				alt: "Red Velvet Cupcakes with Cream Cheese Frosting",
			},
		];
	}, []);

	const [tags, setTags] = useState<string[]>([]);
	const [output, setOutput] = useState('(Recipe will appear here)');
	const [chosenImage, setImage] = useState<string>(images[0].src);
	const [userPrompt, setPrompt] = useState<string>('Provide an example recipe for the baked goods in the image');

	const onSubmit = useCallback(async (ev: FormEvent<HTMLFormElement>) => {
		ev.preventDefault();
		setOutput("Generating...");
		setTags([]);
		await fetch("/api/generate", {
			method: "POST",
			body: JSON.stringify({
				userPrompt: userPrompt,
				image: chosenImage,
			}),
			headers: {
				'Content-Type': 'application/json',
				'Accept': 'application/json',
			},
		}).then(response => {
			return response.json();
		}).then(response => {
			const md = markdownit();
			setOutput(md.render(response.recipe));
			setTags(response.tags);
		}).catch(error => {
			console.error(error);
			setOutput(`Error: ${error}`);
			setTags([]);
		});
		return false;
	}, []);

	return (
		<main>
			<div className="api-key-banner">
				To get started with the Gemini API,
				<a href="https://g.co/ai/idxGetGeminiKey" target="_blank">
					get an API key</a> and set it in the <code>.idx/dev.nix</code> file
				<br></br>
				<br></br>
				Then rebuild the enviroment and delete this banner
			</div>

			<h1 className="title">Baking with Gemini</h1>
			<form onSubmit={onSubmit}>
				<div className="image-picker">
					{
						images.map((image, index) => {
							return (
								<label className="image-choice" key={index}>
									<input type="radio" name="chosenImage" value={image.src}
										onChange={() => setImage(image.src)}
										checked={chosenImage === image.src}
									/>
									<Image
										src={image.src} alt={image.alt}
										width={300} height={300}
									/>
								</label>
							)
						})
					}
				</div>
				<div className="prompt-box">
					<input name="prompt" placeholder="Enter instructions here" type="text"
						value={userPrompt}
						onChange={(ev) => {
							setPrompt(ev.target.value);
						}}
					/>
					<button type="submit">Go</button>
				</div>
			</form>
			<p className="output" dangerouslySetInnerHTML={{ __html: output }}>
			</p>
			<div className="tags">
				{
					tags.map((tag, index) => {
						return (
							<div className="tag" key={index}>{tag}</div>
						)
					})
				}
			</div>
		</main>
	);
}
