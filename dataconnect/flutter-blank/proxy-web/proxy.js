const express = require("express");
const { createProxyMiddleware } = require("http-proxy-middleware");

const EXT_PORT = 9002;
const FLUTTER_PORT = 9003;
const DATACONNECT_PORT = 9400;
const app = express();

app.use(
  createProxyMiddleware({
    target: `http://localhost:${FLUTTER_PORT}`,
    router: {
      [`/v1beta`]: `http://localhost:${DATACONNECT_PORT}`, // API on 8081 should support /api/* paths
    },
  })
);

app.listen(EXT_PORT, () => {
  console.log(`
    ====Firebase Data Connect Proxy Server========
    ====Please DO NOT CLOSE=======================
  `);
  console.log(
    "Proxy Server Listening on: " +
    EXT_PORT
  );
  console.log(`
    ==============================================
  `);
});