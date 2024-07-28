import { ListInboxResponse } from "@email-app/email";

const sender = {
  name: "Data Connect Team",
  email: "welcome@example.com",
  uid: "fdc-uid",
};

const to = [
  {
    user: {
      name: "Data Connect",
      email: "data-connect@example.com",
      uid: "fdc-uid",
    },
  }
];

const date = new Date().toLocaleDateString();

const fakeEmails: ListInboxResponse['emails'] = [{
  id: "fake-getting-started",
  subject: "Getting started",
  content: `
      <p class="mb-4">
        Welcome to Data Connect! These set of emails will teach you how to get started and to use Data Connect. To start, use the Firebase Extension to the left to seed the database with the example <code>.gql</code> files.
      </p>

      <ol class="list-decimal ml-8 mb-4 leading-8">
        <li>Click the Firebase Extension to the left (see attachment below).</li>
        <li>Click the Connect to Local PostgreSQL button. Note: this IDX template includes a built-in Postgres instance, with the connection string pre-configured. Continue with the provided Postgres connection string. </li>
        <li>Open the <code>/dataconnect</code> folder and run the insert scripts in the following order: <code>User_insert.gql</code>, <code>Email_insert.gql</code>, <code>EmailMeta_insert.gql</code>, and <code>Recipient_insert.gql.</code></li>
        <li>Refresh the IDX preview panel to pick up the changes.</li>
      </ol>

      <p class="mb-4">
        <strong>Read the following emails for more information</strong> about Data Connect, see the attachments below for screenshots of the above actions, or watch the video below.
      </p>

      <h4 class="mb-2 text-sm font-bold uppercase tracking-wide text-gray-500">Attachments</h4>
      <p class="mb-4 flex flex-col gap-y-4">
        <iframe class="rounded-md" width="560" height="315" src="https://www.youtube.com/embed/7OdVatEI85o?si=7hgOoc2OChGyAHH8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
        <img src="/extension.png" alt="The Firebase Extension" class="rounded-lg" />
        <img src="/psql.png" alt="The connection string input" class="rounded-lg" />
        <img src="/insert-scripts.png" alt="A screenshot of a GQL insert script" class="rounded-lg" />
      </p>
  `,
  sender,
  to,
  date,
}, {
  id: "fake-modifying-schema",
  subject: "Modifying Schema",
  content: `
  <h3 class="mb-2 text-xl">The schema file</h3>
  <p class="mb-4">
    You can see the existing database schema by looking at the <code>dataconnect/schema/schema.gql</code> file. 
  </p>

  <p class="mb-4">
    In Data Connect, GraphQL types represent database tables with the <code>@table</code> directive. Database columns are specified with fields. To specify a primary key, use the <code>@table</code> directive with the <code>key</code> property. By default if no key is provided Data Connect will create an <code>id</code> column of a <code>UUID</code> type. You can customize information about a column using the <code>@col</code directive.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>type User @table(key: "uid") {
  uid: String!
  name: String!
  address: String!
}
</code></pre>
  
  <h3 class="mb-2 text-xl">Creating a relationship</h3>
  <p class="mb-4">
    To create a relationship between tables create a field and assign it to a custom Type. In the example below <code>User</code> is now related to <code>Email</code>.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>type Email @table {
  subject: String!
  date: Date!
  text: String!
  from: User!
}
</code></pre>

  <h3 class="mb-2 text-xl">Creating composite keys</h3>
  <p class="mb-4">
    You can use the <code>@table</code> directive to create composite keys by specifying an array of fields to use as the primary key.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>type Recipient @table(key: ["email", "user"]) {
  email: Email!
  user: User!
}
</code></pre>

  <p class="mb-4">
    This example above create as "join table" or also known as a "many-to-many" table because many users can receive many emails.
  </p>
  `,
  sender,
  to,
  date,
}, {
  id: "fake-writing-queries",
  subject: "Writing Queries",
  content: `
  <h3 class="mb-2 text-xl">The query file</h3>
  <p class="mb-4">
    Queries are located in the <code>dataconnect/connector/queries.gql</code> file. Within this file you can write queries and test them using the Execution Panel which is a part of the Extension (see attachment for screenshot).
  </p>

  <p class="mb-4">
    Queries use GraphQL to specify what table to begin the query with and then what fields are returned. You can rename fields within a query (known as aliasing) using the <code>alias:field</code> syntax as seen with <code>email:address</code> below.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>query ListUsers @auth(level: PUBLIC) {
  users { uid name email: address }
}</code></pre>

  <h3 class="mb-2 text-xl">Joining data</h3>
  <p class="mb-4">
    You can join data by using natural relationships our the automatic relational mapping fields. A natural relationship refers to fields of custom types that exist on your schema.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>query ListUsers @auth(level: PUBLIC) {
  emails { 
    id subject text 
    from { uid name } 
  }
}</code></pre>

  <p class="mb-4">
    In the example above the <code>from</code> field is a custom type specified in the schema. This allows you to nest into this field as retrieve properties like <code>uid</code> and <code>name</code>.
  </p>

  <p class="mb-4">
    You can also use the automatic relational mapping fields to join data. Data Connect creates fields that can efficiently join data in cases where there are no natural relationships.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>query GetEmails @auth(level: PUBLIC) {
  emails {
    to: recipients_on_email {
      user { name uid }
    }
  }
}
</code></pre>

  <h3 class="mb-2 text-xl">Using query variables</h3>
  <p class="mb-4">
    Queries can take arguments in the form of the <code>$variable</code> syntax.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>query ListUsers($name: String!) @auth(level: PUBLIC) {
  users(where: { 
    name: { eq: $name } 
  }) { 
    uid name email: address 
  }
}
</code></pre>  

  <h3 class="mb-2 text-xl">Filtering data</h3>
  <p class="mb-4">
    You can filter data using the <code>where()</code> property. This takes an array of different
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>query ListUsers @auth(level: PUBLIC) {
  users(where: { 
    name: { eq: "John" } 
  }) { 
    uid name email: address 
  }
}</code></pre>

  <p class="mb-4">
    You can use more complex query conditions such as <code>contains</code>, <code>in</code>, <code>nin</code>, <code>ne</code>, <code>gt</code>, <code>lt</code>, <code>pattern</code>, <code>startsWith</code> and more. The query below searches for a message content and a user that has recieved the message.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>query SearchEmail(
  $query: String,
  $uid: String
) @auth(level: PUBLIC) {
  emails(where: {
    text: { contains: $query }
    users_via_Recipient: { 
      exist: { uid: { eq: $uid }
    }}
  }) {
    id subject date 
    content: text 
    sender: from { name email: address uid }
    to: recipients_on_email {
      user { name email: address uid }
    }
  }
}
</code></pre>

  <p class="mb-4">
    Queries can also use the automatic relational mapping fields to filter data through the <code>exists</code> property as seen with <code>users_via_Recipient</code> above.
  </p>

  <h3 class="mb-2 text-xl">Sort and limit</h3>
  <p class="mb-4">
    You can sort and likit data using the <code>orderBy</code> and <code>limit</code> properties. The query below takes in an array of emails and finds the associated <code>uid</code> for each email while setting a limit of 4 and sorting in ascending order.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>query GetUidByEmail($emails: [String!]) @auth(level: PUBLIC) {
  users(where: { address: { in: $emails } }, limit: 4, orderBy: { name: ASC }) {
    uid email: address
  }
}
</code></pre> 

  <h3 class="mb-2 text-xl">Writing SQL</h3>
  <p class="mb-4">
    You can write SQL in the form of SQL views. Data Connect supports an <code>@view</code> directive that takes in a SQL query that need map the SQL columns to the GraphQL fields.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>type EmailStat @view(sql: """
  SELECT 
    COUNT(*) AS count
  FROM email
 """) {
  count: Int
}
</code></pre>

  <p class="mb-4">
    In the SQL view above there is a <code>count</code> field in the GraphQL type that is mapped to the <code>count</code> field computed in the SQL query. Note that table names by default are singular: <code>email</code> vs <code>emails</code>. When you're writing raw SQL make sure to be aware of reserved words that need to be escaped with quotes, such as <code>SELECT uid FROM "user"</code> or <code>SELECT id FROM "order"</code>.
  </p>

  <p class="mb-4">
    Once the SQL view exists you can use it in a query.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>query GetStats @auth(level: PUBLIC) {
  emailStats { count }
}
</code></pre>
  `,
  sender,
  to,
  date,
}, {
  id: "fake-security",
  subject: "Security policies",
  content: `
  <p class="mb-4">
    Security is handled with the <code>@auth</code> directive. In Data Connect security policies are directly mapped to queries and mutations. You don't need to maintain a large security rule file that has to be sophisticated enough to handle any arbitrary request that comes into the database. 
  </p>

  <p class="mb-4">
    In Data Connect all queries and mutations are predefined so you only have to define security policies for the existing queries and mutations. You can use predefined policies with the <code>level</code> property or write an security rule expression with the <code>expr</code> property. 
  </p>
  
  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>query ListUsers @auth(level: USER) {
  users { uid name email: address }
}</code></pre>

  <p class="mb-4">
    The policy above will ensure that only authenticated users can run the query. During local development you can initially set the <code>level</code> property to <code>PUBLIC</code> to allow all users to run the query. <strong>However, this is not recommended in production.</strong>
  </p>
  
  <p class="mb-4">
    Stay tuned for an updated guide on security.
  </p>
  `,
  sender,
  to,
  date,
},{
  id: "fake-updating-data",
  subject: "Updating Data",
  content: `
  <h3 class="mb-2 text-xl">Updating data</h3>
  <p class="mb-4">
    Updating data is done with GraphQL <strong>Mutations</strong>. Mutations are located in the <code>dataconnect/connector/mutations.gql</code> file. Within this file you can write mutations and test them using the Execution Panel which is a part of the Extension.
  </p>

  <p class="mb-4">
    Data Connect provides a set of automatic mutation fields that correspond to the most common type of update operations in a database such as: <code>insert</code>, <code>update</code>, <code>delete</code>, <code>updateMany</code>, and <code>deleteMany</code>.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>mutation DeleteEmail($emailId: UUID, $uid: String) @auth(level: PUBLIC) {
  recipient_delete(key: { emailId: $emailId, userUid: $uid }) # Deletes based off a composite key
}
</code></pre>

  <h3 class="mb-2 text-xl">Testing mutations with UI</h3>
  <p class="mb-4">
    The Firebase Extension also you to run mutations with their argument values.
    <img src="/mutation-testing.png" alt="The Firebase Extension" class="rounded-lg mt-4" />
  </p>

  <p class="mb-4">
    The mutation above deletes an email from a user's inbox by removing the record in the <code>Recipient</code> table. The <code>table_delete</code> mutation requires a <code>key</code> property that corresponds to the primary key of the table which is a composite key in this case.
  </p>

  <h3 class="mb-2 text-xl">Server values</h3>
  <p class="mb-4">
    Data Connect also allows you to specify values on the server such as current user's <code>uid</code>, the current time, and a UUID key.
  </p>
  
  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>mutation CreateEmail($content: String, $subject: String, $fromUid: String) @auth(level: PUBLIC) {
  email_insert(data: {
    id_expr: "uuidV4()"
    text: $content,
    subject: $subject,
    fromUid_expr: "auth.uid",
    date_date: { today: true },
  })
}
</code></pre>

  <p class="mb-4">
    The <code>field_expr</code> field allows you to provide values that Data Connect will process on the server and resolve to their corresponding value. The <code>{ today: true }</code> value will provide the current date, the <code>"auth.uid"</code> value will provide the currently authenticated user's <code>uid</code>, and <code>"uuidV4()"</code> will generate a new UUID.
  </p>
  `,
  sender,
  to,
  date,
}, {
  id: "fake-sdk-generation",
  subject: "Using the Generated SDK",
  content: `
  <p class="mb-4">
    Every query and mutation in Data Connect is generated in a typesafe SDK. When you change the return type of a query or arguments of a mutation Data Connect will generate the SDK including the new types. This keeps your client-side code in sync with your data structure.
  </p>
    
  <h3 class="mb-2 text-xl">Configuring your custom npm package</h3>
  <p class="mb-4">
    To set up your custom SDK, open the <code>dataconnect/connector/connector.yaml</code> file.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>connectorId: email
authMode: PUBLIC
generate:
javascriptSdk:
  # Create a custom package name for your generated SDK
  package: "@email-app/email"
  # Tells Data Connect where to store the generated SDK code, this should be in the same
  # directory as your app code
  outputDir: "../../email-app/email-generated"
  # This property tells Data Connect what directory to install the generated SDK to
  packageJsonDir: "../../email-app"
</code></pre>

  <h3 class="mb-2 text-xl">Installing the SDK</h3>
  <p class="mb-4">
    The <code>packageJsonDir</code> property tells Data Connect where to install the generated SDK. However, if this is not working as expected or you want to manually install the SDK you can use npm install using the generated SDK's <code>outputDir</code>.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code># within the /email-app dir
npm i ./email-generated</code></pre>

  <p class="mb-4">
    Once the SDK is installed you can import it into your app using the value of the <code>package</code> property.
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>import { listInbox, ListInboxResponse } from '@email-app/email'
</code></pre>

  <h3 class="mb-2 text-xl">Initializing Data Connect</h3>
  <p class="mb-4">
    Data Connect is designed to be used from an emulator first approach development. You can use the <code>connectDataConnectEmulator</code> function to tell Data Connect to use the emulator instead of production.  
  </p>

  <pre class="bg-gray-900 text-gray-100 p-2 rounded mb-6 overflow-x-scroll"><code>import { listInbox, ListInboxResponse } from '@email-app/email'
import { initializeApp } from 'firebase/app'
import { getDataConnect, connectDataConnectEmulator } from 'firebase/data-connect'
import { listInbox, ListInboxResponse, connectorConfig, createEmail } from '@email-app/email'

const firebaseApp = initializeApp({ /* your config or blank if just using local */});
const dataConnect = getDataConnect(firebaseApp, connectorConfig)
// This is different in IDX due to multiple ports, see the details below for more.
connectDataConnectEmulator(dataConnect, 'localhost', 9399, false)  

const { data } = await listInbox(dataConnect, { uid: "user_david" })
console.log(data.emails)

const emailResponse = await createEmail(dc, {
  fromUid: "user_david",
  subject: "Let's sync!",
  content: "Can you meet at 1pm?",
})
</code></pre>

  <h3 class="mb-2 text-xl">Setting up the Emulator in Project IDX</h3>
  <p class="mb-4">
    If you're using this template within Project IDX the emulator initialization is a little bit different than a local development version due to CORS issues. This template sets up a reverse proxy in the Next.js config to send all requests through the Next.js server to avoid any CORS issues across domains.
  </p>

  <p class="mb-4">
    From there Data Connect SDK needs to know to send all requests to the Next.js server which are then forwarded to the emulator. See the <code>next.config.js</code> file for the reverse proxy configuration and the <code>email-app/data-connect/index.tsx</code> file for the emulator initialization that works across both client and server components.
  </p>
`,
  sender,
  to,
  date,
}];

export default fakeEmails;