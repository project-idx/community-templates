const HOST = Deno.env.get("HOST");
const PORT = Deno.env.get("PORT");

Deno.serve({ hostname: HOST, port: PORT }, async (req) => {
  console.log("Method:", req.method);

  const url = new URL(req.url);
  console.log("Path:", url.pathname);
  console.log("Query parameters:", url.searchParams);

  console.log("Headers:", req.headers);

  if (req.body) {
    const body = await req.text();
    console.log("Body:", body);
  }

  return new Response("Hello, World!", {
    status: 200,
    headers: {
      "Content-Type": "text/html"
    },
  });
});
