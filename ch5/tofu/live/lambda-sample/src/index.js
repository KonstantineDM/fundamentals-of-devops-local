exports.handler = (event, context, callback) => {
  if (event.rawPath === "/") {
    return callback(null, {statusCode: 200, body: "Fundamentals of DevOps V3!"});
  }

  if (event.rawPath === "/name/spam") {
    return callback(null, { statusCode: 200, body: "Hello, Spam!" });
  }

  return callback(null, { statusCode: 404, body: "Not Found" });
};
