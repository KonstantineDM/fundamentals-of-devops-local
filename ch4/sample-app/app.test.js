const request = require("supertest");
const app = require("./app");

describe("Test the app", () => {
  test("Get / should return Hello, World!", async () => {
    const response = await request(app).get("/");
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe("Hello, World!");
  });

  test("Get /name/Spam should return Hello, Spam!", async () => {
    const response = await request(app).get("/name/Spam");
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe("Hello, Spam!");
  });

  const maliciousUrl = "/name/%3Cscript%3Ealert(%22SpAm%22)%3C%2Fscript%3E";
  const sanitizedResponse = "Hello, &lt;script&gt;alert(&#34;SpAm&#34;)&lt;/script&gt;!";

  test("Get /name should sanitize its input", async () => {
    const response = await request(app).get(maliciousUrl);
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe(sanitizedResponse);
  });
});
