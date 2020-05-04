module.exports =
/******/ (function(modules, runtime) { // webpackBootstrap
/******/ 	"use strict";
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	__webpack_require__.ab = __dirname + "/";
/******/
/******/ 	// the startup function
/******/ 	function startup() {
/******/ 		// Load entry module and return exports
/******/ 		return __webpack_require__(650);
/******/ 	};
/******/
/******/ 	// run startup
/******/ 	return startup();
/******/ })
/************************************************************************/
/******/ ({

/***/ 187:
/***/ (function(module) {

module.exports = eval("require")("slugify");


/***/ }),

/***/ 417:
/***/ (function(module) {

module.exports = require("crypto");

/***/ }),

/***/ 622:
/***/ (function(module) {

module.exports = require("path");

/***/ }),

/***/ 650:
/***/ (function(__unusedmodule, __unusedexports, __webpack_require__) {

const core = __webpack_require__(898)
const github = __webpack_require__(654)
const request = __webpack_require__(785)
const fs = __webpack_require__(747)
const path = __webpack_require__(622)
const crypto = __webpack_require__(417)
const frontMatter = __webpack_require__(706)
const slugify = __webpack_require__(187)

async function run () {
  try {
    const readmeKey = core.getInput('readme-api-key', { required: true })
    const filePath = core.getInput('file-path', { required: false })
    const apiVersion = core.getInput('readme-api-version', { required: true })
    const token = core.getInput('repo-token', { required: true })

    const client = new github.GitHub(token)

    const options = {
      headers: {
        'x-readme-version': apiVersion,
        'x-readme-source': 'github'
      },
      auth: { user: readmeKey },
      resolveWithFullResponse: true
    }
    // get file-path
    const repoFiles = await client.repos.getContents({
      owner: github.context.repo.owner,
      repo: github.context.repo.repo,
      path: filePath,
      ref: github.context.ref
    })
    // get files recursively
    for (let file in repoFiles.data) {
      if (repoFiles.data[file].type === 'dir') {
        let dir = await client.repos.getContents({
          owner: github.context.repo.owner,
          repo: github.context.repo.repo,
          path: repoFiles.data[file].path,
          ref: github.context.ref
        })
        repoFiles.data.push(...dir.data)
      }
    }
    // filter markdown files
    const files = repoFiles.data.filter((file) => file.name.endsWith('.md') || file.name.endsWith('.markdown'))

    function validationErrors (err) {
      if (err.statusCode === 400) {
        core.setFailed(err.message)
        return Promise.reject(err.error)
      }
      core.setFailed(err.message)
      return Promise.reject(err)
    }

    // create readme.io doc
    function createDoc (slug, file, hash, err) {
      if (err.statusCode !== 404) return Promise.reject(err.error)

      return request
        .post(`https://dash.readme.io/api/v1/docs`, {
          json: { slug, body: file.content, ...file.data, lastUpdatedHash: hash },
          ...options
        })
        .catch(validationErrors)
    }

    // update readme.io doc
    function updateDoc (slug, file, hash, existingDoc) {
      if (hash === existingDoc.lastUpdatedHash) {
        return `\`${slug}\` not updated. No changes.`
      }
      return request
        .put(`https://dash.readme.io/api/v1/docs/${slug}`, {
          json: Object.assign(existingDoc, {
            body: file.content,
            ...file.data,
            lastUpdatedHash: hash
          }),
          ...options
        })
        .catch(validationErrors)
    }

    return Promise.all(
      
      files.map(async (gitFile) => {
        markdown = await client.repos.getContents({
          owner: github.context.repo.owner,
          repo: github.context.repo.repo,
          path: gitFile.path,
          ref: github.context.ref
        })

        const file = Buffer.from(markdown.data.content, 'base64').toString('utf8')
        const matter = frontMatter(file)

        // Ignore markdown files missing front-matter title or category
        if (!matter.data.hasOwnProperty('category')) {
          core.warning(markdown.data.path + ' was not synced (missing title/category front-matter)')
          return
        }
        // get category id
        category = await request
          .get(`https://dash.readme.io/api/v1/categories/${slugify(matter.data.category)}`, {
            json: true,
            ...options
          })
          .catch(validationErrors)

        // Get filename with no extension
        let filenameNoExt     = markdown.data.name.replace(path.extname(markdown.data.name), '')
        matter.data.category  = category.body._id
        // Set title from filename, and replace all '_' with spaces
        matter.data.title     = filenameNoExt.replace(/_/g, ' ')

        // Stripping the markdown extension from the filename and slug formatting
        const slug = slugify(filenameNoExt) // filename-to-slug-no-extesion
        const hash = markdown.data.sha

        return request
          .get(`https://dash.readme.io/api/v1/docs/${slug}`, {
            json: true,
            ...options
          })
          .then(updateDoc.bind(null, slug, matter, hash), createDoc.bind(null, slug, matter, hash))
          .catch((err) => {
            return Promise.reject(err)
          })
      })
    )
  } catch (err) {
    core.setFailed(err.message)
  }
}

run()


/***/ }),

/***/ 654:
/***/ (function(module) {

module.exports = eval("require")("@actions/github");


/***/ }),

/***/ 706:
/***/ (function(module) {

module.exports = eval("require")("gray-matter");


/***/ }),

/***/ 747:
/***/ (function(module) {

module.exports = require("fs");

/***/ }),

/***/ 785:
/***/ (function(module) {

module.exports = eval("require")("request-promise-native");


/***/ }),

/***/ 898:
/***/ (function(module) {

module.exports = eval("require")("@actions/core");


/***/ })

/******/ });