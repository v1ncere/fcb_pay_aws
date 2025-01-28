import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

/*== STEP 1 ===============================================================
The section below creates a Todo database table with a "content" field. Try
adding a new "isDone" field as a boolean. The authorization rule below
specifies that any unauthenticated user can "create", "read", "update", 
and "delete" any "Todo" records.
=========================================================================*/
const schema = a.schema({
  // Account
  Account: a.model({
    accountNumber: a.string().required(),
    balance: a.float(),
    category: a.string(),
    creditLimit: a.float(),
    expiry: a.datetime(),
    type: a.string(),
    ownerName: a.string(),
    owner: a.string(),
    // relationships
    transactions: a.hasMany('Transaction', 'accountId') // one to many
  }).identifier(['accountNumber'])
  .authorization((allow) => [allow.owner()]),

  // this model is for dynamic viewer widget
  DynamicModel: a.model({
    reference: a.string().required(),
    data: a.json().required(),
  }).authorization((allow) => [allow.authenticated()]),

  // Fund Transfer Accounts
  TransferableUser: a.model({
    transferableUserId: a.string().required(),
    name: a.string(),
    isTransferable: a.boolean(),
    owner: a.string(),
  }).identifier(['transferableUserId'])
  .authorization((allow) => [allow.owner()]),

  // Public Account
  PublicAccount: a.model({
    accountNumber: a.string().required(),
    isExisted: a.boolean().required(),
  }).identifier(['accountNumber'])
  .authorization((allow) => [allow.guest()]),

  // Sign Up Verify
  SignupVerify: a.model({
    id: a.id().required(),
    data: a.string(),
  }).identifier(['id'])
  .authorization((allow) => [allow.guest()]),

  // Sign up Verify Reply
  SignupVerifyReply: a.model({
    id: a.id().required(),
    data: a.string(),
  }).identifier(['id'])
  .authorization((allow) => [allow.guest()]),
  
  // Account Action Button
  AccountButton: a.model({
    type: a.string().required(), // cc, sa, wallet, etc.
    // relationships
    buttons: a.hasMany('Button', 'accountButtonId'), // one to many
  }).identifier(['type'])
  .authorization((allow) => [allow.authenticated()]),

  // Button
  Button: a.model({
    backgroundColor: a.string(),
    icon: a.string(),
    iconColor: a.string(),
    position: a.integer(),
    title: a.string(),
    titleColor: a.string(),
    type: a.string(),
    // relationships
    accountButtonId: a.id(), // foreign key to link with Action Button
    accountButton: a.belongsTo('AccountButton', 'accountButtonId'), // relationship to Action Button
    dynamicRouteId: a.id(), // foreign key to link with DynamicWidget Viewer
    dynamicRoute: a.belongsTo('DynamicRoute', 'dynamicRouteId'), // relationship to DynamicWidget Viewer
    widgets: a.hasMany('DynamicWidget', 'buttonId') // one to many
  }).authorization((allow) => [allow.authenticated()]),

  // Dynamic Viewer Widget
  DynamicRoute: a.model({
    title: a.string(),
    buttons: a.hasMany('Button', 'dynamicRouteId'), // one to many
  }).authorization((allow) => [allow.authenticated()]),
  
  // Dynamic Widget 
  DynamicWidget: a.model({
    hasExtra: a.boolean(),
    content: a.string(),
    dataType: a.string(),
    node: a.string(),
    position: a.integer(),
    title: a.string(),
    widgetType: a.string(),
    // relationships
    buttonId: a.id(), // foreign key to link with Button
    button: a.belongsTo('Button', 'buttonId'),
    institutionWidgetId: a.id(), // foreign key to link with Institution
    institutionWidget: a.belongsTo('Institution', 'institutionWidgetId'),
    institutionExtraId: a.id(), // foreign key to link with Institution
    institutionExtraWidget: a.belongsTo('Institution', 'institutionExtraId'),
  }).authorization((allow) => [allow.authenticated()]),
  
  // Institution
  Institution: a.model({
    name: a.string(),
    tag: a.string(),
    qrCode: a.string(),
    // relationships
    widget: a.hasMany('DynamicWidget', 'institutionWidgetId'),
    extraWidget: a.hasMany('DynamicWidget', 'institutionExtraId')
  }).authorization((allow) => [allow.authenticated()]),

  // Notification
  Notification: a.model({
    content: a.string(), 
    isRead: a.boolean(),
    sender: a.string(),
    owner: a.string(),
  }).authorization((allow) => [allow.owner()]),

  // Receipt 
  Receipt: a.model({
    data: a.json(),
    owner: a.string(),
  }).authorization((allow) => [allow.owner()]),

  // Transaction History
  Transaction: a.model({
    accountNumber: a.string(),
    accountType: a.string(),
    details: a.string(),
    owner: a.string(),
    // relationships
    accountId: a.id(), // foreign key to link with Account
    account: a.belongsTo('Account', 'accountId'), // relationship to Account
  }).authorization((allow) => [allow.owner()]),

  // User Requests
  Request: a.model({
    data: a.string(),
    verifier: a.string(),
    details: a.string(),
    owner: a.string(),
  }).authorization((allow) => [allow.owner()]),

  // SearchFilter
  SearchFilter: a.enum(['newest,oldest,cc,pr,sa,wallet']),
});

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'identityPool',
  },
});

/*== STEP 2 ===============================================================
Go to your frontend source code. From your client-side code, generate a
Data client to make CRUDL requests to your table. (THIS SNIPPET WILL ONLY
WORK IN THE FRONTEND CODE FILE.)

Using JavaScript or Next.js React Server Components, Middleware, Server 
Actions or Pages Router? Review how to generate Data clients for those use
cases: https://docs.amplify.aws/gen2/build-a-backend/data/connect-to-API/
=========================================================================*/

/*
"use client"
import { generateClient } from "aws-amplify/data";
import type { Schema } from "@/amplify/data/resource";

const client = generateClient<Schema>() // use this Data client for CRUDL requests
*/

/*== STEP 3 ===============================================================
Fetch records from the database and use them in your frontend component.
(THIS SNIPPET WILL ONLY WORK IN THE FRONTEND CODE FILE.)
=========================================================================*/

/* For example, in a React component, you can use this snippet in your
  function's RETURN statement */
// const { data: todos } = await client.models.Todo.list()

// return <ul>{todos.map(todo => <li key={todo.id}>{todo.content}</li>)}</ul>
