// This page is server rendered
import Email from "./Email.client"
import { listInbox, ListInboxResponse } from '@email-app/email'
import dataConnect from "@/data-connect";
import fakeEmails from './fake-emails'

export default async function Home() {
	/**
	 * Change the uid value to see emails from different users. Stay tuned for an update that will combine Data Connect with Firebase Auth!
	 * 
	 * ==> uids from the data seed: user_david, user_tyler, user_bleigh, user_jeanine
	 */
	const uid = "user_tyler"

	/**
	 * This is the URL needed to configure the reverse proxy so that all requests are sent through the Next.js server and we can avoid CORS issues from the local Data Connect emulator server. If this code is being executed on the server we only need localhost.
	 */
	const host = process.env.WEB_HOST!
	const dc = dataConnect('localhost');

	let emails: ListInboxResponse['emails'] = [];
	try {
		const { data } = await listInbox(dc, { uid })
		emails = data.emails
	} catch(e) {
		console.error(e)
		emails = fakeEmails
	}

	if(emails.length === 0) {
	/**
	 * If there are no emails there is either an issue with Data Connect or
	 * the database is empty. Instead we'll create a fake email with
	 * instructions on how to get started.
	 */
		emails = fakeEmails
	}

	const firstEmail = emails.at(0)!;

	return (
		<Email 
			initialEmails={emails}
			firstEmail={firstEmail}
			uid={uid}
			host={host}
		 />
	);
}
