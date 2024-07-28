import { initializeApp } from 'firebase/app';
import { getDataConnect, connectDataConnectEmulator } from 'firebase/data-connect'
import { connectorConfig } from '@email-app/email'

export default (host: string = 'localhost') => {
	// Note: When connecting to a prod instance, please replace the empty config with your firebase config provided in the console.
	const firebaseApp = initializeApp({ });
	const dataConnect = getDataConnect(firebaseApp, connectorConfig)
	const isBrowser = typeof process !== 'undefined' && process.browser;

	if(dataConnect.isEmulator) {
		return dataConnect;
	}
	// If this is running on the client then tell Data Connect to use
	// the reverse proxy to send requests.
	// Note: This is only needed when running in a Cloud Editor
	if (isBrowser) {
		connectDataConnectEmulator(
			dataConnect, 
			`9000-${host}`, 
			undefined, 
			true
		);	
	} else {
		// It is always 'localhost' on the server
		connectDataConnectEmulator(
			dataConnect, 
			'localhost', 
			9399, 
			false
		);
	}
	return dataConnect;
};