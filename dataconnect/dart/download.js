const zipName = "firebase_data_connect_latest.zip";
const decompress = require('decompress');
const https = require("https");
const fs = require("fs");
const path = require('path');
const cachePath = "/home/user/.cache/firebase/sdk/dart/";
fs.mkdirSync(cachePath, { recursive: true });
const fullZipPath = cachePath + zipName;
const fullOutputPath = path.resolve('./');
function getLatestStorageZip() {
    const url = `https://firebasestorage.googleapis.com/v0/b/getting-started-dart-storage.appspot.com/o/firebase_data_connect_0.0.6.zip?alt=media&token=814d7f55-2e0d-47a5-852b-f1eaa399fcc8`;
    return new Promise((resolve, reject) => {
        https.get(url, (res) => {
            const writeStream = fs.createWriteStream(fullZipPath);
            res.pipe(writeStream);
            writeStream.on('error', reject);

            writeStream.on("finish", (err) => {
                writeStream.close();
                console.log("Download Completed!");
                resolve();
            })
        });
    });
}
function unzip() {
    console.log('unzipping')
    return decompress(fullZipPath, fullOutputPath);
}
getLatestStorageZip().then(unzip);