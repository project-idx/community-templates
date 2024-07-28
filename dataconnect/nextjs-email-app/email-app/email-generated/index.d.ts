import { ConnectorConfig, DataConnect, getDataConnect, QueryRef, MutationRef, QueryPromise, MutationPromise } from 'firebase/data-connect';
export const connectorConfig: ConnectorConfig;

export type TimestampString = string;

export type UUIDString = string;

export type Int64String = string;

export type DateString = string;


export interface CreateEmailResponse {
  email_insert: Email_Key;
}

export interface CreateEmailVariables {
  content?: string | null;
  subject?: string | null;
  fromUid?: string | null;
}

export interface CreateRecipientResponse {
  recipient_insert: Recipient_Key;
}

export interface CreateRecipientVariables {
  emailId?: UUIDString | null;
  uid?: string | null;
}

export interface CreateUserResponse {
  user_insert: User_Key;
}

export interface CreateUserVariables {
  uid?: string | null;
  name?: string | null;
  address?: string | null;
}

export interface DeleteEmailResponse {
  recipient_delete?: Recipient_Key | null;
}

export interface DeleteEmailVariables {
  emailId?: UUIDString | null;
  uid?: string | null;
}

export interface EmailMeta_Key {
  userUid: string;
  emailId: UUIDString;
  __typename?: 'EmailMeta_Key';
}

export interface Email_Key {
  id: UUIDString;
  __typename?: 'Email_Key';
}

export interface GetStatsResponse {
  emailStats:  ({
    
  count?: number | null;
  })[];
  
}

export interface GetUidByEmailResponse {
  users:  ({
    
  uid: string;
  email: string;
  } & User_Key)[];
  
}

export interface GetUidByEmailVariables {
  emails?: (string | null)[];
}

export interface ListInboxResponse {
  emails:  ({
    
  id: UUIDString;
  subject: string;
  date: DateString;
  content: string;
  sender:  {
    
  name: string;
  email: string;
  uid: string;
  } & User_Key;
  
  to:  ({
    
  user:  {
    
  name: string;
  email: string;
  uid: string;
  } & User_Key;
  
  })[];
  
  } & Email_Key)[];
  
}

export interface ListInboxVariables {
  uid?: string | null;
}

export interface ListSentResponse {
  emails:  ({
    
  id: UUIDString;
  subject: string;
  date: DateString;
  content: string;
  sender:  {
    
  name: string;
  email: string;
  uid: string;
  } & User_Key;
  
  to:  ({
    
  user:  {
    
  name: string;
  email: string;
  uid: string;
  } & User_Key;
  
  })[];
  
  } & Email_Key)[];
  
}

export interface ListSentVariables {
  uid?: string | null;
}

export interface ListUsersResponse {
  users:  ({
    
  uid: string;
  name: string;
  email: string;
  } & User_Key)[];
  
}

export interface Recipient_Key {
  emailId: UUIDString;
  userUid: string;
  __typename?: 'Recipient_Key';
}

export interface SearchEmailResponse {
  emails:  ({
    
  id: UUIDString;
  subject: string;
  date: DateString;
  content: string;
  sender:  {
    
  name: string;
  email: string;
  uid: string;
  } & User_Key;
  
  to:  ({
    
  user:  {
    
  name: string;
  email: string;
  uid: string;
  } & User_Key;
  
  })[];
  
  } & Email_Key)[];
  
}

export interface SearchEmailVariables {
  query?: string | null;
  uid?: string | null;
}

export interface User_Key {
  uid: string;
  __typename?: 'User_Key';
}



/* Allow users to create refs without passing in DataConnect */
export function createUserRef(vars?: CreateUserVariables): MutationRef<CreateUserResponse, CreateUserVariables>;
/* Allow users to pass in custom DataConnect instances */
export function createUserRef(dc: DataConnect, vars?: CreateUserVariables): MutationRef<CreateUserResponse,CreateUserVariables>;

export function createUser(vars?: CreateUserVariables): MutationPromise<CreateUserResponse, CreateUserVariables>;
export function createUser(dc: DataConnect, vars?: CreateUserVariables): MutationPromise<CreateUserResponse,CreateUserVariables>;


/* Allow users to create refs without passing in DataConnect */
export function createEmailRef(vars?: CreateEmailVariables): MutationRef<CreateEmailResponse, CreateEmailVariables>;
/* Allow users to pass in custom DataConnect instances */
export function createEmailRef(dc: DataConnect, vars?: CreateEmailVariables): MutationRef<CreateEmailResponse,CreateEmailVariables>;

export function createEmail(vars?: CreateEmailVariables): MutationPromise<CreateEmailResponse, CreateEmailVariables>;
export function createEmail(dc: DataConnect, vars?: CreateEmailVariables): MutationPromise<CreateEmailResponse,CreateEmailVariables>;


/* Allow users to create refs without passing in DataConnect */
export function createRecipientRef(vars?: CreateRecipientVariables): MutationRef<CreateRecipientResponse, CreateRecipientVariables>;
/* Allow users to pass in custom DataConnect instances */
export function createRecipientRef(dc: DataConnect, vars?: CreateRecipientVariables): MutationRef<CreateRecipientResponse,CreateRecipientVariables>;

export function createRecipient(vars?: CreateRecipientVariables): MutationPromise<CreateRecipientResponse, CreateRecipientVariables>;
export function createRecipient(dc: DataConnect, vars?: CreateRecipientVariables): MutationPromise<CreateRecipientResponse,CreateRecipientVariables>;


/* Allow users to create refs without passing in DataConnect */
export function deleteEmailRef(vars?: DeleteEmailVariables): MutationRef<DeleteEmailResponse, DeleteEmailVariables>;
/* Allow users to pass in custom DataConnect instances */
export function deleteEmailRef(dc: DataConnect, vars?: DeleteEmailVariables): MutationRef<DeleteEmailResponse,DeleteEmailVariables>;

export function deleteEmail(vars?: DeleteEmailVariables): MutationPromise<DeleteEmailResponse, DeleteEmailVariables>;
export function deleteEmail(dc: DataConnect, vars?: DeleteEmailVariables): MutationPromise<DeleteEmailResponse,DeleteEmailVariables>;


/* Allow users to create refs without passing in DataConnect */
export function listUsersRef(): QueryRef<ListUsersResponse, undefined>;/* Allow users to pass in custom DataConnect instances */
export function listUsersRef(dc: DataConnect): QueryRef<ListUsersResponse,undefined>;

export function listUsers(): QueryPromise<ListUsersResponse, undefined>;
export function listUsers(dc: DataConnect): QueryPromise<ListUsersResponse,undefined>;


/* Allow users to create refs without passing in DataConnect */
export function getUidByEmailRef(vars?: GetUidByEmailVariables): QueryRef<GetUidByEmailResponse, GetUidByEmailVariables>;
/* Allow users to pass in custom DataConnect instances */
export function getUidByEmailRef(dc: DataConnect, vars?: GetUidByEmailVariables): QueryRef<GetUidByEmailResponse,GetUidByEmailVariables>;

export function getUidByEmail(vars?: GetUidByEmailVariables): QueryPromise<GetUidByEmailResponse, GetUidByEmailVariables>;
export function getUidByEmail(dc: DataConnect, vars?: GetUidByEmailVariables): QueryPromise<GetUidByEmailResponse,GetUidByEmailVariables>;


/* Allow users to create refs without passing in DataConnect */
export function searchEmailRef(vars?: SearchEmailVariables): QueryRef<SearchEmailResponse, SearchEmailVariables>;
/* Allow users to pass in custom DataConnect instances */
export function searchEmailRef(dc: DataConnect, vars?: SearchEmailVariables): QueryRef<SearchEmailResponse,SearchEmailVariables>;

export function searchEmail(vars?: SearchEmailVariables): QueryPromise<SearchEmailResponse, SearchEmailVariables>;
export function searchEmail(dc: DataConnect, vars?: SearchEmailVariables): QueryPromise<SearchEmailResponse,SearchEmailVariables>;


/* Allow users to create refs without passing in DataConnect */
export function listInboxRef(vars?: ListInboxVariables): QueryRef<ListInboxResponse, ListInboxVariables>;
/* Allow users to pass in custom DataConnect instances */
export function listInboxRef(dc: DataConnect, vars?: ListInboxVariables): QueryRef<ListInboxResponse,ListInboxVariables>;

export function listInbox(vars?: ListInboxVariables): QueryPromise<ListInboxResponse, ListInboxVariables>;
export function listInbox(dc: DataConnect, vars?: ListInboxVariables): QueryPromise<ListInboxResponse,ListInboxVariables>;


/* Allow users to create refs without passing in DataConnect */
export function listSentRef(vars?: ListSentVariables): QueryRef<ListSentResponse, ListSentVariables>;
/* Allow users to pass in custom DataConnect instances */
export function listSentRef(dc: DataConnect, vars?: ListSentVariables): QueryRef<ListSentResponse,ListSentVariables>;

export function listSent(vars?: ListSentVariables): QueryPromise<ListSentResponse, ListSentVariables>;
export function listSent(dc: DataConnect, vars?: ListSentVariables): QueryPromise<ListSentResponse,ListSentVariables>;


/* Allow users to create refs without passing in DataConnect */
export function getStatsRef(): QueryRef<GetStatsResponse, undefined>;/* Allow users to pass in custom DataConnect instances */
export function getStatsRef(dc: DataConnect): QueryRef<GetStatsResponse,undefined>;

export function getStats(): QueryPromise<GetStatsResponse, undefined>;
export function getStats(dc: DataConnect): QueryPromise<GetStatsResponse,undefined>;


