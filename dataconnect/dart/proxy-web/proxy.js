const express = require("express");
const { createProxyMiddleware } = require("http-proxy-middleware");

const EXT_PORT = 9002;
const FLUTTER_PORT = 9003;
const DATACONNECT_PORT = 9399;
const app = express();

app.use(
  createProxyMiddleware({
    target: `http://localhost:${FLUTTER_PORT}`,
    router: {
      [`/v1alpha`]: `http://localhost:${DATACONNECT_PORT}`, // API on 8081 should support /api/* paths
    },
  })
);

app.listen(EXT_PORT, () => {
  console.log(
    "Server listening on: " +
    EXT_PORT
  );
  console.log(`open https://${EXT_PORT}-idx-dartgithubtest-1724277324997.cluster-lqnxvk7thvfw4wbonsercicksm.cloudworkstations.dev`);
});