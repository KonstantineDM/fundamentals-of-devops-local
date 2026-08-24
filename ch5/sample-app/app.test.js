const request = require('supertest');
const app = require('./app');

describe('Test the app', () => {
  test('Get / should return Hello, DevOps!', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Hello, DevOps!');
  });

  test('Get /name/Spam should return Hello, Spam!', async () => {
    const response = await request(app).get('/name/Spam');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Hello, Spam!');
  });
});
