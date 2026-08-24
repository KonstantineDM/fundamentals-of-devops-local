import js from "@eslint/js";
import jest from "eslint-plugin-jest";
import { defineConfig } from "eslint/config";
import globals from "globals";

export default defineConfig([
  {
    files: ["**/*.{js,mjs,cjs}"],
    plugins: { js },
    extends: ["js/recommended"],
    languageOptions: {
      globals: globals.node,
    },
  },

  {
    files: ["**/*.js"],
    languageOptions: {
      sourceType: "commonjs",
    },
  },

  {
    files: ["**/*.test.js"],
    ...jest.configs["flat/recommended"],
    rules: {
      "jest/prefer-expect-assertions": "off",
    },
  },
]);
