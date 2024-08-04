
// reference doc links:

// https://ai.google.dev/gemini-api/docs/json-mode?lang=dart
// https://ai.google.dev/api/generate-content#text
// https://ai.google.dev/gemini-api/docs/function-calling

// Using `responseMimeType` with `responseSchema` requires a Gemini 1.5 Pro model

// final schema = Schema.array(
//     description: 'List of recipes',
//     items: Schema.object(properties: {
//       'recipeName':
//           Schema.string(description: 'Name of the recipe.', nullable: false)
//     }, requiredProperties: [
//       'recipeName'
//     ]));

// final model = GenerativeModel(
//     model: 'gemini-1.5-pro',
//     apiKey: apiKey,
//     generationConfig: GenerationConfig(
//         responseMimeType: 'application/json', responseSchema: schema));

// final prompt = 'List a few popular cookie recipes.';
// final response = await model.generateContent([Content.text(prompt)]);
// print(response.text);




