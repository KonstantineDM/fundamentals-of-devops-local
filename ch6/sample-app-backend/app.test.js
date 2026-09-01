const request = require("supertest");
const app = require("./app");

describe("Test the app", () => {
  test("Get / should return JSON { text: 'backend microservice' }", async () => {
    const response = await request(app).get("/");
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe(JSON.stringify({ text: 'backend microservice' }));
  });
});
