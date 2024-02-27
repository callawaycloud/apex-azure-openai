# Azure OpenAI Salesforce

Library for connecting with Azure's OpenAI API from Salesforce Apex or Flow

## Setup

### Setup your Azure

- Register an Azure account and request access to OpenAI api (requires a form at time of publishing).
- Create a new Azure OpenAI instance
- Create a new Deployment for GPT-4 or other "Chat" model
- Grab API keys

### Setup Salesforce

1. Install sf metadata `sf project deploy start -u <username> --source-dir force-app/main/default`
1. (Optional) Deploy the examples:
1. Assign user to Permission Set: `sf user permset assign -n AzureOAI`
1. Setup Named Credential

- Update the Named Credential URL to match your deployment endpoint
- Update the External Credential Principal with your API Key

_Note: For Usage, deploy example flow (`sf project deploy start -u <username> --source-dir force-app/main/examples`) or see apex code in `scripts`_
