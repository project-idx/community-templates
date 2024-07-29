"use client";
import dataConnect from "@/data-connect"

export default function ClientComponent({ host }: { host: string }) {
  // This is a client component. The function below sets up Data Connect
  // to work on the client in IDX using a reverse proxy. This is because
  // each localhost process is run on a different domain so we funnel 
  // all requests to same domain to avoid CORS errors.
	const dc = dataConnect(host);
  return (
    <div>

    </div>
  )
}