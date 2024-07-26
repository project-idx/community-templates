// Sidebar.client.tsx
import { ListInboxResponse } from '@email-app/email'

interface Props {
	emails: ListInboxResponse['emails'];
	selectedEmail: ListInboxResponse['emails'][number];
	setSelectedEmail: (email: ListInboxResponse['emails'][number]) => void;
	setIsComposeOpen: (isOpen: boolean) => void;
}

const Sidebar = ({emails, selectedEmail, setSelectedEmail, setIsComposeOpen}: Props) => {
	return (
		<aside className="flex flex-col">
			<header className="header-bar justify-between">
				{/* Mailbox selector */}
				<select
					name="screen-selector"
					className="appearance-none px-4 text-xl font-display font-medium outline-none"
				>
					<option value="inbox">Inbox</option>
					<option value="sent">Sent</option>
					<option value="trash">Trash</option>
				</select>

				{/* Compose button */}
				<button aria-label="Compose" className="button" onClick={() => setIsComposeOpen(true)}>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						viewBox="0 -960 960 960"
						className="w-5"
					>
						<path d="M200-120q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h357l-80 80H200v560h560v-278l80-80v358q0 33-23.5 56.5T760-120H200Zm280-360ZM360-360v-170l367-367q12-12 27-18t30-6q16 0 30.5 6t26.5 18l56 57q11 12 17 26.5t6 29.5q0 15-5.5 29.5T897-728L530-360H360Zm481-424-56-56 56 56ZM440-440h56l232-232-28-28-29-28-231 231v57Zm260-260-29-28 29 28 28 28-28-28Z" />
					</svg>
				</button>
			</header>
			<nav className="pt-4 px-2 flex flex-col flex-grow max-h-[553px]">
				<ul className="flex-grow overflow-y-auto pb-2">
					{emails.map((email) => (
						<li key={email.id}>
							<a
								href="#"
								className={`email-list-item ${
									selectedEmail.id.toString() === email.id ? "selected" : ""
								}`}
								onClick={(e) => {
									e.preventDefault();
									setSelectedEmail(email);
								}}
							>
								<div className="flex justify-between">
									<h2 className="text-sm font-medium mb-1 flex items-center gap-1">
										{email.sender.name}
									</h2>
									<time className="text-xs">{email.date}</time>
								</div>
								<p className="text-sm text-gray-700 line-clamp-2 mb-1">
									{email.subject}
								</p>
								<p className="text-xs text-gray-500 line-clamp-2 mb-1">
									{email.content.replace(/<[^>]*>/g, " ")}
								</p>
							</a>
						</li>
					))}
				</ul>
			</nav>
		</aside>
	);
};

export default Sidebar;
