# Contributing

Thanks for helping improve the Campus Dining Portal.

## Getting started

1. Fork the repository and create a branch for your change.
2. Follow the [local setup instructions](README.md#run-locally), including creating a local `.env` file.
3. Keep changes focused and consistent with the existing Node.js, SQL, and browser JavaScript style.
4. Run `npm install` and `npm start` from `front end/`, and manually verify the affected flow against a local MySQL 8 database.
5. Open a pull request and describe the change, how you tested it, and any database or configuration changes.

## Before submitting

- Do not commit `.env` files, passwords, API keys, or real personal data.
- Update the README when setup steps, configuration, or API behavior changes.
- Include or update database scripts when a feature changes the schema.
- Be clear about tests that could not be run. The project does not currently have an automated test suite.
