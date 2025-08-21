# GPT3 Generate App - Pre-ChatGPT Code Generator

## Overview

**GPT3 Generate App** was an experimental prototype application generator built before ChatGPT (GPT-3.5) was released. This project demonstrates how we leveraged OpenAI's GPT-3 Davinci/Codex API to automatically generate complete web applications from simple YAML configurations.

## Historical Context

Before the advent of ChatGPT and more sophisticated prompt engineering techniques, generating code with AI required carefully crafted template systems. This project represents an early exploration into AI-assisted application development, using a template-based approach to guide GPT-3 in producing consistent, working code.

## How It Worked

### 1. Simple Configuration
Users defined their application requirements in a minimal `config.yml` file:

```yaml
app_prototypes:
  weather_proto_1: weather application with one api endpoint that uses openmeteo dot com
```

### 2. Template-Based Generation
The system used meticulously crafted prompt templates to guide GPT-3 in generating different application components. Each template file contained multiple examples following a consistent pattern:

```
# DESCRIPTION
# [what to generate]
# IMPLEMENTATION
[example code]
```

This few-shot learning approach helped GPT-3 understand the expected output format and coding patterns.

### 3. Template Structure

The `templates/` directory contained specialized prompt templates for different components:

- **`prompt_app.md`** - Generated application requirements from high-level descriptions, translating simple ideas like "weather application" into detailed specifications with models, routes, and methods
- **`prompt_model.md`** - Created model classes with database schemas using Sequel ORM, including table creation and class definitions
- **`prompt_model_method.md`** - Generated individual model methods for CRUD operations, API calls, and data queries
- **`prompt_route.md`** - Built Roda routing handlers for REST endpoints with proper parameter handling and response formatting
- **`prompt_fix_error.md`** - Provided error correction examples to help GPT-3 fix common Ruby syntax and runtime errors

Each template used few-shot learning with multiple examples showing the pattern GPT-3 should follow. For instance, the model method template would show examples of `.all`, `.get`, `.create` methods across different models (Tweet, Post, Comment) so GPT-3 could generalize the pattern to new models.

## Generated Components

Running `rake` would generate:
- Main application file (Roda-based)
- Model files with database schemas
- Controller routes and API endpoints  
- HAML layout and view templates
- CSS stylesheets
- Complete working application structure

## Example Application Generation Flow

1. User defines app in `config.yml`: "blog with posts and comments"
2. System uses `prompt_app.md` to expand into detailed requirements
3. For each model, uses `prompt_model.md` to generate schema and class
4. Uses `prompt_model_method.md` to generate CRUD methods
5. Uses `prompt_route.md` to create REST endpoints
6. If errors occur, uses `prompt_fix_error.md` patterns to correct them

## Why This Approach?

Before ChatGPT's conversational abilities and improved context understanding, we needed:
- **Structured prompts** to maintain consistency across generated code
- **Explicit examples** for every pattern to ensure GPT-3 understood the task
- **Template chaining** to build complex applications piece by piece
- **Fixed patterns** to ensure generated code would compile and run

The templates essentially taught GPT-3 a "mini programming language" through examples, allowing it to generate consistent, working Ruby/Roda applications despite not being instruction-tuned like modern models.

## Technical Stack

- **AI Model**: OpenAI GPT-3 Davinci/Codex
- **Language**: Ruby
- **Framework**: Roda (routing)
- **ORM**: Sequel
- **Database**: PostgreSQL/SQLite
- **Views**: HAML templates
- **Generation**: Rake tasks

## Legacy and Learning

This project represents an important milestone in AI-assisted development:
- **Early exploration** of using LLMs for code generation
- **Template engineering** as a precursor to modern prompt engineering
- **Practical application** of GPT-3's capabilities before instruction-tuned models
- **Foundation** for understanding how AI code generation has evolved

While modern tools like ChatGPT, Claude, and GitHub Copilot have made this approach obsolete, this project demonstrates the ingenuity required to harness early AI models for practical software development. The template-based approach was essentially a workaround for the limitations of early language models, creating a structured way to "program" GPT-3 to program.

## Note

This project is preserved as a historical artifact showing the evolution of AI-assisted development. For modern applications, use contemporary tools like ChatGPT, Claude, or specialized coding assistants that don't require such elaborate template systems.

---

*Created before ChatGPT changed everything about AI code generation.*
