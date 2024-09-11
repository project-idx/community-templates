const { getDataConnect, validateArgs } = require('firebase/data-connect');

const connectorConfig = {
  connector: 'default',
  service: 'my-service',
  location: 'asia-east1'
};
exports.connectorConfig = connectorConfig;

