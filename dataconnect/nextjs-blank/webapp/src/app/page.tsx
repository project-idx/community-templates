import dataConnect from "@/data-connect"
import ClientComponent from "./components/ClientComponent";

export default function Home() {
  const host = process.env.WEB_HOST!
  // This is a server component. The function below
  // will set up data connect to work on the server here in IDX
	const dc = dataConnect()

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h2>Hello, Data Connect!</h2>
      <ClientComponent host={host} />
    </main>
  );
}
