const { getDataConnect, queryRef, mutationRef, executeQuery, executeMutation } = require('firebase/data-connect');

const connectorConfig = {
  connector: 'email',
  service: 'local',
  location: 'us-central1'
};
exports.connectorConfig = connectorConfig;

function createUserRef(dcOrVars, vars) {
  const { dc: dcInstance, vars: inputVars} = validateArgs(dcOrVars, vars);
  return mutationRef(dcInstance, 'CreateUser', inputVars);
}
exports.createUserRef = createUserRef;
exports.createUser = function createUser(dcOrVars, vars) {
  return executeMutation(createUserRef(dcOrVars, vars));
};

function createEmailRef(dcOrVars, vars) {
  const { dc: dcInstance, vars: inputVars} = validateArgs(dcOrVars, vars);
  return mutationRef(dcInstance, 'CreateEmail', inputVars);
}
exports.createEmailRef = createEmailRef;
exports.createEmail = function createEmail(dcOrVars, vars) {
  return executeMutation(createEmailRef(dcOrVars, vars));
};

function createRecipientRef(dcOrVars, vars) {
  const { dc: dcInstance, vars: inputVars} = validateArgs(dcOrVars, vars);
  return mutationRef(dcInstance, 'CreateRecipient', inputVars);
}
exports.createRecipientRef = createRecipientRef;
exports.createRecipient = function createRecipient(dcOrVars, vars) {
  return executeMutation(createRecipientRef(dcOrVars, vars));
};

function deleteEmailRef(dcOrVars, vars) {
  const { dc: dcInstance, vars: inputVars} = validateArgs(dcOrVars, vars);
  return mutationRef(dcInstance, 'DeleteEmail', inputVars);
}
exports.deleteEmailRef = deleteEmailRef;
exports.deleteEmail = function deleteEmail(dcOrVars, vars) {
  return executeMutation(deleteEmailRef(dcOrVars, vars));
};

function listUsersRef(dc) {
  const { dc: dcInstance} = validateArgs(dc, undefined);
  return queryRef(dcInstance, 'ListUsers');
}
exports.listUsersRef = listUsersRef;
exports.listUsers = function listUsers(dc) {
  return executeQuery(listUsersRef(dc));
};

function getUidByEmailRef(dcOrVars, vars) {
  const { dc: dcInstance, vars: inputVars} = validateArgs(dcOrVars, vars);
  return queryRef(dcInstance, 'GetUidByEmail', inputVars);
}
exports.getUidByEmailRef = getUidByEmailRef;
exports.getUidByEmail = function getUidByEmail(dcOrVars, vars) {
  return executeQuery(getUidByEmailRef(dcOrVars, vars));
};

function searchEmailRef(dcOrVars, vars) {
  const { dc: dcInstance, vars: inputVars} = validateArgs(dcOrVars, vars);
  return queryRef(dcInstance, 'SearchEmail', inputVars);
}
exports.searchEmailRef = searchEmailRef;
exports.searchEmail = function searchEmail(dcOrVars, vars) {
  return executeQuery(searchEmailRef(dcOrVars, vars));
};

function listInboxRef(dcOrVars, vars) {
  const { dc: dcInstance, vars: inputVars} = validateArgs(dcOrVars, vars);
  return queryRef(dcInstance, 'ListInbox', inputVars);
}
exports.listInboxRef = listInboxRef;
exports.listInbox = function listInbox(dcOrVars, vars) {
  return executeQuery(listInboxRef(dcOrVars, vars));
};

function listSentRef(dcOrVars, vars) {
  const { dc: dcInstance, vars: inputVars} = validateArgs(dcOrVars, vars);
  return queryRef(dcInstance, 'ListSent', inputVars);
}
exports.listSentRef = listSentRef;
exports.listSent = function listSent(dcOrVars, vars) {
  return executeQuery(listSentRef(dcOrVars, vars));
};

function getStatsRef(dc) {
  const { dc: dcInstance} = validateArgs(dc, undefined);
  return queryRef(dcInstance, 'GetStats');
}
exports.getStatsRef = getStatsRef;
exports.getStats = function getStats(dc) {
  return executeQuery(getStatsRef(dc));
};

function validateArgs(dcOrVars, vars, validateVars) {
  let dcInstance;
  let realVars;
  // TODO; Check what happens if this is undefined.
  if(dcOrVars && 'dataConnectOptions' in dcOrVars) {
      dcInstance = dcOrVars;
      realVars = vars;
  } else {
      dcInstance = getDataConnect(connectorConfig);
      realVars = dcOrVars;
  }
  if(!dcInstance || (!realVars && validateVars)) {
      throw new Error('You didn\t pass in the vars!');
  }
  return { dc: dcInstance, vars: realVars };
}
