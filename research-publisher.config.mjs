export default {
  site: {
    title: "Visual Engineering Research",
    description: "Searchable AI engineering research repository",
    baseUrl: "/",
    language: "en",
    siteUrl: "https://ai.echelonfoundry.com/",
  } /**/,
  repository: {
    name: "AI Engineering",
    sourceUrl: "https://github.com/kemiller2002/Visual-Engineering",
  },
  content: {
    include: ["**/*.md"],
    exclude: [
      "node_modules/**",
      "dist/**",
      "build/**",
      "build-reports/**",
      ".git/**",
      ".github/**",
      ".research-publisher/**",
      "coverage/**",
      "tmp/**",
      "temp/**",
      "input-documents/**",
      "prompts/**",
      "packages/**",
      "**/archive/**",
      "**/archives/**",
    ],
    drafts: false,
  },
  metadata: {
    mode: "compatible",
    strictInCI: true,
  },
  output: {
    directory: "dist",
    catalog: "data/research-catalog.json",
    diagnostics: "data/build-diagnostics.json",
  },
};
