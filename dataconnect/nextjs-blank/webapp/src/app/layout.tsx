import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Data Connect Blank App",
  description: "Build a new web app using Data Connect",
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
        <title>Data Connect Blank App</title>
        <link rel="icon" href="https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/favicon.ico" />
      </head>
      <body className={inter.className}>{children}</body>
    </html>
  );
}
