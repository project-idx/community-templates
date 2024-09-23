import type { Metadata } from "next";
import "./styles/globals.css";

export const metadata: Metadata = {
	title: "Email App",
	description: "A demo of Firebase Data Connect",
};

export default function RootLayout({
	children,
}: Readonly<{
	children: React.ReactNode;
}>) {
	return (
		<html lang="en">
			<head>
				<meta charSet="utf-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<title>Data Connect Email App</title>
				<link rel="icon" href="https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/favicon.ico" />
			</head>
			<body className="w-full">
				<div className="relative h-[600px] bg-white shadow-2xl grid grid-cols-3 overflow-hidden">
					{children}
				</div>
			</body>
		</html>
	);
}
