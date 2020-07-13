




<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
  <link rel="dns-prefetch" href="https://github.githubassets.com">
  <link rel="dns-prefetch" href="https://avatars0.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars1.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars2.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars3.githubusercontent.com">
  <link rel="dns-prefetch" href="https://github-cloud.s3.amazonaws.com">
  <link rel="dns-prefetch" href="https://user-images.githubusercontent.com/">



  <link crossorigin="anonymous" media="all" integrity="sha512-/uy49LxdzjR0L36uT6CnmV1omP/8ZHxvOg4zq/dczzABHq9atntjJDmo5B7sV0J+AwVmv0fR0ZyW3EQawzdLFA==" rel="stylesheet" href="https://github.githubassets.com/assets/frameworks-feecb8f4bc5dce34742f7eae4fa0a799.css" />
  
    <link crossorigin="anonymous" media="all" integrity="sha512-VfqGDOmSHN51m/A7SmvyecvJ+5EARfdvK4aRRdwry4YD8ONgTx75q+sD/yhoCCkKLMOZvlSY70fIpGXK+f6V2g==" rel="stylesheet" href="https://github.githubassets.com/assets/github-55fa860ce9921cde759bf03b4a6bf279.css" />
    
    
    
    


  <meta name="viewport" content="width=device-width">
  
  <title>covidcompare_deprecated/2_peak.r at 1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9 · pyliu47/covidcompare_deprecated</title>
    <meta name="description" content="Covid-19 Forecast Comparison. Contribute to pyliu47/covidcompare_deprecated development by creating an account on GitHub.">
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
  <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
  <meta property="fb:app_id" content="1401488693436528">
  <meta name="apple-itunes-app" content="app-id=1477376905">

    <meta name="twitter:image:src" content="https://avatars3.githubusercontent.com/u/62630460?s=400&amp;v=4" /><meta name="twitter:site" content="@github" /><meta name="twitter:card" content="summary" /><meta name="twitter:title" content="pyliu47/covidcompare_deprecated" /><meta name="twitter:description" content="Covid-19 Forecast Comparison. Contribute to pyliu47/covidcompare_deprecated development by creating an account on GitHub." />
    <meta property="og:image" content="https://avatars3.githubusercontent.com/u/62630460?s=400&amp;v=4" /><meta property="og:site_name" content="GitHub" /><meta property="og:type" content="object" /><meta property="og:title" content="pyliu47/covidcompare_deprecated" /><meta property="og:url" content="https://github.com/pyliu47/covidcompare_deprecated" /><meta property="og:description" content="Covid-19 Forecast Comparison. Contribute to pyliu47/covidcompare_deprecated development by creating an account on GitHub." />

  <link rel="assets" href="https://github.githubassets.com/">
    <link rel="shared-web-socket" href="wss://alive.github.com/_sockets/u/62630460/ws?session=eyJ2IjoiVjMiLCJ1Ijo2MjYzMDQ2MCwicyI6NTE0NzkxMTg4LCJjIjoyNzg0MTc5ODMzLCJ0IjoxNTk0NjMxMzAyfQ==--7dc30260564c5a109aae6c72d28ffa0e2df7de1404fb8784ad8217f4bd28f270" data-refresh-url="/_ws">
  <link rel="sudo-modal" href="/sessions/sudo_modal">

  <meta name="request-id" content="FE82:7266:1D1FD:28F7A:5F0C2486" data-pjax-transient="true" /><meta name="html-safe-nonce" content="d0656cf1b73f5618dffd4c5c804b5b05fcda1486" data-pjax-transient="true" /><meta name="visitor-payload" content="eyJyZWZlcnJlciI6Imh0dHBzOi8vZ2l0aHViLmNvbS9weWxpdTQ3L2NvdmlkY29tcGFyZV9kZXByZWNhdGVkL2NvbW1pdC8xYTIwMTcxMDg1YjIyZTRmOWRkN2Q5OThhNDY0OGVjOGFhM2JkMGQ5IiwicmVxdWVzdF9pZCI6IkZFODI6NzI2NjoxRDFGRDoyOEY3QTo1RjBDMjQ4NiIsInZpc2l0b3JfaWQiOiI0MDE1OTQ1MTAzNjY3MzU0MTkyIiwicmVnaW9uX2VkZ2UiOiJzZWEiLCJyZWdpb25fcmVuZGVyIjoiaWFkIn0=" data-pjax-transient="true" /><meta name="visitor-hmac" content="066cfe539533d32bc6ff6108f132573b9c9b24b478d46ae7807d47929aeae8ef" data-pjax-transient="true" />

    <meta name="hovercard-subject-tag" content="repository:265970691" data-pjax-transient>


  <meta name="github-keyboard-shortcuts" content="repository,source-code" data-pjax-transient="true" />

  

  <meta name="selected-link" value="repo_source" data-pjax-transient>

    <meta name="google-site-verification" content="c1kuD-K2HIVF635lypcsWPoD4kilo5-jA_wBFyT4uMY">
  <meta name="google-site-verification" content="KT5gs8h0wvaagLKAVWq8bbeNwnZZK1r1XQysX3xurLU">
  <meta name="google-site-verification" content="ZzhVyEFwb7w3e0-uOTltm8Jsck2F5StVihD0exw2fsA">
  <meta name="google-site-verification" content="GXs5KoUUkNCoaAZn7wPN-t01Pywp9M3sEjnt_3_ZWPc">

  <meta name="octolytics-host" content="collector.githubapp.com" /><meta name="octolytics-app-id" content="github" /><meta name="octolytics-event-url" content="https://collector.githubapp.com/github-external/browser_event" /><meta name="octolytics-dimension-ga_id" content="" class="js-octo-ga-id" /><meta name="octolytics-actor-id" content="62630460" /><meta name="octolytics-actor-login" content="pyliu47" /><meta name="octolytics-actor-hash" content="07b06f7abd1c9b30fea977cf92f9ddd92d5fd88a0c34f91dab0eb0161e6a15de" />

  <meta name="analytics-location" content="/&lt;user-name&gt;/&lt;repo-name&gt;/blob/show" data-pjax-transient="true" />

  




    <meta name="google-analytics" content="UA-3769691-2">

  <meta class="js-ga-set" name="userId" content="ccb7b2e0180b76ffb62d14a1099fbc8a">

<meta class="js-ga-set" name="dimension10" content="Responsive" data-pjax-transient>

<meta class="js-ga-set" name="dimension1" content="Logged In">



  

      <meta name="hostname" content="github.com">
    <meta name="user-login" content="pyliu47">


      <meta name="expected-hostname" content="github.com">

      <meta name="js-proxy-site-detection-payload" content="OWU1NzY4OGIzZjM4YjMzZGQ5ZDFmOTk4NzhkNjQ2ZDI3NWI2ODM1YzY1MzU3ODJkZDE5NmRmNzQ2YThiMTdhMHx7InJlbW90ZV9hZGRyZXNzIjoiNzYuMTcxLjE0Ny42MyIsInJlcXVlc3RfaWQiOiJGRTgyOjcyNjY6MUQxRkQ6MjhGN0E6NUYwQzI0ODYiLCJ0aW1lc3RhbXAiOjE1OTQ2MzEzMDIsImhvc3QiOiJnaXRodWIuY29tIn0=">

    <meta name="enabled-features" content="MARKETPLACE_PENDING_INSTALLATIONS,PRIMER_NEXT,ACTIONS_MANUAL_RUN">

  <meta http-equiv="x-pjax-version" content="4c26b2a9e41b0793e795772157bc93c8">
  

      <link href="https://github.com/pyliu47/covidcompare_deprecated/commits/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9.atom?token=AO52UPD5HRNWBV334KDIUTV5DAJZM" rel="alternate" title="Recent Commits to covidcompare_deprecated:1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9" type="application/atom+xml">

  <meta name="go-import" content="github.com/pyliu47/covidcompare_deprecated git https://github.com/pyliu47/covidcompare_deprecated.git">

  <meta name="octolytics-dimension-user_id" content="62630460" /><meta name="octolytics-dimension-user_login" content="pyliu47" /><meta name="octolytics-dimension-repository_id" content="265970691" /><meta name="octolytics-dimension-repository_nwo" content="pyliu47/covidcompare_deprecated" /><meta name="octolytics-dimension-repository_public" content="false" /><meta name="octolytics-dimension-repository_is_fork" content="false" /><meta name="octolytics-dimension-repository_network_root_id" content="265970691" /><meta name="octolytics-dimension-repository_network_root_nwo" content="pyliu47/covidcompare_deprecated" /><meta name="octolytics-dimension-repository_explore_github_marketplace_ci_cta_shown" content="true" />


    <link rel="canonical" href="https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r" data-pjax-transient>


  <meta name="browser-stats-url" content="https://api.github.com/_private/browser/stats">

  <meta name="browser-errors-url" content="https://api.github.com/_private/browser/errors">

  <link rel="mask-icon" href="https://github.githubassets.com/pinned-octocat.svg" color="#000000">
  <link rel="alternate icon" class="js-site-favicon" type="image/png" href="https://github.githubassets.com/favicons/favicon.png">
  <link rel="icon" class="js-site-favicon" type="image/svg+xml" href="https://github.githubassets.com/favicons/favicon.svg">

<meta name="theme-color" content="#1e2327">


  <link rel="manifest" href="/manifest.json" crossOrigin="use-credentials">

  </head>

  <body class="logged-in env-production page-responsive page-blob">
    

    <div class="position-relative js-header-wrapper ">
      <a href="#start-of-content" class="p-3 bg-blue text-white show-on-focus js-skip-to-content">Skip to content</a>
      <span class="Progress progress-pjax-loader position-fixed width-full js-pjax-loader-bar">
        <span class="progress-pjax-loader-bar top-0 left-0" style="width: 0%;"></span>
      </span>

      
      



          <header class="Header py-lg-0 js-details-container Details flex-wrap flex-lg-nowrap px-3" role="banner">
  <div class="Header-item d-none d-lg-flex">
    <a class="Header-link" href="https://github.com/" data-hotkey="g d"
  aria-label="Homepage " data-ga-click="Header, go to dashboard, icon:logo">
  <svg class="octicon octicon-mark-github v-align-middle" height="32" viewBox="0 0 16 16" version="1.1" width="32" aria-hidden="true"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path></svg>
</a>

  </div>

  <div class="Header-item d-lg-none">
    <button class="Header-link btn-link js-details-target" type="button" aria-label="Toggle navigation" aria-expanded="false">
      <svg height="24" class="octicon octicon-three-bars" viewBox="0 0 16 16" version="1.1" width="24" aria-hidden="true"><path fill-rule="evenodd" d="M1 2.75A.75.75 0 011.75 2h12.5a.75.75 0 110 1.5H1.75A.75.75 0 011 2.75zm0 5A.75.75 0 011.75 7h12.5a.75.75 0 110 1.5H1.75A.75.75 0 011 7.75zM1.75 12a.75.75 0 100 1.5h12.5a.75.75 0 100-1.5H1.75z"></path></svg>
    </button>
  </div>

  <div class="Header-item Header-item--full flex-column flex-lg-row width-full flex-order-2 flex-lg-order-none mr-0 mr-lg-3 mt-3 mt-lg-0 Details-content--hidden">
        <div class="header-search header-search-current js-header-search-current  flex-self-stretch flex-lg-self-auto mr-0 mr-lg-3 mb-3 mb-lg-0 scoped-search site-scoped-search js-site-search position-relative js-jump-to js-header-search-current-jump-to"
  role="combobox"
  aria-owns="jump-to-results"
  aria-label="Search or jump to"
  aria-haspopup="listbox"
  aria-expanded="false"
>
  <div class="position-relative">
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="js-site-search-form" role="search" aria-label="Site" data-scope-type="Repository" data-scope-id="265970691" data-scoped-search-url="/pyliu47/covidcompare_deprecated/search" data-unscoped-search-url="/search" action="/pyliu47/covidcompare_deprecated/search" accept-charset="UTF-8" method="get">
      <label class="form-control input-sm header-search-wrapper p-0 header-search-wrapper-jump-to position-relative d-flex flex-justify-between flex-items-center js-chromeless-input-container">
        <input type="text"
          class="form-control input-sm header-search-input jump-to-field js-jump-to-field js-site-search-focus js-site-search-field is-clearable"
          data-hotkey="s,/"
          name="q"
          value=""
          placeholder="Search or jump to…"
          data-unscoped-placeholder="Search or jump to…"
          data-scoped-placeholder="Search or jump to…"
          autocapitalize="off"
          aria-autocomplete="list"
          aria-controls="jump-to-results"
          aria-label="Search or jump to…"
          data-jump-to-suggestions-path="/_graphql/GetSuggestedNavigationDestinations"
          spellcheck="false"
          autocomplete="off"
          >
          <input type="hidden" value="wW6V4kax05MnaN2mkWOq5diP/hahY8fQf0m23IwOi6c19IGgS+kLfVq/FupzVCEk3rDiUK3eN2D/w0b8bGEV3w==" data-csrf="true" class="js-data-jump-to-suggestions-path-csrf" />
          <input type="hidden" class="js-site-search-type-field" name="type" >
            <img src="https://github.githubassets.com/images/search-key-slash.svg" alt="" class="mr-2 header-search-key-slash">

            <div class="Box position-absolute overflow-hidden d-none jump-to-suggestions js-jump-to-suggestions-container">
              
<ul class="d-none js-jump-to-suggestions-template-container">
  

<li class="d-flex flex-justify-start flex-items-center p-0 f5 navigation-item js-navigation-item js-jump-to-suggestion" role="option">
  <a tabindex="-1" class="no-underline d-flex flex-auto flex-items-center jump-to-suggestions-path js-jump-to-suggestion-path js-navigation-open p-2" href="">
    <div class="jump-to-octicon js-jump-to-octicon flex-shrink-0 mr-2 text-center d-none">
      <svg height="16" width="16" class="octicon octicon-repo flex-shrink-0 js-jump-to-octicon-repo d-none" title="Repository" aria-label="Repository" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M2 2.5A2.5 2.5 0 014.5 0h8.75a.75.75 0 01.75.75v12.5a.75.75 0 01-.75.75h-2.5a.75.75 0 110-1.5h1.75v-2h-8a1 1 0 00-.714 1.7.75.75 0 01-1.072 1.05A2.495 2.495 0 012 11.5v-9zm10.5-1V9h-8c-.356 0-.694.074-1 .208V2.5a1 1 0 011-1h8zM5 12.25v3.25a.25.25 0 00.4.2l1.45-1.087a.25.25 0 01.3 0L8.6 15.7a.25.25 0 00.4-.2v-3.25a.25.25 0 00-.25-.25h-3.5a.25.25 0 00-.25.25z"></path></svg>
      <svg height="16" width="16" class="octicon octicon-project flex-shrink-0 js-jump-to-octicon-project d-none" title="Project" aria-label="Project" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M1.75 0A1.75 1.75 0 000 1.75v12.5C0 15.216.784 16 1.75 16h12.5A1.75 1.75 0 0016 14.25V1.75A1.75 1.75 0 0014.25 0H1.75zM1.5 1.75a.25.25 0 01.25-.25h12.5a.25.25 0 01.25.25v12.5a.25.25 0 01-.25.25H1.75a.25.25 0 01-.25-.25V1.75zM11.75 3a.75.75 0 00-.75.75v7.5a.75.75 0 001.5 0v-7.5a.75.75 0 00-.75-.75zm-8.25.75a.75.75 0 011.5 0v5.5a.75.75 0 01-1.5 0v-5.5zM8 3a.75.75 0 00-.75.75v3.5a.75.75 0 001.5 0v-3.5A.75.75 0 008 3z"></path></svg>
      <svg height="16" width="16" class="octicon octicon-search flex-shrink-0 js-jump-to-octicon-search d-none" title="Search" aria-label="Search" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z"></path></svg>
    </div>

    <img class="avatar mr-2 flex-shrink-0 js-jump-to-suggestion-avatar d-none" alt="" aria-label="Team" src="" width="28" height="28">

    <div class="jump-to-suggestion-name js-jump-to-suggestion-name flex-auto overflow-hidden text-left no-wrap css-truncate css-truncate-target">
    </div>

    <div class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none js-jump-to-badge-search">
      <span class="js-jump-to-badge-search-text-default d-none" aria-label="in this repository">
        In this repository
      </span>
      <span class="js-jump-to-badge-search-text-global d-none" aria-label="in all of GitHub">
        All GitHub
      </span>
      <span aria-hidden="true" class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>

    <div aria-hidden="true" class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none d-on-nav-focus js-jump-to-badge-jump">
      Jump to
      <span class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>
  </a>
</li>

</ul>

<ul class="d-none js-jump-to-no-results-template-container">
  <li class="d-flex flex-justify-center flex-items-center f5 d-none js-jump-to-suggestion p-2">
    <span class="text-gray">No suggested jump to results</span>
  </li>
</ul>

<ul id="jump-to-results" role="listbox" class="p-0 m-0 js-navigation-container jump-to-suggestions-results-container js-jump-to-suggestions-results-container">
  

<li class="d-flex flex-justify-start flex-items-center p-0 f5 navigation-item js-navigation-item js-jump-to-scoped-search d-none" role="option">
  <a tabindex="-1" class="no-underline d-flex flex-auto flex-items-center jump-to-suggestions-path js-jump-to-suggestion-path js-navigation-open p-2" href="">
    <div class="jump-to-octicon js-jump-to-octicon flex-shrink-0 mr-2 text-center d-none">
      <svg height="16" width="16" class="octicon octicon-repo flex-shrink-0 js-jump-to-octicon-repo d-none" title="Repository" aria-label="Repository" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M2 2.5A2.5 2.5 0 014.5 0h8.75a.75.75 0 01.75.75v12.5a.75.75 0 01-.75.75h-2.5a.75.75 0 110-1.5h1.75v-2h-8a1 1 0 00-.714 1.7.75.75 0 01-1.072 1.05A2.495 2.495 0 012 11.5v-9zm10.5-1V9h-8c-.356 0-.694.074-1 .208V2.5a1 1 0 011-1h8zM5 12.25v3.25a.25.25 0 00.4.2l1.45-1.087a.25.25 0 01.3 0L8.6 15.7a.25.25 0 00.4-.2v-3.25a.25.25 0 00-.25-.25h-3.5a.25.25 0 00-.25.25z"></path></svg>
      <svg height="16" width="16" class="octicon octicon-project flex-shrink-0 js-jump-to-octicon-project d-none" title="Project" aria-label="Project" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M1.75 0A1.75 1.75 0 000 1.75v12.5C0 15.216.784 16 1.75 16h12.5A1.75 1.75 0 0016 14.25V1.75A1.75 1.75 0 0014.25 0H1.75zM1.5 1.75a.25.25 0 01.25-.25h12.5a.25.25 0 01.25.25v12.5a.25.25 0 01-.25.25H1.75a.25.25 0 01-.25-.25V1.75zM11.75 3a.75.75 0 00-.75.75v7.5a.75.75 0 001.5 0v-7.5a.75.75 0 00-.75-.75zm-8.25.75a.75.75 0 011.5 0v5.5a.75.75 0 01-1.5 0v-5.5zM8 3a.75.75 0 00-.75.75v3.5a.75.75 0 001.5 0v-3.5A.75.75 0 008 3z"></path></svg>
      <svg height="16" width="16" class="octicon octicon-search flex-shrink-0 js-jump-to-octicon-search d-none" title="Search" aria-label="Search" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z"></path></svg>
    </div>

    <img class="avatar mr-2 flex-shrink-0 js-jump-to-suggestion-avatar d-none" alt="" aria-label="Team" src="" width="28" height="28">

    <div class="jump-to-suggestion-name js-jump-to-suggestion-name flex-auto overflow-hidden text-left no-wrap css-truncate css-truncate-target">
    </div>

    <div class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none js-jump-to-badge-search">
      <span class="js-jump-to-badge-search-text-default d-none" aria-label="in this repository">
        In this repository
      </span>
      <span class="js-jump-to-badge-search-text-global d-none" aria-label="in all of GitHub">
        All GitHub
      </span>
      <span aria-hidden="true" class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>

    <div aria-hidden="true" class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none d-on-nav-focus js-jump-to-badge-jump">
      Jump to
      <span class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>
  </a>
</li>

  

<li class="d-flex flex-justify-start flex-items-center p-0 f5 navigation-item js-navigation-item js-jump-to-global-search d-none" role="option">
  <a tabindex="-1" class="no-underline d-flex flex-auto flex-items-center jump-to-suggestions-path js-jump-to-suggestion-path js-navigation-open p-2" href="">
    <div class="jump-to-octicon js-jump-to-octicon flex-shrink-0 mr-2 text-center d-none">
      <svg height="16" width="16" class="octicon octicon-repo flex-shrink-0 js-jump-to-octicon-repo d-none" title="Repository" aria-label="Repository" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M2 2.5A2.5 2.5 0 014.5 0h8.75a.75.75 0 01.75.75v12.5a.75.75 0 01-.75.75h-2.5a.75.75 0 110-1.5h1.75v-2h-8a1 1 0 00-.714 1.7.75.75 0 01-1.072 1.05A2.495 2.495 0 012 11.5v-9zm10.5-1V9h-8c-.356 0-.694.074-1 .208V2.5a1 1 0 011-1h8zM5 12.25v3.25a.25.25 0 00.4.2l1.45-1.087a.25.25 0 01.3 0L8.6 15.7a.25.25 0 00.4-.2v-3.25a.25.25 0 00-.25-.25h-3.5a.25.25 0 00-.25.25z"></path></svg>
      <svg height="16" width="16" class="octicon octicon-project flex-shrink-0 js-jump-to-octicon-project d-none" title="Project" aria-label="Project" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M1.75 0A1.75 1.75 0 000 1.75v12.5C0 15.216.784 16 1.75 16h12.5A1.75 1.75 0 0016 14.25V1.75A1.75 1.75 0 0014.25 0H1.75zM1.5 1.75a.25.25 0 01.25-.25h12.5a.25.25 0 01.25.25v12.5a.25.25 0 01-.25.25H1.75a.25.25 0 01-.25-.25V1.75zM11.75 3a.75.75 0 00-.75.75v7.5a.75.75 0 001.5 0v-7.5a.75.75 0 00-.75-.75zm-8.25.75a.75.75 0 011.5 0v5.5a.75.75 0 01-1.5 0v-5.5zM8 3a.75.75 0 00-.75.75v3.5a.75.75 0 001.5 0v-3.5A.75.75 0 008 3z"></path></svg>
      <svg height="16" width="16" class="octicon octicon-search flex-shrink-0 js-jump-to-octicon-search d-none" title="Search" aria-label="Search" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z"></path></svg>
    </div>

    <img class="avatar mr-2 flex-shrink-0 js-jump-to-suggestion-avatar d-none" alt="" aria-label="Team" src="" width="28" height="28">

    <div class="jump-to-suggestion-name js-jump-to-suggestion-name flex-auto overflow-hidden text-left no-wrap css-truncate css-truncate-target">
    </div>

    <div class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none js-jump-to-badge-search">
      <span class="js-jump-to-badge-search-text-default d-none" aria-label="in this repository">
        In this repository
      </span>
      <span class="js-jump-to-badge-search-text-global d-none" aria-label="in all of GitHub">
        All GitHub
      </span>
      <span aria-hidden="true" class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>

    <div aria-hidden="true" class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none d-on-nav-focus js-jump-to-badge-jump">
      Jump to
      <span class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>
  </a>
</li>


    <li class="d-flex flex-justify-center flex-items-center p-0 f5 js-jump-to-suggestion">
      <img src="https://github.githubassets.com/images/spinners/octocat-spinner-128.gif" alt="Octocat Spinner Icon" class="m-2" width="28">
    </li>
</ul>

            </div>
      </label>
</form>  </div>
</div>


    <nav class="d-flex flex-column flex-lg-row flex-self-stretch flex-lg-self-auto" aria-label="Global">
    <a class="Header-link py-lg-3 d-block d-lg-none py-2 border-top border-lg-top-0 border-white-fade-15" data-ga-click="Header, click, Nav menu - item:dashboard:user" aria-label="Dashboard" href="/dashboard">
      Dashboard
</a>
  <a class="js-selected-navigation-item Header-link py-lg-3  mr-0 mr-lg-3 py-2 border-top border-lg-top-0 border-white-fade-15" data-hotkey="g p" data-ga-click="Header, click, Nav menu - item:pulls context:user" aria-label="Pull requests you created" data-selected-links="/pulls /pulls/assigned /pulls/mentioned /pulls" href="/pulls">
    Pull requests
</a>
  <a class="js-selected-navigation-item Header-link py-lg-3  mr-0 mr-lg-3 py-2 border-top border-lg-top-0 border-white-fade-15" data-hotkey="g i" data-ga-click="Header, click, Nav menu - item:issues context:user" aria-label="Issues you created" data-selected-links="/issues /issues/assigned /issues/mentioned /issues" href="/issues">
    Issues
</a>

    <div class="mr-0 mr-lg-3 py-2 py-lg-0 border-top border-lg-top-0 border-white-fade-15">
      <a class="js-selected-navigation-item Header-link py-lg-3 d-inline-block" data-ga-click="Header, click, Nav menu - item:marketplace context:user" data-octo-click="marketplace_click" data-octo-dimensions="location:nav_bar" data-selected-links=" /marketplace" href="/marketplace">
        Marketplace
</a>      

    </div>

  <a class="js-selected-navigation-item Header-link py-lg-3  mr-0 mr-lg-3 py-2 border-top border-lg-top-0 border-white-fade-15" data-ga-click="Header, click, Nav menu - item:explore" data-selected-links="/explore /trending /trending/developers /integrations /integrations/feature/code /integrations/feature/collaborate /integrations/feature/ship showcases showcases_search showcases_landing /explore" href="/explore">
    Explore
</a>


    <a class="Header-link d-block d-lg-none mr-0 mr-lg-3 py-2 py-lg-3 border-top border-lg-top-0 border-white-fade-15" href="/pyliu47">
      <img class="avatar avatar-user" src="https://avatars3.githubusercontent.com/u/62630460?s=40&amp;v=4" width="20" height="20" alt="@pyliu47" />
      pyliu47
</a>
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form action="/logout" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token" value="B7kJoh19Txj6lSIucVyCYhgElIq8PkKlOR3UfvTeJ7IN+aWkXajp3yTWZ144ElfiQf4WEh+qBPwwaja0ptwTpA==" />
      <button type="submit" class="Header-link mr-0 mr-lg-3 py-2 py-lg-3 border-top border-lg-top-0 border-white-fade-15 d-lg-none btn-link d-block width-full text-left" data-ga-click="Header, sign out, icon:logout" style="padding-left: 2px;">
        <svg class="octicon octicon-sign-out v-align-middle" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M2 2.75C2 1.784 2.784 1 3.75 1h2.5a.75.75 0 010 1.5h-2.5a.25.25 0 00-.25.25v10.5c0 .138.112.25.25.25h2.5a.75.75 0 010 1.5h-2.5A1.75 1.75 0 012 13.25V2.75zm10.44 4.5H6.75a.75.75 0 000 1.5h5.69l-1.97 1.97a.75.75 0 101.06 1.06l3.25-3.25a.75.75 0 000-1.06l-3.25-3.25a.75.75 0 10-1.06 1.06l1.97 1.97z"></path></svg>
        Sign out
      </button>
</form></nav>

  </div>

  <div class="Header-item Header-item--full flex-justify-center d-lg-none position-relative">
    <a class="Header-link" href="https://github.com/" data-hotkey="g d"
  aria-label="Homepage " data-ga-click="Header, go to dashboard, icon:logo">
  <svg class="octicon octicon-mark-github v-align-middle" height="32" viewBox="0 0 16 16" version="1.1" width="32" aria-hidden="true"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path></svg>
</a>

  </div>

  <div class="Header-item mr-0 mr-lg-3 flex-order-1 flex-lg-order-none">
    
    <a aria-label="You have no unread notifications" class="Header-link notification-indicator position-relative tooltipped tooltipped-sw js-socket-channel js-notification-indicator" data-hotkey="g n" data-ga-click="Header, go to notifications, icon:read" data-channel="eyJjIjoibm90aWZpY2F0aW9uLWNoYW5nZWQ6NjI2MzA0NjAiLCJ0IjoxNTk0NjMxMzAyfQ==--2aa8e10f205369c6b750124d57e469bf7089045c1e1cbf61f6358d38d709d07e" href="/notifications">
        <span class="js-indicator-modifier mail-status "></span>
        <svg class="octicon octicon-bell" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path d="M8 16a2 2 0 001.985-1.75c.017-.137-.097-.25-.235-.25h-3.5c-.138 0-.252.113-.235.25A2 2 0 008 16z"></path><path fill-rule="evenodd" d="M8 1.5A3.5 3.5 0 004.5 5v2.947c0 .346-.102.683-.294.97l-1.703 2.556a.018.018 0 00-.003.01l.001.006c0 .002.002.004.004.006a.017.017 0 00.006.004l.007.001h10.964l.007-.001a.016.016 0 00.006-.004.016.016 0 00.004-.006l.001-.007a.017.017 0 00-.003-.01l-1.703-2.554a1.75 1.75 0 01-.294-.97V5A3.5 3.5 0 008 1.5zM3 5a5 5 0 0110 0v2.947c0 .05.015.098.042.139l1.703 2.555A1.518 1.518 0 0113.482 13H2.518a1.518 1.518 0 01-1.263-2.36l1.703-2.554A.25.25 0 003 7.947V5z"></path></svg>
</a>
  </div>


  <div class="Header-item position-relative d-none d-lg-flex">
    <details class="details-overlay details-reset">
  <summary class="Header-link"
      aria-label="Create new…"
      data-ga-click="Header, create new, icon:add">
    <svg class="octicon octicon-plus" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8 2a.75.75 0 01.75.75v4.5h4.5a.75.75 0 010 1.5h-4.5v4.5a.75.75 0 01-1.5 0v-4.5h-4.5a.75.75 0 010-1.5h4.5v-4.5A.75.75 0 018 2z"></path></svg> <span class="dropdown-caret"></span>
  </summary>
  <details-menu class="dropdown-menu dropdown-menu-sw mt-n2">
    
<a role="menuitem" class="dropdown-item" href="/new" data-ga-click="Header, create new repository">
  New repository
</a>

  <a role="menuitem" class="dropdown-item" href="/new/import" data-ga-click="Header, import a repository">
    Import repository
  </a>

<a role="menuitem" class="dropdown-item" href="https://gist.github.com/" data-ga-click="Header, create new gist">
  New gist
</a>

  <a role="menuitem" class="dropdown-item" href="/organizations/new" data-ga-click="Header, create new organization">
    New organization
  </a>


  <div role="none" class="dropdown-divider"></div>
  <div class="dropdown-header">
    <span title="pyliu47/covidcompare_deprecated">This repository</span>
  </div>
    <a role="menuitem" class="dropdown-item" href="/pyliu47/covidcompare_deprecated/issues/new/choose" data-ga-click="Header, create new issue" data-skip-pjax>
      New issue
    </a>


  </details-menu>
</details>

  </div>

  <div class="Header-item position-relative mr-0 d-none d-lg-flex">
    
  <details class="details-overlay details-reset js-feature-preview-indicator-container" data-feature-preview-indicator-src="/users/pyliu47/feature_preview/indicator_check">

  <summary class="Header-link"
    aria-label="View profile and more"
    data-ga-click="Header, show menu, icon:avatar">
    <img
  alt="@pyliu47"
  width="20"
  height="20"
  src="https://avatars0.githubusercontent.com/u/62630460?s=60&amp;v=4"
  class="avatar avatar-user " />

      <span class="feature-preview-indicator js-feature-preview-indicator" style="top: 10px;" hidden></span>
    <span class="dropdown-caret"></span>
  </summary>
  <details-menu class="dropdown-menu dropdown-menu-sw mt-n2" style="width: 180px" >
    <div class="header-nav-current-user css-truncate"><a role="menuitem" class="no-underline user-profile-link px-3 pt-2 pb-2 mb-n2 mt-n1 d-block" href="/pyliu47" data-ga-click="Header, go to profile, text:Signed in as">Signed in as <strong class="css-truncate-target">pyliu47</strong></a></div>
    <div role="none" class="dropdown-divider"></div>

      <div class="pl-3 pr-3 f6 user-status-container js-user-status-context lh-condensed" data-url="/users/status?compact=1&amp;link_mentions=0&amp;truncate=1">
        
<div class="js-user-status-container rounded-1 px-2 py-1 mt-2 border"
  data-team-hovercards-enabled>
  <details class="js-user-status-details details-reset details-overlay details-overlay-dark">
    <summary class="btn-link btn-block link-gray no-underline js-toggle-user-status-edit toggle-user-status-edit "
      role="menuitem" data-hydro-click="{&quot;event_type&quot;:&quot;user_profile.click&quot;,&quot;payload&quot;:{&quot;profile_user_id&quot;:62630460,&quot;target&quot;:&quot;EDIT_USER_STATUS&quot;,&quot;user_id&quot;:62630460,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;}}" data-hydro-click-hmac="f8e16cf32b63940e22bfe496d98c55683a2a68d4b5af8d89f38a6621670584ed">
      <div class="d-flex flex-items-center flex-items-stretch">
        <div class="f6 lh-condensed user-status-header d-flex user-status-emoji-only-header circle">
          <div class="user-status-emoji-container flex-shrink-0 mr-2 d-flex flex-items-center flex-justify-center lh-condensed-ultra v-align-bottom">
            <svg class="octicon octicon-smiley" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z"></path></svg>
          </div>
        </div>
        <div class="
          
           user-status-message-wrapper f6 min-width-0"
           style="line-height: 20px;" >
          <div class="css-truncate css-truncate-target width-fit text-gray-dark text-left">
              <span class="text-gray">Set status</span>
          </div>
        </div>
      </div>
    </summary>
    <details-dialog class="details-dialog rounded-1 anim-fade-in fast Box Box--overlay" role="dialog" tabindex="-1">
      <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="position-relative flex-auto js-user-status-form" action="/users/status?circle=0&amp;compact=1&amp;link_mentions=0&amp;truncate=1" accept-charset="UTF-8" method="post"><input type="hidden" name="_method" value="put" /><input type="hidden" name="authenticity_token" value="3Dk+2gWX1wHfI2VCO/r832Ktcs0ZfIFjThYQQlVvLpaJOGF+PtRznfvqO9V6dkWLxg+p1AmiX7FTejUfe+0wbw==" />
        <div class="Box-header bg-gray border-bottom p-3">
          <button class="Box-btn-octicon js-toggle-user-status-edit btn-octicon float-right" type="reset" aria-label="Close dialog" data-close-dialog>
            <svg class="octicon octicon-x" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z"></path></svg>
          </button>
          <h3 class="Box-title f5 text-bold text-gray-dark">Edit status</h3>
        </div>
        <input type="hidden" name="emoji" class="js-user-status-emoji-field" value="">
        <input type="hidden" name="organization_id" class="js-user-status-org-id-field" value="">
        <div class="px-3 py-2 text-gray-dark">
          <div class="js-characters-remaining-container position-relative mt-2">
            <div class="input-group d-table form-group my-0 js-user-status-form-group">
              <span class="input-group-button d-table-cell v-align-middle" style="width: 1%">
                <button type="button" aria-label="Choose an emoji" class="btn-outline btn js-toggle-user-status-emoji-picker btn-open-emoji-picker p-0">
                  <span class="js-user-status-original-emoji" hidden></span>
                  <span class="js-user-status-custom-emoji"></span>
                  <span class="js-user-status-no-emoji-icon" >
                    <svg class="octicon octicon-smiley" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z"></path></svg>
                  </span>
                </button>
              </span>
              <text-expander keys=": @" data-mention-url="/autocomplete/user-suggestions" data-emoji-url="/autocomplete/emoji">
                <input
                  type="text"
                  autocomplete="off"
                  data-no-org-url="/autocomplete/user-suggestions"
                  data-org-url="/suggestions?mention_suggester=1"
                  data-maxlength="80"
                  class="d-table-cell width-full form-control js-user-status-message-field js-characters-remaining-field"
                  placeholder="What's happening?"
                  name="message"
                  value=""
                  aria-label="What is your current status?">
              </text-expander>
              <div class="error">Could not update your status, please try again.</div>
            </div>
            <div style="margin-left: 53px" class="my-1 text-small label-characters-remaining js-characters-remaining" data-suffix="remaining" hidden>
              80 remaining
            </div>
          </div>
          <include-fragment class="js-user-status-emoji-picker" data-url="/users/status/emoji"></include-fragment>
          <div class="overflow-auto ml-n3 mr-n3 px-3 border-bottom" style="max-height: 33vh">
            <div class="user-status-suggestions js-user-status-suggestions collapsed overflow-hidden">
              <h4 class="f6 text-normal my-3">Suggestions:</h4>
              <div class="mx-3 mt-2 clearfix">
                  <div class="float-left col-6">
                      <button type="button" value=":palm_tree:" class="d-flex flex-items-baseline flex-items-stretch lh-condensed f6 btn-link link-gray no-underline js-predefined-user-status mb-1">
                        <div class="emoji-status-width mr-2 v-align-middle js-predefined-user-status-emoji">
                          <g-emoji alias="palm_tree" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f334.png">🌴</g-emoji>
                        </div>
                        <div class="d-flex flex-items-center no-underline js-predefined-user-status-message ws-normal text-left" style="border-left: 1px solid transparent">
                          On vacation
                        </div>
                      </button>
                      <button type="button" value=":face_with_thermometer:" class="d-flex flex-items-baseline flex-items-stretch lh-condensed f6 btn-link link-gray no-underline js-predefined-user-status mb-1">
                        <div class="emoji-status-width mr-2 v-align-middle js-predefined-user-status-emoji">
                          <g-emoji alias="face_with_thermometer" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f912.png">🤒</g-emoji>
                        </div>
                        <div class="d-flex flex-items-center no-underline js-predefined-user-status-message ws-normal text-left" style="border-left: 1px solid transparent">
                          Out sick
                        </div>
                      </button>
                  </div>
                  <div class="float-left col-6">
                      <button type="button" value=":house:" class="d-flex flex-items-baseline flex-items-stretch lh-condensed f6 btn-link link-gray no-underline js-predefined-user-status mb-1">
                        <div class="emoji-status-width mr-2 v-align-middle js-predefined-user-status-emoji">
                          <g-emoji alias="house" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f3e0.png">🏠</g-emoji>
                        </div>
                        <div class="d-flex flex-items-center no-underline js-predefined-user-status-message ws-normal text-left" style="border-left: 1px solid transparent">
                          Working from home
                        </div>
                      </button>
                      <button type="button" value=":dart:" class="d-flex flex-items-baseline flex-items-stretch lh-condensed f6 btn-link link-gray no-underline js-predefined-user-status mb-1">
                        <div class="emoji-status-width mr-2 v-align-middle js-predefined-user-status-emoji">
                          <g-emoji alias="dart" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f3af.png">🎯</g-emoji>
                        </div>
                        <div class="d-flex flex-items-center no-underline js-predefined-user-status-message ws-normal text-left" style="border-left: 1px solid transparent">
                          Focusing
                        </div>
                      </button>
                  </div>
              </div>
            </div>
            <div class="user-status-limited-availability-container">
              <div class="form-checkbox my-0">
                <input type="checkbox" name="limited_availability" value="1" class="js-user-status-limited-availability-checkbox" data-default-message="I may be slow to respond." aria-describedby="limited-availability-help-text-truncate-true-compact-true" id="limited-availability-truncate-true-compact-true">
                <label class="d-block f5 text-gray-dark mb-1" for="limited-availability-truncate-true-compact-true">
                  Busy
                </label>
                <p class="note" id="limited-availability-help-text-truncate-true-compact-true">
                  When others mention you, assign you, or request your review,
                  GitHub will let them know that you have limited availability.
                </p>
              </div>
            </div>
          </div>
          <div class="d-inline-block f5 mr-2 pt-3 pb-2" >
  <div class="d-inline-block mr-1">
    Clear status
  </div>

  <details class="js-user-status-expire-drop-down f6 dropdown details-reset details-overlay d-inline-block mr-2">
    <summary class="f5 btn-link link-gray-dark border px-2 py-1 rounded-1" aria-haspopup="true">
      <div class="js-user-status-expiration-interval-selected d-inline-block v-align-baseline">
        Never
      </div>
      <div class="dropdown-caret"></div>
    </summary>

    <ul class="dropdown-menu dropdown-menu-se pl-0 overflow-auto" style="width: 220px; max-height: 15.5em">
      <li>
        <button type="button" class="btn-link dropdown-item js-user-status-expire-button ws-normal" title="Never">
          <span class="d-inline-block text-bold mb-1">Never</span>
          <div class="f6 lh-condensed">Keep this status until you clear your status or edit your status.</div>
        </button>
      </li>
      <li class="dropdown-divider" role="none"></li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="in 30 minutes" value="2020-07-13T02:38:22-07:00">
            in 30 minutes
          </button>
        </li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="in 1 hour" value="2020-07-13T03:08:22-07:00">
            in 1 hour
          </button>
        </li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="in 4 hours" value="2020-07-13T06:08:22-07:00">
            in 4 hours
          </button>
        </li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="today" value="2020-07-13T23:59:59-07:00">
            today
          </button>
        </li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="this week" value="2020-07-19T23:59:59-07:00">
            this week
          </button>
        </li>
    </ul>
  </details>
  <input class="js-user-status-expiration-date-input" type="hidden" name="expires_at" value="">
</div>

          <include-fragment class="js-user-status-org-picker" data-url="/users/status/organizations"></include-fragment>
        </div>
        <div class="d-flex flex-items-center flex-justify-between p-3 border-top">
          <button type="submit" disabled class="width-full btn btn-primary mr-2 js-user-status-submit">
            Set status
          </button>
          <button type="button" disabled class="width-full js-clear-user-status-button btn ml-2 ">
            Clear status
          </button>
        </div>
</form>    </details-dialog>
  </details>
</div>

      </div>
      <div role="none" class="dropdown-divider"></div>

    <a role="menuitem" class="dropdown-item" href="/pyliu47" data-ga-click="Header, go to profile, text:your profile" data-hydro-click="{&quot;event_type&quot;:&quot;global_header.user_menu_dropdown.click&quot;,&quot;payload&quot;:{&quot;request_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;target&quot;:&quot;YOUR_PROFILE&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="803619195ca74ccaf5713bd204c2c273937df53df9c3293626974039526e1fb5" >Your profile</a>

    <a role="menuitem" class="dropdown-item" href="/pyliu47?tab=repositories" data-ga-click="Header, go to repositories, text:your repositories" data-hydro-click="{&quot;event_type&quot;:&quot;global_header.user_menu_dropdown.click&quot;,&quot;payload&quot;:{&quot;request_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;target&quot;:&quot;YOUR_REPOSITORIES&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="30738f201266c0ef5afacc2f8514eed73f7accb87db9ac74d3f2aee50e061811" >Your repositories</a>


    <a role="menuitem" class="dropdown-item" href="/pyliu47?tab=projects" data-ga-click="Header, go to projects, text:your projects" data-hydro-click="{&quot;event_type&quot;:&quot;global_header.user_menu_dropdown.click&quot;,&quot;payload&quot;:{&quot;request_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;target&quot;:&quot;YOUR_PROJECTS&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="20414ff27f497117e3c228bc5f63ff0e834f232c5870b76da55826e7e27c15cd" >Your projects</a>


    <a role="menuitem" class="dropdown-item" href="/pyliu47?tab=stars" data-ga-click="Header, go to starred repos, text:your stars" data-hydro-click="{&quot;event_type&quot;:&quot;global_header.user_menu_dropdown.click&quot;,&quot;payload&quot;:{&quot;request_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;target&quot;:&quot;YOUR_STARS&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="d2f3a53c75c540d8176176948f18cedd41f971458bc7349a583ac93d9a3defa8" >Your stars</a>
      <a role="menuitem" class="dropdown-item" href="https://gist.github.com/mine" data-ga-click="Header, your gists, text:your gists" data-hydro-click="{&quot;event_type&quot;:&quot;global_header.user_menu_dropdown.click&quot;,&quot;payload&quot;:{&quot;request_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;target&quot;:&quot;YOUR_GISTS&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="c65c64e2890d114af36321842c3eec63621787614c210b505fb67a51d770fc51" >Your gists</a>





    <div role="none" class="dropdown-divider"></div>
      <a role="menuitem" class="dropdown-item" href="/settings/billing" data-ga-click="Header, go to billing, text:upgrade" data-hydro-click="{&quot;event_type&quot;:&quot;global_header.user_menu_dropdown.click&quot;,&quot;payload&quot;:{&quot;request_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;target&quot;:&quot;UPGRADE&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="bf27a67af0c93522b660345fd4df26afe8e3c6ab17b0f22ba2db0661a3c363b9" >Upgrade</a>
      
<div id="feature-enrollment-toggle" class="hide-sm hide-md feature-preview-details position-relative">
  <button
    type="button"
    class="dropdown-item btn-link"
    role="menuitem"
    data-feature-preview-trigger-url="/users/pyliu47/feature_previews"
    data-feature-preview-close-details="{&quot;event_type&quot;:&quot;feature_preview.clicks.close_modal&quot;,&quot;payload&quot;:{&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}"
    data-feature-preview-close-hmac="1205f11e9e299904ca6993c0053fac29020b34c681a3fd2373a7d1523ec2e667"
    data-hydro-click="{&quot;event_type&quot;:&quot;feature_preview.clicks.open_modal&quot;,&quot;payload&quot;:{&quot;link_location&quot;:&quot;user_dropdown&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}"
    data-hydro-click-hmac="7a1a0d6757b10252424786ff6657a857642a9e6eee591db947a73881fb751700"
  >
    Feature preview
  </button>
    <span class="feature-preview-indicator js-feature-preview-indicator" hidden></span>
</div>

    <a role="menuitem" class="dropdown-item" href="https://help.github.com" data-ga-click="Header, go to help, text:help" data-hydro-click="{&quot;event_type&quot;:&quot;global_header.user_menu_dropdown.click&quot;,&quot;payload&quot;:{&quot;request_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;target&quot;:&quot;HELP&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="6dce17b8a531800a6e5d1b7ed5334cdc9f5ef14be26aff586708ea1498989bbe" >Help</a>
    <a role="menuitem" class="dropdown-item" href="/settings/profile" data-ga-click="Header, go to settings, icon:settings" data-hydro-click="{&quot;event_type&quot;:&quot;global_header.user_menu_dropdown.click&quot;,&quot;payload&quot;:{&quot;request_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;target&quot;:&quot;SETTINGS&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="9258759cbb5c45b6ff3ab2b3ee1a6c7fb31e37d1016ca0b334e9b21eb292c8c6" >Settings</a>
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="logout-form" action="/logout" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token" value="gKvGz7WDmXcLRe+d94hbUxTkxCTHd+VmENpaletDa02K62rJ9VY/sNUGqu2+xo7TTR5GvGTjoz8ZrbhfuUFfWw==" />
      
      <button type="submit" class="dropdown-item dropdown-signout" data-ga-click="Header, sign out, icon:logout" data-hydro-click="{&quot;event_type&quot;:&quot;global_header.user_menu_dropdown.click&quot;,&quot;payload&quot;:{&quot;request_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;target&quot;:&quot;SIGN_OUT&quot;,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="5b1194aa9718ad84ad8364357254e6156f64dff83d6810a772f8dd1ee9ce969c"  role="menuitem">
        Sign out
      </button>
      <input type="text" name="required_field_6459" hidden="hidden" class="form-control" /><input type="hidden" name="timestamp" value="1594631302472" class="form-control" /><input type="hidden" name="timestamp_secret" value="9698748ee1989cb78088c3fcbcb98cdce9fc041d39b49f832dba891c542d5de5" class="form-control" />
</form>  </details-menu>
</details>

  </div>

</header>

          

    </div>

  <div id="start-of-content" class="show-on-focus"></div>




    <div id="js-flash-container">


  <template class="js-flash-template">
    <div class="flash flash-full  js-flash-template-container">
  <div class=" px-2" >
    <button class="flash-close js-flash-close" type="button" aria-label="Dismiss this message">
      <svg class="octicon octicon-x" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z"></path></svg>
    </button>
    
      <div class="js-flash-template-message"></div>

  </div>
</div>
  </template>
</div>


  

  <include-fragment class="js-notification-shelf-include-fragment" data-base-src="https://github.com/notifications/beta/shelf"></include-fragment>



  <div
    class="application-main "
    data-commit-hovercards-enabled
    data-discussion-hovercards-enabled
    data-issue-and-pr-hovercards-enabled
  >
        <div itemscope itemtype="http://schema.org/SoftwareSourceCode" class="">
    <main  >
      

  










  <div class="pagehead repohead readability-menu bg-gray-light pb-0 pt-3 border-0 mb-5">

    <div class="d-flex mb-3 px-3 px-md-4 px-lg-5">

      <div class="flex-auto min-width-0 width-fit mr-3">
        <h1 class="private  d-flex flex-wrap flex-items-center break-word float-none f3">
    <svg class="octicon octicon-lock" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 4v2h-.25A1.75 1.75 0 002 7.75v5.5c0 .966.784 1.75 1.75 1.75h8.5A1.75 1.75 0 0014 13.25v-5.5A1.75 1.75 0 0012.25 6H12V4a4 4 0 10-8 0zm6.5 2V4a2.5 2.5 0 00-5 0v2h5zM12 7.5h.25a.25.25 0 01.25.25v5.5a.25.25 0 01-.25.25h-8.5a.25.25 0 01-.25-.25v-5.5a.25.25 0 01.25-.25H12z"></path></svg>
  <span class="author ml-2 flex-self-stretch" itemprop="author">
    <a class="url fn" rel="author" data-hovercard-type="user" data-hovercard-url="/users/pyliu47/hovercard" data-octo-click="hovercard-link-click" data-octo-dimensions="link_type:self" href="/pyliu47">pyliu47</a>
  </span>
  <span class="path-divider flex-self-stretch">/</span>
  <strong itemprop="name" class="mr-2 flex-self-stretch">
    <a data-pjax="#js-repo-pjax-container" href="/pyliu47/covidcompare_deprecated">covidcompare_deprecated</a>
  </strong>
  <span class="Label Label--outline v-align-middle ">Private</span>
</h1>


      </div>

      <ul class="pagehead-actions flex-shrink-0 d-none d-md-inline" style="padding: 2px 0;">

  <li>
        <form data-remote="true" class="d-flex js-social-form js-social-container" action="/notifications/subscribe" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token" value="Yt6/axNjXjnMf5bX/Moo7tZHF8FDWCzOZh3HPx14zxfAfpaDXZXViiFaejjthLnCeIQUMftN6c4HGwj+LakwNQ==" />      <input type="hidden" name="repository_id" value="265970691">

      <details class="details-reset details-overlay select-menu hx_rsm">
        <summary class="btn btn-sm btn-with-count" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;WATCH_BUTTON&quot;,&quot;repository_id&quot;:265970691,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="77bd152f3893ceb9429bab1bf6316aa1ead031562e99dde68bf70e33993ef4c7" data-ga-click="Repository, click Watch settings, action:blob#show">          <span data-menu-button>
              <svg height="16" class="octicon octicon-eye" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.679 7.932c.412-.621 1.242-1.75 2.366-2.717C5.175 4.242 6.527 3.5 8 3.5c1.473 0 2.824.742 3.955 1.715 1.124.967 1.954 2.096 2.366 2.717a.119.119 0 010 .136c-.412.621-1.242 1.75-2.366 2.717C10.825 11.758 9.473 12.5 8 12.5c-1.473 0-2.824-.742-3.955-1.715C2.92 9.818 2.09 8.69 1.679 8.068a.119.119 0 010-.136zM8 2c-1.981 0-3.67.992-4.933 2.078C1.797 5.169.88 6.423.43 7.1a1.619 1.619 0 000 1.798c.45.678 1.367 1.932 2.637 3.024C4.329 13.008 6.019 14 8 14c1.981 0 3.67-.992 4.933-2.078 1.27-1.091 2.187-2.345 2.637-3.023a1.619 1.619 0 000-1.798c-.45-.678-1.367-1.932-2.637-3.023C11.671 2.992 9.981 2 8 2zm0 8a2 2 0 100-4 2 2 0 000 4z"></path></svg>

              Unwatch
          </span>
          <span class="dropdown-caret d-inline-block d-md-none"></span>
</summary>        <details-menu
          class="select-menu-modal position-absolute mt-5"
          style="z-index: 99;">
          <div class="select-menu-header">
            <span class="select-menu-title">Notifications</span>
          </div>
          <div class="select-menu-list">
            <button type="submit" name="do" value="included" class="select-menu-item width-full" aria-checked="false" role="menuitemradio">
              <svg height="16" class="octicon octicon-check select-menu-item-icon" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z"></path></svg>

              <div class="select-menu-item-text">
                <span class="select-menu-item-heading">Not watching</span>
                <span class="description">Be notified only when participating or @mentioned.</span>
                <span class="hidden-select-button-text" data-menu-button-contents>
                  <svg height="16" class="octicon octicon-eye" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.679 7.932c.412-.621 1.242-1.75 2.366-2.717C5.175 4.242 6.527 3.5 8 3.5c1.473 0 2.824.742 3.955 1.715 1.124.967 1.954 2.096 2.366 2.717a.119.119 0 010 .136c-.412.621-1.242 1.75-2.366 2.717C10.825 11.758 9.473 12.5 8 12.5c-1.473 0-2.824-.742-3.955-1.715C2.92 9.818 2.09 8.69 1.679 8.068a.119.119 0 010-.136zM8 2c-1.981 0-3.67.992-4.933 2.078C1.797 5.169.88 6.423.43 7.1a1.619 1.619 0 000 1.798c.45.678 1.367 1.932 2.637 3.024C4.329 13.008 6.019 14 8 14c1.981 0 3.67-.992 4.933-2.078 1.27-1.091 2.187-2.345 2.637-3.023a1.619 1.619 0 000-1.798c-.45-.678-1.367-1.932-2.637-3.023C11.671 2.992 9.981 2 8 2zm0 8a2 2 0 100-4 2 2 0 000 4z"></path></svg>

                  Watch
                </span>
              </div>
            </button>

            <button type="submit" name="do" value="release_only" class="select-menu-item width-full" aria-checked="false" role="menuitemradio">
              <svg height="16" class="octicon octicon-check select-menu-item-icon" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z"></path></svg>

              <div class="select-menu-item-text">
                <span class="select-menu-item-heading">Releases only</span>
                <span class="description">Be notified of new releases, and when participating or @mentioned.</span>
                <span class="hidden-select-button-text" data-menu-button-contents>
                  <svg height="16" class="octicon octicon-eye" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.679 7.932c.412-.621 1.242-1.75 2.366-2.717C5.175 4.242 6.527 3.5 8 3.5c1.473 0 2.824.742 3.955 1.715 1.124.967 1.954 2.096 2.366 2.717a.119.119 0 010 .136c-.412.621-1.242 1.75-2.366 2.717C10.825 11.758 9.473 12.5 8 12.5c-1.473 0-2.824-.742-3.955-1.715C2.92 9.818 2.09 8.69 1.679 8.068a.119.119 0 010-.136zM8 2c-1.981 0-3.67.992-4.933 2.078C1.797 5.169.88 6.423.43 7.1a1.619 1.619 0 000 1.798c.45.678 1.367 1.932 2.637 3.024C4.329 13.008 6.019 14 8 14c1.981 0 3.67-.992 4.933-2.078 1.27-1.091 2.187-2.345 2.637-3.023a1.619 1.619 0 000-1.798c-.45-.678-1.367-1.932-2.637-3.023C11.671 2.992 9.981 2 8 2zm0 8a2 2 0 100-4 2 2 0 000 4z"></path></svg>

                  Unwatch releases
                </span>
              </div>
            </button>

            <button type="submit" name="do" value="subscribed" class="select-menu-item width-full" aria-checked="true" role="menuitemradio">
              <svg height="16" class="octicon octicon-check select-menu-item-icon" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z"></path></svg>

              <div class="select-menu-item-text">
                <span class="select-menu-item-heading">Watching</span>
                <span class="description">Be notified of all conversations.</span>
                <span class="hidden-select-button-text" data-menu-button-contents>
                  <svg height="16" class="octicon octicon-eye v-align-text-bottom" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.679 7.932c.412-.621 1.242-1.75 2.366-2.717C5.175 4.242 6.527 3.5 8 3.5c1.473 0 2.824.742 3.955 1.715 1.124.967 1.954 2.096 2.366 2.717a.119.119 0 010 .136c-.412.621-1.242 1.75-2.366 2.717C10.825 11.758 9.473 12.5 8 12.5c-1.473 0-2.824-.742-3.955-1.715C2.92 9.818 2.09 8.69 1.679 8.068a.119.119 0 010-.136zM8 2c-1.981 0-3.67.992-4.933 2.078C1.797 5.169.88 6.423.43 7.1a1.619 1.619 0 000 1.798c.45.678 1.367 1.932 2.637 3.024C4.329 13.008 6.019 14 8 14c1.981 0 3.67-.992 4.933-2.078 1.27-1.091 2.187-2.345 2.637-3.023a1.619 1.619 0 000-1.798c-.45-.678-1.367-1.932-2.637-3.023C11.671 2.992 9.981 2 8 2zm0 8a2 2 0 100-4 2 2 0 000 4z"></path></svg>

                  Unwatch
                </span>
              </div>
            </button>

            <button type="submit" name="do" value="ignore" class="select-menu-item width-full" aria-checked="false" role="menuitemradio">
              <svg height="16" class="octicon octicon-check select-menu-item-icon" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z"></path></svg>

              <div class="select-menu-item-text">
                <span class="select-menu-item-heading">Ignoring</span>
                <span class="description">Never be notified.</span>
                <span class="hidden-select-button-text" data-menu-button-contents>
                  <svg height="16" class="octicon octicon-mute" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M8 2.75a.75.75 0 00-1.238-.57L3.472 5H1.75A1.75 1.75 0 000 6.75v2.5C0 10.216.784 11 1.75 11h1.723l3.289 2.82A.75.75 0 008 13.25V2.75zM4.238 6.32L6.5 4.38v7.24L4.238 9.68a.75.75 0 00-.488-.18h-2a.25.25 0 01-.25-.25v-2.5a.25.25 0 01.25-.25h2a.75.75 0 00.488-.18zm7.042-1.1a.75.75 0 10-1.06 1.06L11.94 8l-1.72 1.72a.75.75 0 101.06 1.06L13 9.06l1.72 1.72a.75.75 0 101.06-1.06L14.06 8l1.72-1.72a.75.75 0 00-1.06-1.06L13 6.94l-1.72-1.72z"></path></svg>

                  Stop ignoring
                </span>
              </div>
            </button>
          </div>
        </details-menu>
      </details>
        <a class="social-count js-social-count"
          href="/pyliu47/covidcompare_deprecated/watchers"
          aria-label="1 user is watching this repository">
          1
        </a>
</form>
  </li>

  <li>
      <div class="js-toggler-container js-social-container starring-container ">
    <form class="starred js-social-form" action="/pyliu47/covidcompare_deprecated/unstar" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token" value="U/Q5xlQIRpFQe6f33+hAvZaFjyi/+r80wcdCOl4QDZL6gAgnly4dGGL3DYthSf7XgvuUZNGLUw2cSSu/daXScA==" />
      <input type="hidden" name="context" value="repository"></input>
      <button type="submit" class="btn btn-sm btn-with-count  js-toggler-target" aria-label="Unstar this repository" title="Unstar pyliu47/covidcompare_deprecated" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;UNSTAR_BUTTON&quot;,&quot;repository_id&quot;:265970691,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="9231f23ce58b11707f5e0c19426cd092a6b2455fc6371a131d7f0381cff86340" data-ga-click="Repository, click unstar button, action:blob#show; text:Unstar">        <svg height="16" class="octicon octicon-star-fill" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25z"></path></svg>

        Unstar
</button>        <a class="social-count js-social-count" href="/pyliu47/covidcompare_deprecated/stargazers"
           aria-label="0 users starred this repository">
           0
        </a>
</form>
    <form class="unstarred js-social-form" action="/pyliu47/covidcompare_deprecated/star" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token" value="FNi1XjquUcZL09M0arOQq5SYJNtMUyzMIlR0l5MiX39lrR55UZgn7hiwb2Fioxc8ZY7J6HU5cYDOjIsnt81bvA==" />
      <input type="hidden" name="context" value="repository"></input>
      <button type="submit" class="btn btn-sm btn-with-count  js-toggler-target" aria-label="Unstar this repository" title="Star pyliu47/covidcompare_deprecated" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;STAR_BUTTON&quot;,&quot;repository_id&quot;:265970691,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="ea94b04464c7f673826b92dce46b99a25aff9fe7dbd10ac8de6b71ee7ad32d85" data-ga-click="Repository, click star button, action:blob#show; text:Star">        <svg height="16" class="octicon octicon-star" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z"></path></svg>

        Star
</button>        <a class="social-count js-social-count" href="/pyliu47/covidcompare_deprecated/stargazers"
           aria-label="0 users starred this repository">
          0
        </a>
</form>  </div>

  </li>

  <li>
        <span class="btn btn-sm btn-with-count disabled tooltipped tooltipped-sw" aria-label="Cannot fork because you own this repository and are not a member of any organizations.">
          <svg class="octicon octicon-repo-forked" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M5 3.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm0 2.122a2.25 2.25 0 10-1.5 0v.878A2.25 2.25 0 005.75 8.5h1.5v2.128a2.251 2.251 0 101.5 0V8.5h1.5a2.25 2.25 0 002.25-2.25v-.878a2.25 2.25 0 10-1.5 0v.878a.75.75 0 01-.75.75h-4.5A.75.75 0 015 6.25v-.878zm3.75 7.378a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm3-8.75a.75.75 0 100-1.5.75.75 0 000 1.5z"></path></svg>
          Fork
</span>
    <a href="/pyliu47/covidcompare_deprecated/network/members" class="social-count"
       aria-label="0 users forked this repository">
      0
    </a>
  </li>
</ul>

    </div>
    
<nav class="js-repo-nav js-sidenav-container-pjax js-responsive-underlinenav overflow-hidden UnderlineNav px-3 px-md-4 px-lg-5 bg-gray-light" aria-label="Repository" data-pjax="#js-repo-pjax-container">
  <ul class="UnderlineNav-body list-style-none ">
          <li class="d-flex">
        <a class="js-selected-navigation-item selected UnderlineNav-item hx_underlinenav-item no-wrap js-responsive-underlinenav-item" data-tab-item="code-tab" data-hotkey="g c" data-ga-click="Repository, Navigation click, Code tab" aria-current="page" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches repo_packages repo_deployments /pyliu47/covidcompare_deprecated" href="/pyliu47/covidcompare_deprecated">
              <svg height="16" class="octicon octicon-code UnderlineNav-octicon d-none d-sm-inline" classes="UnderlineNav-octicon" display="none inline" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M4.72 3.22a.75.75 0 011.06 1.06L2.06 8l3.72 3.72a.75.75 0 11-1.06 1.06L.47 8.53a.75.75 0 010-1.06l4.25-4.25zm6.56 0a.75.75 0 10-1.06 1.06L13.94 8l-3.72 3.72a.75.75 0 101.06 1.06l4.25-4.25a.75.75 0 000-1.06l-4.25-4.25z"></path></svg>

            <span data-content="Code">Code</span>
              <span class="Counter "></span>


</a>      </li>
      <li class="d-flex">
        <a class="js-selected-navigation-item UnderlineNav-item hx_underlinenav-item no-wrap js-responsive-underlinenav-item" data-tab-item="issues-tab" data-hotkey="g i" data-ga-click="Repository, Navigation click, Issues tab" data-selected-links="repo_issues repo_labels repo_milestones /pyliu47/covidcompare_deprecated/issues" href="/pyliu47/covidcompare_deprecated/issues">
              <svg height="16" class="octicon octicon-issue-opened UnderlineNav-octicon d-none d-sm-inline" classes="UnderlineNav-octicon" display="none inline" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z"></path></svg>

            <span data-content="Issues">Issues</span>
              <span class="Counter " hidden="hidden">0</span>


</a>      </li>
      <li class="d-flex">
        <a class="js-selected-navigation-item UnderlineNav-item hx_underlinenav-item no-wrap js-responsive-underlinenav-item" data-tab-item="pull-requests-tab" data-hotkey="g p" data-ga-click="Repository, Navigation click, Pull requests tab" data-selected-links="repo_pulls checks /pyliu47/covidcompare_deprecated/pulls" href="/pyliu47/covidcompare_deprecated/pulls">
              <svg height="16" class="octicon octicon-git-pull-request UnderlineNav-octicon d-none d-sm-inline" classes="UnderlineNav-octicon" display="none inline" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.177 3.073L9.573.677A.25.25 0 0110 .854v4.792a.25.25 0 01-.427.177L7.177 3.427a.25.25 0 010-.354zM3.75 2.5a.75.75 0 100 1.5.75.75 0 000-1.5zm-2.25.75a2.25 2.25 0 113 2.122v5.256a2.251 2.251 0 11-1.5 0V5.372A2.25 2.25 0 011.5 3.25zM11 2.5h-1V4h1a1 1 0 011 1v5.628a2.251 2.251 0 101.5 0V5A2.5 2.5 0 0011 2.5zm1 10.25a.75.75 0 111.5 0 .75.75 0 01-1.5 0zM3.75 12a.75.75 0 100 1.5.75.75 0 000-1.5z"></path></svg>

            <span data-content="Pull requests">Pull requests</span>
              <span class="Counter " hidden="hidden">0</span>


</a>      </li>
      <li class="d-flex">
        <a class="js-selected-navigation-item UnderlineNav-item hx_underlinenav-item no-wrap js-responsive-underlinenav-item" data-tab-item="actions-tab" data-hotkey="g w" data-ga-click="Repository, Navigation click, Actions tab" data-selected-links="repo_actions /pyliu47/covidcompare_deprecated/actions" href="/pyliu47/covidcompare_deprecated/actions">
              <svg height="16" class="octicon octicon-play UnderlineNav-octicon d-none d-sm-inline" classes="UnderlineNav-octicon" display="none inline" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM6.379 5.227A.25.25 0 006 5.442v5.117a.25.25 0 00.379.214l4.264-2.559a.25.25 0 000-.428L6.379 5.227z"></path></svg>

            <span data-content="Actions">Actions</span>
              <span class="Counter "></span>


</a>      </li>
      <li class="d-flex">
        <a class="js-selected-navigation-item UnderlineNav-item hx_underlinenav-item no-wrap js-responsive-underlinenav-item" data-tab-item="projects-tab" data-hotkey="g b" data-ga-click="Repository, Navigation click, Projects tab" data-selected-links="repo_projects new_repo_project repo_project /pyliu47/covidcompare_deprecated/projects" href="/pyliu47/covidcompare_deprecated/projects">
              <svg height="16" class="octicon octicon-project UnderlineNav-octicon d-none d-sm-inline" classes="UnderlineNav-octicon" display="none inline" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.75 0A1.75 1.75 0 000 1.75v12.5C0 15.216.784 16 1.75 16h12.5A1.75 1.75 0 0016 14.25V1.75A1.75 1.75 0 0014.25 0H1.75zM1.5 1.75a.25.25 0 01.25-.25h12.5a.25.25 0 01.25.25v12.5a.25.25 0 01-.25.25H1.75a.25.25 0 01-.25-.25V1.75zM11.75 3a.75.75 0 00-.75.75v7.5a.75.75 0 001.5 0v-7.5a.75.75 0 00-.75-.75zm-8.25.75a.75.75 0 011.5 0v5.5a.75.75 0 01-1.5 0v-5.5zM8 3a.75.75 0 00-.75.75v3.5a.75.75 0 001.5 0v-3.5A.75.75 0 008 3z"></path></svg>

            <span data-content="Projects">Projects</span>
              <span class="Counter " hidden="hidden">0</span>


</a>      </li>
      <li class="d-flex">
        <a class="js-selected-navigation-item UnderlineNav-item hx_underlinenav-item no-wrap js-responsive-underlinenav-item" data-tab-item="security-tab" data-hotkey="g s" data-ga-click="Repository, Navigation click, Security tab" data-selected-links="security overview alerts policy token_scanning code_scanning /pyliu47/covidcompare_deprecated/security" href="/pyliu47/covidcompare_deprecated/security">
              <svg height="16" class="octicon octicon-shield UnderlineNav-octicon d-none d-sm-inline" classes="UnderlineNav-octicon" display="none inline" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.467.133a1.75 1.75 0 011.066 0l5.25 1.68A1.75 1.75 0 0115 3.48V7c0 1.566-.32 3.182-1.303 4.682-.983 1.498-2.585 2.813-5.032 3.855a1.7 1.7 0 01-1.33 0c-2.447-1.042-4.049-2.357-5.032-3.855C1.32 10.182 1 8.566 1 7V3.48a1.75 1.75 0 011.217-1.667l5.25-1.68zm.61 1.429a.25.25 0 00-.153 0l-5.25 1.68a.25.25 0 00-.174.238V7c0 1.358.275 2.666 1.057 3.86.784 1.194 2.121 2.34 4.366 3.297a.2.2 0 00.154 0c2.245-.956 3.582-2.104 4.366-3.298C13.225 9.666 13.5 8.36 13.5 7V3.48a.25.25 0 00-.174-.237l-5.25-1.68zM9 10.5a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.75a.75.75 0 10-1.5 0v3a.75.75 0 001.5 0v-3z"></path></svg>

            <span data-content="Security">Security</span>
              <span class="js-security-tab-count Counter " data-url="/pyliu47/covidcompare_deprecated/security/overall-count"></span>


</a>      </li>
      <li class="d-flex">
        <a class="js-selected-navigation-item UnderlineNav-item hx_underlinenav-item no-wrap js-responsive-underlinenav-item" data-tab-item="insights-tab" data-ga-click="Repository, Navigation click, Insights tab" data-selected-links="repo_graphs repo_contributors dependency_graph dependabot_updates pulse people /pyliu47/covidcompare_deprecated/network/dependencies" href="/pyliu47/covidcompare_deprecated/network/dependencies">
              <svg height="16" class="octicon octicon-graph UnderlineNav-octicon d-none d-sm-inline" classes="UnderlineNav-octicon" display="none inline" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.5 1.75a.75.75 0 00-1.5 0v12.5c0 .414.336.75.75.75h14.5a.75.75 0 000-1.5H1.5V1.75zm14.28 2.53a.75.75 0 00-1.06-1.06L10 7.94 7.53 5.47a.75.75 0 00-1.06 0L3.22 8.72a.75.75 0 001.06 1.06L7 7.06l2.47 2.47a.75.75 0 001.06 0l5.25-5.25z"></path></svg>

            <span data-content="Insights">Insights</span>
              <span class="Counter "></span>


</a>      </li>
      <li class="d-flex">
        <a class="js-selected-navigation-item UnderlineNav-item hx_underlinenav-item no-wrap js-responsive-underlinenav-item" data-tab-item="settings-tab" data-ga-click="Repository, Navigation click, Settings tab" data-selected-links="repo_settings repo_branch_settings hooks integration_installations repo_keys_settings issue_template_editor secrets_settings key_links_settings repo_actions_settings notifications /pyliu47/covidcompare_deprecated/settings" href="/pyliu47/covidcompare_deprecated/settings">
              <svg height="16" class="octicon octicon-gear UnderlineNav-octicon d-none d-sm-inline" classes="UnderlineNav-octicon" display="none inline" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.429 1.525a6.593 6.593 0 011.142 0c.036.003.108.036.137.146l.289 1.105c.147.56.55.967.997 1.189.174.086.341.183.501.29.417.278.97.423 1.53.27l1.102-.303c.11-.03.175.016.195.046.219.31.41.641.573.989.014.031.022.11-.059.19l-.815.806c-.411.406-.562.957-.53 1.456a4.588 4.588 0 010 .582c-.032.499.119 1.05.53 1.456l.815.806c.08.08.073.159.059.19a6.494 6.494 0 01-.573.99c-.02.029-.086.074-.195.045l-1.103-.303c-.559-.153-1.112-.008-1.529.27-.16.107-.327.204-.5.29-.449.222-.851.628-.998 1.189l-.289 1.105c-.029.11-.101.143-.137.146a6.613 6.613 0 01-1.142 0c-.036-.003-.108-.037-.137-.146l-.289-1.105c-.147-.56-.55-.967-.997-1.189a4.502 4.502 0 01-.501-.29c-.417-.278-.97-.423-1.53-.27l-1.102.303c-.11.03-.175-.016-.195-.046a6.492 6.492 0 01-.573-.989c-.014-.031-.022-.11.059-.19l.815-.806c.411-.406.562-.957.53-1.456a4.587 4.587 0 010-.582c.032-.499-.119-1.05-.53-1.456l-.815-.806c-.08-.08-.073-.159-.059-.19a6.44 6.44 0 01.573-.99c.02-.029.086-.075.195-.045l1.103.303c.559.153 1.112.008 1.529-.27.16-.107.327-.204.5-.29.449-.222.851-.628.998-1.189l.289-1.105c.029-.11.101-.143.137-.146zM8 0c-.236 0-.47.01-.701.03-.743.065-1.29.615-1.458 1.261l-.29 1.106c-.017.066-.078.158-.211.224a5.994 5.994 0 00-.668.386c-.123.082-.233.09-.3.071L3.27 2.776c-.644-.177-1.392.02-1.82.63a7.977 7.977 0 00-.704 1.217c-.315.675-.111 1.422.363 1.891l.815.806c.05.048.098.147.088.294a6.084 6.084 0 000 .772c.01.147-.038.246-.088.294l-.815.806c-.474.469-.678 1.216-.363 1.891.2.428.436.835.704 1.218.428.609 1.176.806 1.82.63l1.103-.303c.066-.019.176-.011.299.071.213.143.436.272.668.386.133.066.194.158.212.224l.289 1.106c.169.646.715 1.196 1.458 1.26a8.094 8.094 0 001.402 0c.743-.064 1.29-.614 1.458-1.26l.29-1.106c.017-.066.078-.158.211-.224a5.98 5.98 0 00.668-.386c.123-.082.233-.09.3-.071l1.102.302c.644.177 1.392-.02 1.82-.63.268-.382.505-.789.704-1.217.315-.675.111-1.422-.364-1.891l-.814-.806c-.05-.048-.098-.147-.088-.294a6.1 6.1 0 000-.772c-.01-.147.039-.246.088-.294l.814-.806c.475-.469.679-1.216.364-1.891a7.992 7.992 0 00-.704-1.218c-.428-.609-1.176-.806-1.82-.63l-1.103.303c-.066.019-.176.011-.299-.071a5.991 5.991 0 00-.668-.386c-.133-.066-.194-.158-.212-.224L10.16 1.29C9.99.645 9.444.095 8.701.031A8.094 8.094 0 008 0zm1.5 8a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM11 8a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>

            <span data-content="Settings">Settings</span>
              <span class="Counter "></span>


</a>      </li>

</ul>
        <div class="position-absolute right-0 pr-3 pr-md-4 pr-lg-5 js-responsive-underlinenav-overflow" style="visibility:hidden;">
      <details class="details-overlay details-reset position-relative">
  <summary role="button">
              <div class="UnderlineNav-item mr-0 border-0">
            <svg class="octicon octicon-kebab-horizontal" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path d="M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path></svg>
            <span class="sr-only">More</span>
          </div>

</summary>
            <details-menu class="dropdown-menu dropdown-menu-sw " role="menu">
  
            <ul>
                <li data-menu-item="code-tab" hidden>
                  <a role="menuitem" class="js-selected-navigation-item dropdown-item" data-selected-links=" /pyliu47/covidcompare_deprecated" href="/pyliu47/covidcompare_deprecated">
                    Code
</a>                </li>
                <li data-menu-item="issues-tab" hidden>
                  <a role="menuitem" class="js-selected-navigation-item dropdown-item" data-selected-links=" /pyliu47/covidcompare_deprecated/issues" href="/pyliu47/covidcompare_deprecated/issues">
                    Issues
</a>                </li>
                <li data-menu-item="pull-requests-tab" hidden>
                  <a role="menuitem" class="js-selected-navigation-item dropdown-item" data-selected-links=" /pyliu47/covidcompare_deprecated/pulls" href="/pyliu47/covidcompare_deprecated/pulls">
                    Pull requests
</a>                </li>
                <li data-menu-item="actions-tab" hidden>
                  <a role="menuitem" class="js-selected-navigation-item dropdown-item" data-selected-links=" /pyliu47/covidcompare_deprecated/actions" href="/pyliu47/covidcompare_deprecated/actions">
                    Actions
</a>                </li>
                <li data-menu-item="projects-tab" hidden>
                  <a role="menuitem" class="js-selected-navigation-item dropdown-item" data-selected-links=" /pyliu47/covidcompare_deprecated/projects" href="/pyliu47/covidcompare_deprecated/projects">
                    Projects
</a>                </li>
                <li data-menu-item="security-tab" hidden>
                  <a role="menuitem" class="js-selected-navigation-item dropdown-item" data-selected-links=" /pyliu47/covidcompare_deprecated/security" href="/pyliu47/covidcompare_deprecated/security">
                    Security
</a>                </li>
                <li data-menu-item="insights-tab" hidden>
                  <a role="menuitem" class="js-selected-navigation-item dropdown-item" data-selected-links=" /pyliu47/covidcompare_deprecated/network/dependencies" href="/pyliu47/covidcompare_deprecated/network/dependencies">
                    Insights
</a>                </li>
                <li data-menu-item="settings-tab" hidden>
                  <a role="menuitem" class="js-selected-navigation-item dropdown-item" data-selected-links=" /pyliu47/covidcompare_deprecated/settings" href="/pyliu47/covidcompare_deprecated/settings">
                    Settings
</a>                </li>
            </ul>

</details-menu>

</details>
    </div>

</nav>

  </div>

<div class="container-xl clearfix new-discussion-timeline  px-3 px-md-4 px-lg-5">
  <div class="repository-content ">

    
    

  


    <a class="d-none js-permalink-shortcut" data-hotkey="y" href="/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r">Permalink</a>

    <!-- blob contrib key: blob_contributors:v22:830aec5747af2270643dd87f50489a18 -->
    

    <div class="d-flex flex-items-center flex-shrink-0 pb-3 flex-wrap flex-justify-between flex-md-justify-start">
      
<details class="details-reset details-overlay mr-0 mb-0 " id="branch-select-menu">
  <summary class="btn css-truncate"
           data-hotkey="w"
           title="Switch branches or tags">
    <svg height="16" class="octicon octicon-git-branch text-gray" text="gray" viewBox="0 0 16 16" version="1.1" width="16" aria-hidden="true"><path fill-rule="evenodd" d="M11.75 2.5a.75.75 0 100 1.5.75.75 0 000-1.5zm-2.25.75a2.25 2.25 0 113 2.122V6A2.5 2.5 0 0110 8.5H6a1 1 0 00-1 1v1.128a2.251 2.251 0 11-1.5 0V5.372a2.25 2.25 0 111.5 0v1.836A2.492 2.492 0 016 7h4a1 1 0 001-1v-.628A2.25 2.25 0 019.5 3.25zM4.25 12a.75.75 0 100 1.5.75.75 0 000-1.5zM3.5 3.25a.75.75 0 111.5 0 .75.75 0 01-1.5 0z"></path></svg>

      <i class="d-none d-lg-inline">Tree:</i>
    <span class="css-truncate-target" data-menu-button>1a20171085</span>
    <span class="dropdown-caret"></span>
  </summary>

  <details-menu class="SelectMenu SelectMenu--hasFilter" src="/pyliu47/covidcompare_deprecated/refs/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r?source_action=show&amp;source_controller=blob" preload>
    <div class="SelectMenu-modal">
      <include-fragment class="SelectMenu-loading" aria-label="Menu is loading">
        <svg class="octicon octicon-octoface anim-pulse" height="32" viewBox="0 0 16 16" version="1.1" width="32" aria-hidden="true"><path fill-rule="evenodd" d="M14.7 5.34c.13-.32.55-1.59-.13-3.31 0 0-1.05-.33-3.44 1.3-1-.28-2.07-.32-3.13-.32s-2.13.04-3.13.32c-2.39-1.64-3.44-1.3-3.44-1.3-.68 1.72-.26 2.99-.13 3.31C.49 6.21 0 7.33 0 8.69 0 13.84 3.33 15 7.98 15S16 13.84 16 8.69c0-1.36-.49-2.48-1.3-3.35zM8 14.02c-3.3 0-5.98-.15-5.98-3.35 0-.76.38-1.48 1.02-2.07 1.07-.98 2.9-.46 4.96-.46 2.07 0 3.88-.52 4.96.46.65.59 1.02 1.3 1.02 2.07 0 3.19-2.68 3.35-5.98 3.35zM5.49 9.01c-.66 0-1.2.8-1.2 1.78s.54 1.79 1.2 1.79c.66 0 1.2-.8 1.2-1.79s-.54-1.78-1.2-1.78zm5.02 0c-.66 0-1.2.79-1.2 1.78s.54 1.79 1.2 1.79c.66 0 1.2-.8 1.2-1.79s-.53-1.78-1.2-1.78z"></path></svg>
      </include-fragment>
    </div>
  </details-menu>
</details>

      <h2 id="blob-path" class="breadcrumb flex-auto min-width-0 text-normal mx-0 mx-md-3 width-full width-md-auto flex-order-1 flex-md-order-none mt-3 mt-md-0">
        <span class="js-repo-root text-bold"><span class="js-path-segment d-inline-block wb-break-all"><a data-pjax="true" rel="nofollow" href="/pyliu47/covidcompare_deprecated/tree/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9"><span>covidcompare_deprecated</span></a></span></span><span class="separator">/</span><span class="js-path-segment d-inline-block wb-break-all"><a data-pjax="true" rel="nofollow" href="/pyliu47/covidcompare_deprecated/tree/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code"><span>code</span></a></span><span class="separator">/</span><strong class="final-path">2_peak.r</strong>
      </h2>
      <a href="/pyliu47/covidcompare_deprecated/find/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9"
            class="js-pjax-capture-input btn mr-2 d-none d-md-block"
            data-pjax
            data-hotkey="t">
        Go to file
      </a>

      <details class="flex-self-end details-overlay details-reset position-relative" id="blob-more-options-details">
  <summary role="button">
              <span class="btn">
            <svg height="16" class="octicon octicon-kebab-horizontal" aria-label="More options" viewBox="0 0 16 16" version="1.1" width="16" role="img"><path d="M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path></svg>

          </span>

</summary>
            <ul class="dropdown-menu dropdown-menu-sw">
            <li class="d-block d-md-none">
              <a class="dropdown-item d-flex flex-items-baseline" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;FIND_FILE_BUTTON&quot;,&quot;repository_id&quot;:265970691,&quot;originating_url&quot;:&quot;https://github.com/pyliu47/covidcompare_deprecated/blob/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r&quot;,&quot;user_id&quot;:62630460}}" data-hydro-click-hmac="6cff64f2b4ffa8e4293a012c50819ee030c5a4095dd46bd7f76a68ab85d59b53" data-ga-click="Repository, find file, location:repo overview" data-hotkey="t" data-pjax="true" href="/pyliu47/covidcompare_deprecated/find/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9">
                <span class="flex-auto">Go to file</span>
                <span class="text-small text-gray" aria-hidden="true">T</span>
</a>            </li>
            <li data-toggle-for="blob-more-options-details">
              <button type="button" data-toggle-for="jumpto-line-details-dialog" class="btn-link dropdown-item">
                <span class="d-flex flex-items-baseline">
                  <span class="flex-auto">Go to line</span>
                  <span class="text-small text-gray" aria-hidden="true">L</span>
                </span>
              </button>
            </li>
            <li class="dropdown-divider" role="none"></li>
            <li>
              <clipboard-copy value="code/2_peak.r" class="dropdown-item cursor-pointer" data-toggle-for="blob-more-options-details">
                Copy path
              </clipboard-copy>
            </li>
          </ul>

</details>
    </div>



    <div class="Box d-flex flex-column flex-shrink-0 mb-3">
      <include-fragment src="/pyliu47/covidcompare_deprecated/contributors/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r" class="commit-loader">
        <div class="Box-header Box-header--blue d-flex flex-items-center">
          <div class="Skeleton avatar avatar-user flex-shrink-0 ml-n1 mr-n1 mt-n1 mb-n1" style="width:24px;height:24px;"></div>
          <div class="Skeleton Skeleton--text col-5 ml-2">&nbsp;</div>
        </div>

        <div class="Box-body d-flex flex-items-center" >
          <div class="Skeleton Skeleton--text col-1">&nbsp;</div>
          <span class="text-red h6 loader-error">Cannot retrieve contributors at this time</span>
        </div>
</include-fragment>    </div>






    <div class="Box mt-3 position-relative
      ">
      
<div class="Box-header py-2 d-flex flex-column flex-shrink-0 flex-md-row flex-md-items-center">
  <div class="text-mono f6 flex-auto pr-3 flex-order-2 flex-md-order-1 mt-2 mt-md-0">

      338 lines (265 sloc)
      <span class="file-info-divider"></span>
    12.6 KB
  </div>

  <div class="d-flex py-1 py-md-0 flex-auto flex-order-1 flex-md-order-2 flex-sm-grow-0 flex-justify-between">

    <div class="BtnGroup">
      <a id="raw-url" class="btn btn-sm BtnGroup-item" href="/pyliu47/covidcompare_deprecated/raw/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r">Raw</a>
        <a class="btn btn-sm js-update-url-with-hash BtnGroup-item" data-hotkey="b" href="/pyliu47/covidcompare_deprecated/blame/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r">Blame</a>
    </div>

    <div>
          <button class="btn-octicon disabled tooltipped tooltipped-nw js-remove-unless-platform"
             data-platforms="windows,mac" type="button"  disabled
             aria-label="You must be on a branch to open this file in GitHub Desktop">
              <svg class="octicon octicon-device-desktop" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M1.75 2.5h12.5a.25.25 0 01.25.25v7.5a.25.25 0 01-.25.25H1.75a.25.25 0 01-.25-.25v-7.5a.25.25 0 01.25-.25zM14.25 1H1.75A1.75 1.75 0 000 2.75v7.5C0 11.216.784 12 1.75 12h3.727c-.1 1.041-.52 1.872-1.292 2.757A.75.75 0 004.75 16h6.5a.75.75 0 00.565-1.243c-.772-.885-1.193-1.716-1.292-2.757h3.727A1.75 1.75 0 0016 10.25v-7.5A1.75 1.75 0 0014.25 1zM9.018 12H6.982a5.72 5.72 0 01-.765 2.5h3.566a5.72 5.72 0 01-.765-2.5z"></path></svg>
          </button>

          <button type="button" class="btn-octicon disabled tooltipped tooltipped-nw"
            aria-label="You must be on a branch to make or propose changes to this file">
            <svg class="octicon octicon-pencil" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M11.013 1.427a1.75 1.75 0 012.474 0l1.086 1.086a1.75 1.75 0 010 2.474l-8.61 8.61c-.21.21-.47.364-.756.445l-3.251.93a.75.75 0 01-.927-.928l.929-3.25a1.75 1.75 0 01.445-.758l8.61-8.61zm1.414 1.06a.25.25 0 00-.354 0L10.811 3.75l1.439 1.44 1.263-1.263a.25.25 0 000-.354l-1.086-1.086zM11.189 6.25L9.75 4.81l-6.286 6.287a.25.25 0 00-.064.108l-.558 1.953 1.953-.558a.249.249 0 00.108-.064l6.286-6.286z"></path></svg>
          </button>
          <button type="button" class="btn-octicon btn-octicon-danger disabled tooltipped tooltipped-nw"
            aria-label="You must be on a branch to make or propose changes to this file">
            <svg class="octicon octicon-trashcan" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M6.5 1.75a.25.25 0 01.25-.25h2.5a.25.25 0 01.25.25V3h-3V1.75zm4.5 0V3h2.25a.75.75 0 010 1.5H2.75a.75.75 0 010-1.5H5V1.75C5 .784 5.784 0 6.75 0h2.5C10.216 0 11 .784 11 1.75zM4.496 6.675a.75.75 0 10-1.492.15l.66 6.6A1.75 1.75 0 005.405 15h5.19c.9 0 1.652-.681 1.741-1.576l.66-6.6a.75.75 0 00-1.492-.149l-.66 6.6a.25.25 0 01-.249.225h-5.19a.25.25 0 01-.249-.225l-.66-6.6z"></path></svg>
          </button>
    </div>
  </div>
</div>



      

  <div itemprop="text" class="Box-body p-0 blob-wrapper data type-r ">
      
<table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
      <tr>
        <td id="L1" class="blob-num js-line-number" data-line-number="1"></td>
        <td id="LC1" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span> ##############################################################################</span></td>
      </tr>
      <tr>
        <td id="L2" class="blob-num js-line-number" data-line-number="2"></td>
        <td id="LC2" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span> Purpose:  Peak predictive validity</span></td>
      </tr>
      <tr>
        <td id="L3" class="blob-num js-line-number" data-line-number="3"></td>
        <td id="LC3" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span> Author:  Patty Liu &amp; Joseph Friedman</span></td>
      </tr>
      <tr>
        <td id="L4" class="blob-num js-line-number" data-line-number="4"></td>
        <td id="LC4" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span> ##############################################################################</span></td>
      </tr>
      <tr>
        <td id="L5" class="blob-num js-line-number" data-line-number="5"></td>
        <td id="LC5" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L6" class="blob-num js-line-number" data-line-number="6"></td>
        <td id="LC6" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Setup</span></td>
      </tr>
      <tr>
        <td id="L7" class="blob-num js-line-number" data-line-number="7"></td>
        <td id="LC7" class="blob-code blob-code-inner js-file-line">rm(<span class="pl-v">list</span> <span class="pl-k">=</span> ls())</td>
      </tr>
      <tr>
        <td id="L8" class="blob-num js-line-number" data-line-number="8"></td>
        <td id="LC8" class="blob-code blob-code-inner js-file-line"><span class="pl-e">pacman</span><span class="pl-k">::</span>p_load(<span class="pl-smi">data.table</span>, <span class="pl-smi">tidyverse</span>, <span class="pl-smi">ggplot2</span>, <span class="pl-smi">grid</span>, <span class="pl-smi">gridExtra</span>, <span class="pl-smi">cowplot</span>, <span class="pl-smi">reldist</span>, <span class="pl-smi">lubridate</span>)</td>
      </tr>
      <tr>
        <td id="L9" class="blob-num js-line-number" data-line-number="9"></td>
        <td id="LC9" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L10" class="blob-num js-line-number" data-line-number="10"></td>
        <td id="LC10" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">graph.peakmethod</span> <span class="pl-k">&lt;-</span> <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L11" class="blob-num js-line-number" data-line-number="11"></td>
        <td id="LC11" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">graph.peakcomparison</span> <span class="pl-k">&lt;-</span> <span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L12" class="blob-num js-line-number" data-line-number="12"></td>
        <td id="LC12" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">graph.peakpv</span> <span class="pl-k">&lt;-</span> <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L13" class="blob-num js-line-number" data-line-number="13"></td>
        <td id="LC13" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L14" class="blob-num js-line-number" data-line-number="14"></td>
        <td id="LC14" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">theme</span> <span class="pl-k">&lt;-</span> theme_bw() <span class="pl-k">+</span> theme(</td>
      </tr>
      <tr>
        <td id="L15" class="blob-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-code blob-code-inner js-file-line">  <span class="pl-v">plot.title</span> <span class="pl-k">=</span> element_text(<span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">12</span>, <span class="pl-v">face</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>),</td>
      </tr>
      <tr>
        <td id="L16" class="blob-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-code blob-code-inner js-file-line">  <span class="pl-v">axis.title.x</span> <span class="pl-k">=</span> element_text(<span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">10</span>, <span class="pl-v">face</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>),</td>
      </tr>
      <tr>
        <td id="L17" class="blob-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-code blob-code-inner js-file-line">  <span class="pl-v">axis.title.y</span> <span class="pl-k">=</span> element_text(<span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">10</span>, <span class="pl-v">face</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>),</td>
      </tr>
      <tr>
        <td id="L18" class="blob-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-code blob-code-inner js-file-line">  <span class="pl-v">axis.text.y</span> <span class="pl-k">=</span> element_text(<span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">10</span>, <span class="pl-v">face</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>),</td>
      </tr>
      <tr>
        <td id="L19" class="blob-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-code blob-code-inner js-file-line">  <span class="pl-v">axis.text.x</span> <span class="pl-k">=</span> element_text(<span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">10</span>, <span class="pl-v">face</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>),</td>
      </tr>
      <tr>
        <td id="L20" class="blob-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-code blob-code-inner js-file-line">  <span class="pl-v">strip.background</span> <span class="pl-k">=</span> element_rect(<span class="pl-v">fill</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>white<span class="pl-pds">&quot;</span></span>),</td>
      </tr>
      <tr>
        <td id="L21" class="blob-num js-line-number" data-line-number="21"></td>
        <td id="LC21" class="blob-code blob-code-inner js-file-line">  <span class="pl-v">strip.text.x</span> <span class="pl-k">=</span> element_text(<span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">10</span>, <span class="pl-v">face</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>),</td>
      </tr>
      <tr>
        <td id="L22" class="blob-num js-line-number" data-line-number="22"></td>
        <td id="LC22" class="blob-code blob-code-inner js-file-line">  <span class="pl-v">legend.position</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>top<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L23" class="blob-num js-line-number" data-line-number="23"></td>
        <td id="LC23" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L24" class="blob-num js-line-number" data-line-number="24"></td>
        <td id="LC24" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L25" class="blob-num js-line-number" data-line-number="25"></td>
        <td id="LC25" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">c.vals</span> <span class="pl-k">&lt;-</span> c(</td>
      </tr>
      <tr>
        <td id="L26" class="blob-num js-line-number" data-line-number="26"></td>
        <td id="LC26" class="blob-code blob-code-inner js-file-line">  <span class="pl-s"><span class="pl-pds">&quot;</span>Delphi<span class="pl-pds">&quot;</span></span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#e31a1c<span class="pl-pds">&quot;</span></span>,</td>
      </tr>
      <tr>
        <td id="L27" class="blob-num js-line-number" data-line-number="27"></td>
        <td id="LC27" class="blob-code blob-code-inner js-file-line">  <span class="pl-s"><span class="pl-pds">&quot;</span>IHME - CF SEIR<span class="pl-pds">&quot;</span></span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#6a3d9a<span class="pl-pds">&quot;</span></span>,</td>
      </tr>
      <tr>
        <td id="L28" class="blob-num js-line-number" data-line-number="28"></td>
        <td id="LC28" class="blob-code blob-code-inner js-file-line">  <span class="pl-s"><span class="pl-pds">&quot;</span>IHME - Curve Fit<span class="pl-pds">&quot;</span></span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#cab2d6<span class="pl-pds">&quot;</span></span>,</td>
      </tr>
      <tr>
        <td id="L29" class="blob-num js-line-number" data-line-number="29"></td>
        <td id="LC29" class="blob-code blob-code-inner js-file-line">  <span class="pl-s"><span class="pl-pds">&quot;</span>IHME - MS SEIR<span class="pl-pds">&quot;</span></span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#33a02c<span class="pl-pds">&quot;</span></span>,</td>
      </tr>
      <tr>
        <td id="L30" class="blob-num js-line-number" data-line-number="30"></td>
        <td id="LC30" class="blob-code blob-code-inner js-file-line">  <span class="pl-s"><span class="pl-pds">&quot;</span>Los Alamos Nat Lab<span class="pl-pds">&quot;</span></span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#1f78b4<span class="pl-pds">&quot;</span></span>,</td>
      </tr>
      <tr>
        <td id="L31" class="blob-num js-line-number" data-line-number="31"></td>
        <td id="LC31" class="blob-code blob-code-inner js-file-line">  <span class="pl-s"><span class="pl-pds">&quot;</span>Youyang Gu<span class="pl-pds">&quot;</span></span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#ff7f00<span class="pl-pds">&quot;</span></span>,</td>
      </tr>
      <tr>
        <td id="L32" class="blob-num js-line-number" data-line-number="32"></td>
        <td id="LC32" class="blob-code blob-code-inner js-file-line">  <span class="pl-s"><span class="pl-pds">&quot;</span>Imperial<span class="pl-pds">&quot;</span></span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#fb9a99<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L33" class="blob-num js-line-number" data-line-number="33"></td>
        <td id="LC33" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L34" class="blob-num js-line-number" data-line-number="34"></td>
        <td id="LC34" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L35" class="blob-num js-line-number" data-line-number="35"></td>
        <td id="LC35" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>--Setup------</span></td>
      </tr>
      <tr>
        <td id="L36" class="blob-num js-line-number" data-line-number="36"></td>
        <td id="LC36" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L37" class="blob-num js-line-number" data-line-number="37"></td>
        <td id="LC37" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Load</span></td>
      </tr>
      <tr>
        <td id="L38" class="blob-num js-line-number" data-line-number="38"></td>
        <td id="LC38" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span> <span class="pl-k">&lt;-</span> readRDS(<span class="pl-s"><span class="pl-pds">&quot;</span>data/processed/data.rds<span class="pl-pds">&quot;</span></span>)</td>
      </tr>
      <tr>
        <td id="L39" class="blob-num js-line-number" data-line-number="39"></td>
        <td id="LC39" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span>[,<span class="pl-smi">super_region_name</span><span class="pl-k">:</span><span class="pl-k">=</span><span class="pl-c1">NULL</span>]</td>
      </tr>
      <tr>
        <td id="L40" class="blob-num js-line-number" data-line-number="40"></td>
        <td id="LC40" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">locs</span> <span class="pl-k">&lt;-</span> fread(<span class="pl-s"><span class="pl-pds">&quot;</span>data/ref/locs_map.csv<span class="pl-pds">&quot;</span></span>)[, .(<span class="pl-smi">ihme_loc_id</span>, <span class="pl-smi">super_region_name</span>)]</td>
      </tr>
      <tr>
        <td id="L41" class="blob-num js-line-number" data-line-number="41"></td>
        <td id="LC41" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span> <span class="pl-k">&lt;-</span> merge(<span class="pl-smi">df</span>, <span class="pl-smi">locs</span>, <span class="pl-v">by</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>ihme_loc_id<span class="pl-pds">&quot;</span></span>, <span class="pl-v">all.x</span><span class="pl-k">=</span><span class="pl-c1">T</span>)</td>
      </tr>
      <tr>
        <td id="L42" class="blob-num js-line-number" data-line-number="42"></td>
        <td id="LC42" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">df</span>[order(<span class="pl-smi">model</span>, <span class="pl-smi">model_date</span>, <span class="pl-smi">location_name</span>, <span class="pl-smi">date</span>)]</td>
      </tr>
      <tr>
        <td id="L43" class="blob-num js-line-number" data-line-number="43"></td>
        <td id="LC43" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L44" class="blob-num js-line-number" data-line-number="44"></td>
        <td id="LC44" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>--Smooth truth data--------</span></td>
      </tr>
      <tr>
        <td id="L45" class="blob-num js-line-number" data-line-number="45"></td>
        <td id="LC45" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L46" class="blob-num js-line-number" data-line-number="46"></td>
        <td id="LC46" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Subset frame to truth data</span></td>
      </tr>
      <tr>
        <td id="L47" class="blob-num js-line-number" data-line-number="47"></td>
        <td id="LC47" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">df</span>[<span class="pl-k">!</span>is.na(<span class="pl-smi">truth</span>), .(<span class="pl-smi">truth</span>, <span class="pl-smi">date</span>, <span class="pl-smi">location_name</span>, <span class="pl-smi">ihme_loc_id</span>)] %<span class="pl-k">&gt;</span>% unique()</td>
      </tr>
      <tr>
        <td id="L48" class="blob-num js-line-number" data-line-number="48"></td>
        <td id="LC48" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">tf</span>[order(<span class="pl-smi">location_name</span>, <span class="pl-smi">date</span>)]</td>
      </tr>
      <tr>
        <td id="L49" class="blob-num js-line-number" data-line-number="49"></td>
        <td id="LC49" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L50" class="blob-num js-line-number" data-line-number="50"></td>
        <td id="LC50" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Count number of days reporting for each location, subset to locs with &gt;= 7 days</span></td>
      </tr>
      <tr>
        <td id="L51" class="blob-num js-line-number" data-line-number="51"></td>
        <td id="LC51" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[, <span class="pl-smi">n</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-smi">.N</span>, <span class="pl-v">by</span><span class="pl-k">=</span>.(<span class="pl-smi">location_name</span>)]</td>
      </tr>
      <tr>
        <td id="L52" class="blob-num js-line-number" data-line-number="52"></td>
        <td id="LC52" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">tf</span>[<span class="pl-smi">n</span> <span class="pl-k">&gt;</span><span class="pl-k">=</span><span class="pl-c1">7</span>]</td>
      </tr>
      <tr>
        <td id="L53" class="blob-num js-line-number" data-line-number="53"></td>
        <td id="LC53" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span><span class="pl-k">$</span><span class="pl-smi">n</span> <span class="pl-k">&lt;-</span> <span class="pl-c1">NULL</span></td>
      </tr>
      <tr>
        <td id="L54" class="blob-num js-line-number" data-line-number="54"></td>
        <td id="LC54" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L55" class="blob-num js-line-number" data-line-number="55"></td>
        <td id="LC55" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Create daily</span></td>
      </tr>
      <tr>
        <td id="L56" class="blob-num js-line-number" data-line-number="56"></td>
        <td id="LC56" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[, <span class="pl-smi">daily</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-smi">truth</span> <span class="pl-k">-</span> shift(<span class="pl-smi">truth</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">location_name</span>)]</td>
      </tr>
      <tr>
        <td id="L57" class="blob-num js-line-number" data-line-number="57"></td>
        <td id="LC57" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[<span class="pl-smi">daily</span> <span class="pl-k">&lt;</span> <span class="pl-c1">0</span>, <span class="pl-smi">daily</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-c1">0</span>]</td>
      </tr>
      <tr>
        <td id="L58" class="blob-num js-line-number" data-line-number="58"></td>
        <td id="LC58" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L59" class="blob-num js-line-number" data-line-number="59"></td>
        <td id="LC59" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Locs ordered by cumulative death at current date</span></td>
      </tr>
      <tr>
        <td id="L60" class="blob-num js-line-number" data-line-number="60"></td>
        <td id="LC60" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">locs</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">tf</span>[, .(<span class="pl-smi">location_name</span>, <span class="pl-smi">truth</span>, <span class="pl-smi">date</span>)]</td>
      </tr>
      <tr>
        <td id="L61" class="blob-num js-line-number" data-line-number="61"></td>
        <td id="LC61" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">locs</span>[, <span class="pl-smi">last</span> <span class="pl-k">:</span><span class="pl-k">=</span> max(<span class="pl-smi">date</span>), <span class="pl-v">by</span><span class="pl-k">=</span>.(<span class="pl-smi">location_name</span>)]</td>
      </tr>
      <tr>
        <td id="L62" class="blob-num js-line-number" data-line-number="62"></td>
        <td id="LC62" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">locs</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">locs</span>[<span class="pl-smi">date</span><span class="pl-k">==</span><span class="pl-smi">last</span>, .(<span class="pl-smi">location_name</span>, <span class="pl-smi">truth</span>)] %<span class="pl-k">&gt;</span>%</td>
      </tr>
      <tr>
        <td id="L63" class="blob-num js-line-number" data-line-number="63"></td>
        <td id="LC63" class="blob-code blob-code-inner js-file-line">  arrange(desc(<span class="pl-smi">truth</span>)) %<span class="pl-k">&gt;</span>%</td>
      </tr>
      <tr>
        <td id="L64" class="blob-num js-line-number" data-line-number="64"></td>
        <td id="LC64" class="blob-code blob-code-inner js-file-line">  unique()</td>
      </tr>
      <tr>
        <td id="L65" class="blob-num js-line-number" data-line-number="65"></td>
        <td id="LC65" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">locs</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">locs</span><span class="pl-k">$</span><span class="pl-smi">location_name</span></td>
      </tr>
      <tr>
        <td id="L66" class="blob-num js-line-number" data-line-number="66"></td>
        <td id="LC66" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[, <span class="pl-smi">location_name</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-k">factor</span>(<span class="pl-smi">location_name</span>, <span class="pl-v">levels</span> <span class="pl-k">=</span> <span class="pl-smi">locs</span>, <span class="pl-v">order</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>)]</td>
      </tr>
      <tr>
        <td id="L67" class="blob-num js-line-number" data-line-number="67"></td>
        <td id="LC67" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L68" class="blob-num js-line-number" data-line-number="68"></td>
        <td id="LC68" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span> Rb Method 10*3 day rolling mean</span></td>
      </tr>
      <tr>
        <td id="L69" class="blob-num js-line-number" data-line-number="69"></td>
        <td id="LC69" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">tf</span>[order(<span class="pl-smi">location_name</span>,<span class="pl-smi">date</span>)]</td>
      </tr>
      <tr>
        <td id="L70" class="blob-num js-line-number" data-line-number="70"></td>
        <td id="LC70" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[, <span class="pl-smi">rb</span> <span class="pl-k">:</span><span class="pl-k">=</span> frollmean(<span class="pl-smi">daily</span>, <span class="pl-c1">3</span>, <span class="pl-v">align</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>center<span class="pl-pds">&quot;</span></span>, <span class="pl-v">na.rm</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">location_name</span>)]</td>
      </tr>
      <tr>
        <td id="L71" class="blob-num js-line-number" data-line-number="71"></td>
        <td id="LC71" class="blob-code blob-code-inner js-file-line"><span class="pl-k">for</span> (<span class="pl-smi">i</span> <span class="pl-k">in</span> <span class="pl-c1">1</span><span class="pl-k">:</span><span class="pl-c1">9</span>) <span class="pl-smi">tf</span>[, <span class="pl-smi">rb</span> <span class="pl-k">:</span><span class="pl-k">=</span> frollmean(<span class="pl-smi">rb</span>, <span class="pl-c1">3</span>, <span class="pl-v">align</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>center<span class="pl-pds">&quot;</span></span>, <span class="pl-v">na.rm</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">location_name</span>)]</td>
      </tr>
      <tr>
        <td id="L72" class="blob-num js-line-number" data-line-number="72"></td>
        <td id="LC72" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span> Single 7 day rolling average</span></td>
      </tr>
      <tr>
        <td id="L73" class="blob-num js-line-number" data-line-number="73"></td>
        <td id="LC73" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[, <span class="pl-smi">ra7</span> <span class="pl-k">:</span><span class="pl-k">=</span> frollmean(<span class="pl-smi">daily</span>, <span class="pl-c1">7</span>, <span class="pl-v">align</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>center<span class="pl-pds">&quot;</span></span>, <span class="pl-v">na.rm</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">location_name</span>)]</td>
      </tr>
      <tr>
        <td id="L74" class="blob-num js-line-number" data-line-number="74"></td>
        <td id="LC74" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span> Loess by timeseries, span of .33</span></td>
      </tr>
      <tr>
        <td id="L75" class="blob-num js-line-number" data-line-number="75"></td>
        <td id="LC75" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[<span class="pl-k">!</span>is.na(<span class="pl-smi">daily</span>) <span class="pl-k">&amp;</span> <span class="pl-k">!</span>is.na(<span class="pl-smi">location_name</span>), <span class="pl-smi">loess</span> <span class="pl-k">:</span><span class="pl-k">=</span> loess(<span class="pl-smi">daily</span> <span class="pl-k">~</span> as.numeric(<span class="pl-smi">date</span>), <span class="pl-v">span</span> <span class="pl-k">=</span> <span class="pl-c1">0.33</span>) %<span class="pl-k">&gt;</span>% predict(), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">location_name</span>)]</td>
      </tr>
      <tr>
        <td id="L76" class="blob-num js-line-number" data-line-number="76"></td>
        <td id="LC76" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L77" class="blob-num js-line-number" data-line-number="77"></td>
        <td id="LC77" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Reshape long</span></td>
      </tr>
      <tr>
        <td id="L78" class="blob-num js-line-number" data-line-number="78"></td>
        <td id="LC78" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span> <span class="pl-k">&lt;-</span> melt(<span class="pl-smi">tf</span>, <span class="pl-v">id.vars</span> <span class="pl-k">=</span> c(<span class="pl-s"><span class="pl-pds">&quot;</span>ihme_loc_id<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>location_name<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>date<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>truth<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>daily<span class="pl-pds">&quot;</span></span>), <span class="pl-v">value.name</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>truth_sm<span class="pl-pds">&quot;</span></span>, <span class="pl-v">variable.name</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>type<span class="pl-pds">&quot;</span></span>)</td>
      </tr>
      <tr>
        <td id="L79" class="blob-num js-line-number" data-line-number="79"></td>
        <td id="LC79" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L80" class="blob-num js-line-number" data-line-number="80"></td>
        <td id="LC80" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Set floor</span></td>
      </tr>
      <tr>
        <td id="L81" class="blob-num js-line-number" data-line-number="81"></td>
        <td id="LC81" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[<span class="pl-smi">truth_sm</span> <span class="pl-k">&lt;</span> <span class="pl-c1">0</span>, <span class="pl-smi">truth_sm</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-c1">0</span>]</td>
      </tr>
      <tr>
        <td id="L82" class="blob-num js-line-number" data-line-number="82"></td>
        <td id="LC82" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L83" class="blob-num js-line-number" data-line-number="83"></td>
        <td id="LC83" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>--Define peaks in truth data-------</span></td>
      </tr>
      <tr>
        <td id="L84" class="blob-num js-line-number" data-line-number="84"></td>
        <td id="LC84" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L85" class="blob-num js-line-number" data-line-number="85"></td>
        <td id="LC85" class="blob-code blob-code-inner js-file-line"><span class="pl-en">findpeak</span> <span class="pl-k">&lt;-</span> <span class="pl-k">function</span>(<span class="pl-smi">x</span>, <span class="pl-smi">y</span>, <span class="pl-smi">w</span>, <span class="pl-smi">t</span>) {</td>
      </tr>
      <tr>
        <td id="L86" class="blob-num js-line-number" data-line-number="86"></td>
        <td id="LC86" class="blob-code blob-code-inner js-file-line">  require(<span class="pl-smi">zoo</span>)</td>
      </tr>
      <tr>
        <td id="L87" class="blob-num js-line-number" data-line-number="87"></td>
        <td id="LC87" class="blob-code blob-code-inner js-file-line">  <span class="pl-c"><span class="pl-c">#</span># Drop missings</span></td>
      </tr>
      <tr>
        <td id="L88" class="blob-num js-line-number" data-line-number="88"></td>
        <td id="LC88" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">i.drop</span> <span class="pl-k">&lt;-</span> is.na(<span class="pl-smi">y</span>)</td>
      </tr>
      <tr>
        <td id="L89" class="blob-num js-line-number" data-line-number="89"></td>
        <td id="LC89" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">x</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">x</span>[<span class="pl-k">!</span><span class="pl-smi">i.drop</span>]</td>
      </tr>
      <tr>
        <td id="L90" class="blob-num js-line-number" data-line-number="90"></td>
        <td id="LC90" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">y</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">y</span>[<span class="pl-k">!</span><span class="pl-smi">i.drop</span>]</td>
      </tr>
      <tr>
        <td id="L91" class="blob-num js-line-number" data-line-number="91"></td>
        <td id="LC91" class="blob-code blob-code-inner js-file-line">  <span class="pl-c"><span class="pl-c">#</span># Find Peak</span></td>
      </tr>
      <tr>
        <td id="L92" class="blob-num js-line-number" data-line-number="92"></td>
        <td id="LC92" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">df</span> <span class="pl-k">&lt;-</span> data.table(<span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">x</span>, <span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">y</span>)</td>
      </tr>
      <tr>
        <td id="L93" class="blob-num js-line-number" data-line-number="93"></td>
        <td id="LC93" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">df</span>[, <span class="pl-smi">y.max</span> <span class="pl-k">:</span><span class="pl-k">=</span> rollapply(<span class="pl-smi">y</span>, <span class="pl-c1">2</span> <span class="pl-k">*</span> <span class="pl-smi">w</span>, <span class="pl-smi">max</span>, <span class="pl-v">align</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>center<span class="pl-pds">&quot;</span></span>, <span class="pl-v">partial</span><span class="pl-k">=</span><span class="pl-c1">T</span>, <span class="pl-v">fill</span> <span class="pl-k">=</span> <span class="pl-c1">NA</span>)]</td>
      </tr>
      <tr>
        <td id="L94" class="blob-num js-line-number" data-line-number="94"></td>
        <td id="LC94" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">df</span>[, <span class="pl-smi">p</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-smi">y</span> <span class="pl-k">&gt;</span><span class="pl-k">=</span> <span class="pl-smi">y.max</span>]</td>
      </tr>
      <tr>
        <td id="L95" class="blob-num js-line-number" data-line-number="95"></td>
        <td id="LC95" class="blob-code blob-code-inner js-file-line">  <span class="pl-c"><span class="pl-c">#</span>--Conditions-----------</span></td>
      </tr>
      <tr>
        <td id="L96" class="blob-num js-line-number" data-line-number="96"></td>
        <td id="LC96" class="blob-code blob-code-inner js-file-line">  <span class="pl-c"><span class="pl-c">#</span># 1. Greater than threshold t</span></td>
      </tr>
      <tr>
        <td id="L97" class="blob-num js-line-number" data-line-number="97"></td>
        <td id="LC97" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">df</span>[, <span class="pl-smi">t</span> <span class="pl-k">:</span><span class="pl-k">=</span> ifelse(<span class="pl-smi">y</span> <span class="pl-k">&gt;</span> <span class="pl-smi">t</span>, <span class="pl-c1">1</span>, <span class="pl-c1">0</span>)]</td>
      </tr>
      <tr>
        <td id="L98" class="blob-num js-line-number" data-line-number="98"></td>
        <td id="LC98" class="blob-code blob-code-inner js-file-line">  <span class="pl-c"><span class="pl-c">#</span># 2. Peak not within 1 week of last date and not the first date</span></td>
      </tr>
      <tr>
        <td id="L99" class="blob-num js-line-number" data-line-number="99"></td>
        <td id="LC99" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">.lastdate</span> <span class="pl-k">&lt;-</span> tail(<span class="pl-smi">x</span>, <span class="pl-c1">1</span>)</td>
      </tr>
      <tr>
        <td id="L100" class="blob-num js-line-number" data-line-number="100"></td>
        <td id="LC100" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">df</span>[, <span class="pl-smi">d</span> <span class="pl-k">:</span><span class="pl-k">=</span> ifelse((<span class="pl-smi">x</span> <span class="pl-k">+</span> <span class="pl-c1">7</span> <span class="pl-k">&lt;</span> <span class="pl-smi">.lastdate</span>) <span class="pl-k">&amp;</span> (<span class="pl-smi">x</span> <span class="pl-k">!=</span> min(<span class="pl-smi">x</span>)), <span class="pl-c1">1</span>, <span class="pl-c1">0</span>)]</td>
      </tr>
      <tr>
        <td id="L101" class="blob-num js-line-number" data-line-number="101"></td>
        <td id="LC101" class="blob-code blob-code-inner js-file-line">  <span class="pl-c"><span class="pl-c">#</span># 3. Peak is not exceeded by i% after n days</span></td>
      </tr>
      <tr>
        <td id="L102" class="blob-num js-line-number" data-line-number="102"></td>
        <td id="LC102" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">df</span>[<span class="pl-smi">p</span> <span class="pl-k">==</span> <span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-smi">t</span> <span class="pl-k">==</span> <span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-smi">d</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>, <span class="pl-smi">m</span> <span class="pl-k">:</span><span class="pl-k">=</span> lapply(<span class="pl-smi">x</span>, <span class="pl-k">function</span>(<span class="pl-smi">z</span>) <span class="pl-smi">df</span>[<span class="pl-smi">x</span> <span class="pl-k">%in%</span> (<span class="pl-smi">z</span><span class="pl-k">:</span>(<span class="pl-smi">z</span> <span class="pl-k">+</span> <span class="pl-c1">21</span>))]<span class="pl-k">$</span><span class="pl-smi">y</span> %<span class="pl-k">&gt;</span>% max())]</td>
      </tr>
      <tr>
        <td id="L103" class="blob-num js-line-number" data-line-number="103"></td>
        <td id="LC103" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">df</span>[<span class="pl-smi">p</span> <span class="pl-k">==</span> <span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-smi">t</span> <span class="pl-k">==</span> <span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-smi">d</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>, <span class="pl-smi">e</span> <span class="pl-k">:</span><span class="pl-k">=</span> ifelse(<span class="pl-k">!</span>(<span class="pl-smi">y</span> <span class="pl-k">*</span> <span class="pl-c1">1.2</span> <span class="pl-k">&lt;</span> <span class="pl-smi">m</span>), <span class="pl-c1">1</span>, <span class="pl-c1">0</span>)]</td>
      </tr>
      <tr>
        <td id="L104" class="blob-num js-line-number" data-line-number="104"></td>
        <td id="LC104" class="blob-code blob-code-inner js-file-line">  <span class="pl-c"><span class="pl-c">#</span># Flag where conditions met</span></td>
      </tr>
      <tr>
        <td id="L105" class="blob-num js-line-number" data-line-number="105"></td>
        <td id="LC105" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">df</span>[, <span class="pl-smi">pf</span> <span class="pl-k">:</span><span class="pl-k">=</span> ifelse(<span class="pl-smi">p</span> <span class="pl-k">==</span> <span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-smi">t</span> <span class="pl-k">==</span> <span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-smi">e</span> <span class="pl-k">==</span> <span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-smi">d</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>, <span class="pl-c1">1</span>, <span class="pl-c1">0</span>)]</td>
      </tr>
      <tr>
        <td id="L106" class="blob-num js-line-number" data-line-number="106"></td>
        <td id="LC106" class="blob-code blob-code-inner js-file-line">  <span class="pl-c"><span class="pl-c">#</span># If multiple peaks, peak is first of such peaks</span></td>
      </tr>
      <tr>
        <td id="L107" class="blob-num js-line-number" data-line-number="107"></td>
        <td id="LC107" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">x.max</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">df</span>[<span class="pl-smi">pf</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>]<span class="pl-k">$</span><span class="pl-smi">x</span></td>
      </tr>
      <tr>
        <td id="L108" class="blob-num js-line-number" data-line-number="108"></td>
        <td id="LC108" class="blob-code blob-code-inner js-file-line">  <span class="pl-k">if</span> (length(<span class="pl-smi">x.max</span>) <span class="pl-k">&gt;</span> <span class="pl-c1">1</span>) <span class="pl-smi">x.max</span> <span class="pl-k">&lt;-</span> min(<span class="pl-smi">x.max</span>)</td>
      </tr>
      <tr>
        <td id="L109" class="blob-num js-line-number" data-line-number="109"></td>
        <td id="LC109" class="blob-code blob-code-inner js-file-line">  <span class="pl-k">return</span>(<span class="pl-smi">x.max</span>)</td>
      </tr>
      <tr>
        <td id="L110" class="blob-num js-line-number" data-line-number="110"></td>
        <td id="LC110" class="blob-code blob-code-inner js-file-line">}</td>
      </tr>
      <tr>
        <td id="L111" class="blob-num js-line-number" data-line-number="111"></td>
        <td id="LC111" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L112" class="blob-num js-line-number" data-line-number="112"></td>
        <td id="LC112" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L113" class="blob-num js-line-number" data-line-number="113"></td>
        <td id="LC113" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Find peak of smoothed truth data</span></td>
      </tr>
      <tr>
        <td id="L114" class="blob-num js-line-number" data-line-number="114"></td>
        <td id="LC114" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[, <span class="pl-smi">peak</span> <span class="pl-k">:</span><span class="pl-k">=</span> ifelse(<span class="pl-smi">date</span> <span class="pl-k">%in%</span> findpeak(<span class="pl-smi">date</span>, <span class="pl-smi">truth_sm</span>, <span class="pl-v">w</span> <span class="pl-k">=</span> <span class="pl-c1">3</span>, <span class="pl-v">t</span> <span class="pl-k">=</span> <span class="pl-c1">5</span>), <span class="pl-c1">1</span>, <span class="pl-c1">0</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">location_name</span>, <span class="pl-smi">type</span>)]</td>
      </tr>
      <tr>
        <td id="L115" class="blob-num js-line-number" data-line-number="115"></td>
        <td id="LC115" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L116" class="blob-num js-line-number" data-line-number="116"></td>
        <td id="LC116" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Frame of true peaks</span></td>
      </tr>
      <tr>
        <td id="L117" class="blob-num js-line-number" data-line-number="117"></td>
        <td id="LC117" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pf.t</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">tf</span>[<span class="pl-smi">peak</span> <span class="pl-k">==</span> <span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-smi">type</span> <span class="pl-k">==</span> <span class="pl-s"><span class="pl-pds">&quot;</span>loess<span class="pl-pds">&quot;</span></span>, .(<span class="pl-smi">location_name</span>, <span class="pl-smi">date</span>)] %<span class="pl-k">&gt;</span>% setnames(<span class="pl-s"><span class="pl-pds">&quot;</span>date<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>date_truth<span class="pl-pds">&quot;</span></span>)</td>
      </tr>
      <tr>
        <td id="L118" class="blob-num js-line-number" data-line-number="118"></td>
        <td id="LC118" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L119" class="blob-num js-line-number" data-line-number="119"></td>
        <td id="LC119" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># graphing name for smoother typs</span></td>
      </tr>
      <tr>
        <td id="L120" class="blob-num js-line-number" data-line-number="120"></td>
        <td id="LC120" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[<span class="pl-smi">type</span> <span class="pl-k">==</span> <span class="pl-s"><span class="pl-pds">&quot;</span>rb<span class="pl-pds">&quot;</span></span>, <span class="pl-smi">smooth_type</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>3 X 10 Day Rolling Average<span class="pl-pds">&quot;</span></span>]</td>
      </tr>
      <tr>
        <td id="L121" class="blob-num js-line-number" data-line-number="121"></td>
        <td id="LC121" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[<span class="pl-smi">type</span> <span class="pl-k">==</span> <span class="pl-s"><span class="pl-pds">&quot;</span>ra7<span class="pl-pds">&quot;</span></span>, <span class="pl-smi">smooth_type</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>7 Day Rolling Average<span class="pl-pds">&quot;</span></span>]</td>
      </tr>
      <tr>
        <td id="L122" class="blob-num js-line-number" data-line-number="122"></td>
        <td id="LC122" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span>[<span class="pl-smi">type</span> <span class="pl-k">==</span> <span class="pl-s"><span class="pl-pds">&quot;</span>loess<span class="pl-pds">&quot;</span></span>, <span class="pl-smi">smooth_type</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Loess<span class="pl-pds">&quot;</span></span>]</td>
      </tr>
      <tr>
        <td id="L123" class="blob-num js-line-number" data-line-number="123"></td>
        <td id="LC123" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L124" class="blob-num js-line-number" data-line-number="124"></td>
        <td id="LC124" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L125" class="blob-num js-line-number" data-line-number="125"></td>
        <td id="LC125" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>--Graph-------</span></td>
      </tr>
      <tr>
        <td id="L126" class="blob-num js-line-number" data-line-number="126"></td>
        <td id="LC126" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L127" class="blob-num js-line-number" data-line-number="127"></td>
        <td id="LC127" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> (<span class="pl-smi">graph.peakmethod</span>) {</td>
      </tr>
      <tr>
        <td id="L128" class="blob-num js-line-number" data-line-number="128"></td>
        <td id="LC128" class="blob-code blob-code-inner js-file-line">  pdf(paste0(<span class="pl-s"><span class="pl-pds">&quot;</span>visuals/daily_smooths_<span class="pl-pds">&quot;</span></span>, Sys.Date(), <span class="pl-s"><span class="pl-pds">&quot;</span>.pdf<span class="pl-pds">&quot;</span></span>), <span class="pl-v">w</span> <span class="pl-k">=</span> <span class="pl-c1">12</span>, <span class="pl-v">h</span> <span class="pl-k">=</span> <span class="pl-c1">8</span>)</td>
      </tr>
      <tr>
        <td id="L129" class="blob-num js-line-number" data-line-number="129"></td>
        <td id="LC129" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">loc.groups</span> <span class="pl-k">&lt;-</span> split(<span class="pl-smi">locs</span>, ceiling(seq_along(<span class="pl-smi">locs</span>) <span class="pl-k">/</span> <span class="pl-c1">9</span>))</td>
      </tr>
      <tr>
        <td id="L130" class="blob-num js-line-number" data-line-number="130"></td>
        <td id="LC130" class="blob-code blob-code-inner js-file-line">  <span class="pl-k">for</span> (<span class="pl-smi">i</span> <span class="pl-k">in</span> <span class="pl-c1">1</span><span class="pl-k">:</span>length(<span class="pl-smi">loc.groups</span>)) {</td>
      </tr>
      <tr>
        <td id="L131" class="blob-num js-line-number" data-line-number="131"></td>
        <td id="LC131" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">p</span> <span class="pl-k">&lt;-</span> ggplot(<span class="pl-smi">tf</span>[<span class="pl-smi">location_name</span> <span class="pl-k">%in%</span> <span class="pl-smi">loc.groups</span>[[<span class="pl-smi">i</span>]]]) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L132" class="blob-num js-line-number" data-line-number="132"></td>
        <td id="LC132" class="blob-code blob-code-inner js-file-line">      geom_point(aes(<span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">date</span>, <span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">daily</span>), <span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">2</span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L133" class="blob-num js-line-number" data-line-number="133"></td>
        <td id="LC133" class="blob-code blob-code-inner js-file-line">      <span class="pl-smi">theme</span> <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L134" class="blob-num js-line-number" data-line-number="134"></td>
        <td id="LC134" class="blob-code blob-code-inner js-file-line">      geom_line(aes(<span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">date</span>, <span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">truth_sm</span>, <span class="pl-v">color</span> <span class="pl-k">=</span> <span class="pl-smi">smooth_type</span>), <span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">2</span>, <span class="pl-v">alpha</span> <span class="pl-k">=</span> <span class="pl-smi">.8</span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L135" class="blob-num js-line-number" data-line-number="135"></td>
        <td id="LC135" class="blob-code blob-code-inner js-file-line">      geom_vline(<span class="pl-v">show.legend</span> <span class="pl-k">=</span> <span class="pl-c1">F</span>, aes(<span class="pl-v">xintercept</span> <span class="pl-k">=</span> ifelse(<span class="pl-smi">peak</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>, <span class="pl-smi">date</span>, <span class="pl-c1">NA</span>), <span class="pl-v">color</span> <span class="pl-k">=</span> <span class="pl-smi">smooth_type</span>), <span class="pl-v">linetype</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>dashed<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L136" class="blob-num js-line-number" data-line-number="136"></td>
        <td id="LC136" class="blob-code blob-code-inner js-file-line">      facet_wrap(<span class="pl-k">~</span><span class="pl-smi">location_name</span>, <span class="pl-v">nrow</span> <span class="pl-k">=</span> <span class="pl-c1">3</span>, <span class="pl-v">scales</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>free<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L137" class="blob-num js-line-number" data-line-number="137"></td>
        <td id="LC137" class="blob-code blob-code-inner js-file-line">      <span class="pl-smi">theme</span> <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L138" class="blob-num js-line-number" data-line-number="138"></td>
        <td id="LC138" class="blob-code blob-code-inner js-file-line">      labs(<span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Month<span class="pl-pds">&quot;</span></span>, <span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Daily Deaths<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L139" class="blob-num js-line-number" data-line-number="139"></td>
        <td id="LC139" class="blob-code blob-code-inner js-file-line">      scale_color_discrete(<span class="pl-v">name</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-pds">&quot;</span></span>)</td>
      </tr>
      <tr>
        <td id="L140" class="blob-num js-line-number" data-line-number="140"></td>
        <td id="LC140" class="blob-code blob-code-inner js-file-line">    print(<span class="pl-smi">p</span>)</td>
      </tr>
      <tr>
        <td id="L141" class="blob-num js-line-number" data-line-number="141"></td>
        <td id="LC141" class="blob-code blob-code-inner js-file-line">  }</td>
      </tr>
      <tr>
        <td id="L142" class="blob-num js-line-number" data-line-number="142"></td>
        <td id="LC142" class="blob-code blob-code-inner js-file-line">  dev.off()</td>
      </tr>
      <tr>
        <td id="L143" class="blob-num js-line-number" data-line-number="143"></td>
        <td id="LC143" class="blob-code blob-code-inner js-file-line">}</td>
      </tr>
      <tr>
        <td id="L144" class="blob-num js-line-number" data-line-number="144"></td>
        <td id="LC144" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L145" class="blob-num js-line-number" data-line-number="145"></td>
        <td id="LC145" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L146" class="blob-num js-line-number" data-line-number="146"></td>
        <td id="LC146" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Keep loess</span></td>
      </tr>
      <tr>
        <td id="L147" class="blob-num js-line-number" data-line-number="147"></td>
        <td id="LC147" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">tf</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">tf</span>[<span class="pl-smi">type</span> <span class="pl-k">==</span> <span class="pl-s"><span class="pl-pds">&quot;</span>loess<span class="pl-pds">&quot;</span></span>]</td>
      </tr>
      <tr>
        <td id="L148" class="blob-num js-line-number" data-line-number="148"></td>
        <td id="LC148" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L149" class="blob-num js-line-number" data-line-number="149"></td>
        <td id="LC149" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>--Identify Model peaks--------------</span></td>
      </tr>
      <tr>
        <td id="L150" class="blob-num js-line-number" data-line-number="150"></td>
        <td id="LC150" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L151" class="blob-num js-line-number" data-line-number="151"></td>
        <td id="LC151" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Subset to locations with peaks identified in truth data</span></td>
      </tr>
      <tr>
        <td id="L152" class="blob-num js-line-number" data-line-number="152"></td>
        <td id="LC152" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">loc.peaks</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">pf.t</span><span class="pl-k">$</span><span class="pl-smi">location_name</span> %<span class="pl-k">&gt;</span>%</td>
      </tr>
      <tr>
        <td id="L153" class="blob-num js-line-number" data-line-number="153"></td>
        <td id="LC153" class="blob-code blob-code-inner js-file-line">  unique() %<span class="pl-k">&gt;</span>%</td>
      </tr>
      <tr>
        <td id="L154" class="blob-num js-line-number" data-line-number="154"></td>
        <td id="LC154" class="blob-code blob-code-inner js-file-line">  sort()</td>
      </tr>
      <tr>
        <td id="L155" class="blob-num js-line-number" data-line-number="155"></td>
        <td id="LC155" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">df</span>[<span class="pl-smi">location_name</span> <span class="pl-k">%in%</span> <span class="pl-smi">loc.peaks</span>]</td>
      </tr>
      <tr>
        <td id="L156" class="blob-num js-line-number" data-line-number="156"></td>
        <td id="LC156" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L157" class="blob-num js-line-number" data-line-number="157"></td>
        <td id="LC157" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Subset to model versions that are  at least 7 days prior to the true peak date</span></td>
      </tr>
      <tr>
        <td id="L158" class="blob-num js-line-number" data-line-number="158"></td>
        <td id="LC158" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span> <span class="pl-k">&lt;-</span> merge(<span class="pl-smi">df</span>, <span class="pl-smi">pf.t</span>, <span class="pl-v">by</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>location_name<span class="pl-pds">&quot;</span></span>, <span class="pl-v">all.x</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>)</td>
      </tr>
      <tr>
        <td id="L159" class="blob-num js-line-number" data-line-number="159"></td>
        <td id="LC159" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">df</span>[<span class="pl-smi">model_date</span> <span class="pl-k">&lt;</span><span class="pl-k">=</span> <span class="pl-smi">date_truth</span> <span class="pl-k">-</span> <span class="pl-c1">7</span>]</td>
      </tr>
      <tr>
        <td id="L160" class="blob-num js-line-number" data-line-number="160"></td>
        <td id="LC160" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L161" class="blob-num js-line-number" data-line-number="161"></td>
        <td id="LC161" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Update loc.peaks</span></td>
      </tr>
      <tr>
        <td id="L162" class="blob-num js-line-number" data-line-number="162"></td>
        <td id="LC162" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">loc.peaks</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">loc.peaks</span>[<span class="pl-smi">loc.peaks</span> <span class="pl-k">%in%</span> <span class="pl-smi">df</span><span class="pl-k">$</span><span class="pl-smi">location_name</span>]</td>
      </tr>
      <tr>
        <td id="L163" class="blob-num js-line-number" data-line-number="163"></td>
        <td id="LC163" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L164" class="blob-num js-line-number" data-line-number="164"></td>
        <td id="LC164" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Smooth</span></td>
      </tr>
      <tr>
        <td id="L165" class="blob-num js-line-number" data-line-number="165"></td>
        <td id="LC165" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">df</span>[order(<span class="pl-smi">location_name</span>, <span class="pl-smi">model</span>, <span class="pl-smi">model_date</span>, <span class="pl-smi">date</span>)]</td>
      </tr>
      <tr>
        <td id="L166" class="blob-num js-line-number" data-line-number="166"></td>
        <td id="LC166" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span>[<span class="pl-k">!</span>is.na(<span class="pl-smi">deaths</span>), <span class="pl-smi">deaths_sm</span> <span class="pl-k">:</span><span class="pl-k">=</span> predict(loess(<span class="pl-smi">deaths</span> <span class="pl-k">~</span> as.numeric(<span class="pl-smi">date</span>), <span class="pl-v">span</span> <span class="pl-k">=</span> <span class="pl-smi">.33</span>)), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">model</span>, <span class="pl-smi">model_date</span>, <span class="pl-smi">location_name</span>)]</td>
      </tr>
      <tr>
        <td id="L167" class="blob-num js-line-number" data-line-number="167"></td>
        <td id="LC167" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span>[<span class="pl-smi">deaths_sm</span><span class="pl-k">&lt;</span><span class="pl-c1">0</span>,<span class="pl-smi">deaths_sm</span><span class="pl-k">:</span><span class="pl-k">=</span><span class="pl-c1">0</span>]</td>
      </tr>
      <tr>
        <td id="L168" class="blob-num js-line-number" data-line-number="168"></td>
        <td id="LC168" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L169" class="blob-num js-line-number" data-line-number="169"></td>
        <td id="LC169" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Find peak</span></td>
      </tr>
      <tr>
        <td id="L170" class="blob-num js-line-number" data-line-number="170"></td>
        <td id="LC170" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span>[, <span class="pl-smi">peak</span> <span class="pl-k">:</span><span class="pl-k">=</span> ifelse(<span class="pl-smi">date</span> <span class="pl-k">%in%</span> findpeak(<span class="pl-smi">date</span>, <span class="pl-smi">deaths_sm</span>, <span class="pl-v">w</span> <span class="pl-k">=</span> <span class="pl-c1">3</span>, <span class="pl-v">t</span> <span class="pl-k">=</span> <span class="pl-c1">5</span>), <span class="pl-c1">1</span>, <span class="pl-c1">0</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">model</span>, <span class="pl-smi">model_date</span>, <span class="pl-smi">location_name</span>)]</td>
      </tr>
      <tr>
        <td id="L171" class="blob-num js-line-number" data-line-number="171"></td>
        <td id="LC171" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L172" class="blob-num js-line-number" data-line-number="172"></td>
        <td id="LC172" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># If the model doesn&#39;t identify a peak, set peak as the max</span></td>
      </tr>
      <tr>
        <td id="L173" class="blob-num js-line-number" data-line-number="173"></td>
        <td id="LC173" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span>[, <span class="pl-smi">pf</span> <span class="pl-k">:</span><span class="pl-k">=</span> max(<span class="pl-smi">peak</span>, <span class="pl-v">na.rm</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">location_name</span>, <span class="pl-smi">model</span>, <span class="pl-smi">model_date</span>)]</td>
      </tr>
      <tr>
        <td id="L174" class="blob-num js-line-number" data-line-number="174"></td>
        <td id="LC174" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span>[<span class="pl-smi">pf</span> <span class="pl-k">==</span> <span class="pl-c1">0</span>, <span class="pl-smi">m</span> <span class="pl-k">:</span><span class="pl-k">=</span> max(<span class="pl-smi">deaths_sm</span>, <span class="pl-v">na.rm</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">location_name</span>, <span class="pl-smi">model</span>, <span class="pl-smi">model_date</span>)]</td>
      </tr>
      <tr>
        <td id="L175" class="blob-num js-line-number" data-line-number="175"></td>
        <td id="LC175" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">df</span>[<span class="pl-smi">pf</span> <span class="pl-k">==</span> <span class="pl-c1">0</span>, <span class="pl-smi">peak</span> <span class="pl-k">:</span><span class="pl-k">=</span> ifelse(<span class="pl-smi">m</span> <span class="pl-k">==</span> <span class="pl-smi">deaths_sm</span>, <span class="pl-c1">1</span>, <span class="pl-c1">0</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> .(<span class="pl-smi">location_name</span>, <span class="pl-smi">model</span>, <span class="pl-smi">model_date</span>)]</td>
      </tr>
      <tr>
        <td id="L176" class="blob-num js-line-number" data-line-number="176"></td>
        <td id="LC176" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L177" class="blob-num js-line-number" data-line-number="177"></td>
        <td id="LC177" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>----------------------------------------</span></td>
      </tr>
      <tr>
        <td id="L178" class="blob-num js-line-number" data-line-number="178"></td>
        <td id="LC178" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L179" class="blob-num js-line-number" data-line-number="179"></td>
        <td id="LC179" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Graph - Model daily deaths and peak dates</span></td>
      </tr>
      <tr>
        <td id="L180" class="blob-num js-line-number" data-line-number="180"></td>
        <td id="LC180" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> (<span class="pl-smi">graph.peakcomparison</span>) {</td>
      </tr>
      <tr>
        <td id="L181" class="blob-num js-line-number" data-line-number="181"></td>
        <td id="LC181" class="blob-code blob-code-inner js-file-line">  pdf(paste0(<span class="pl-s"><span class="pl-pds">&quot;</span>visuals/daily_peak_comparison_graphs_<span class="pl-pds">&quot;</span></span>, Sys.Date(), <span class="pl-s"><span class="pl-pds">&quot;</span>.pdf<span class="pl-pds">&quot;</span></span>), <span class="pl-v">width</span> <span class="pl-k">=</span> <span class="pl-c1">12</span>, <span class="pl-v">height</span> <span class="pl-k">=</span> <span class="pl-c1">6</span>)</td>
      </tr>
      <tr>
        <td id="L182" class="blob-num js-line-number" data-line-number="182"></td>
        <td id="LC182" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L183" class="blob-num js-line-number" data-line-number="183"></td>
        <td id="LC183" class="blob-code blob-code-inner js-file-line">  <span class="pl-k">for</span> (<span class="pl-smi">.loc</span> <span class="pl-k">in</span> <span class="pl-smi">loc.peaks</span>) {</td>
      </tr>
      <tr>
        <td id="L184" class="blob-num js-line-number" data-line-number="184"></td>
        <td id="LC184" class="blob-code blob-code-inner js-file-line">    print(<span class="pl-smi">.loc</span>)</td>
      </tr>
      <tr>
        <td id="L185" class="blob-num js-line-number" data-line-number="185"></td>
        <td id="LC185" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">.max</span> <span class="pl-k">&lt;-</span> <span class="pl-c1">1.1</span> <span class="pl-k">*</span> max(<span class="pl-smi">df</span>[<span class="pl-smi">location_name</span> <span class="pl-k">==</span> <span class="pl-smi">.loc</span> <span class="pl-k">&amp;</span> <span class="pl-smi">model</span> <span class="pl-k">!=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>imperial<span class="pl-pds">&quot;</span></span>, <span class="pl-smi">deaths_sm</span> <span class="pl-k">/</span> <span class="pl-c1">1000</span>], <span class="pl-smi">tf</span>[<span class="pl-smi">location_name</span> <span class="pl-k">==</span> <span class="pl-smi">.loc</span>, <span class="pl-smi">truth_sm</span> <span class="pl-k">/</span> <span class="pl-c1">1000</span>], <span class="pl-v">na.rm</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>)</td>
      </tr>
      <tr>
        <td id="L186" class="blob-num js-line-number" data-line-number="186"></td>
        <td id="LC186" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">.mods</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">df</span>[<span class="pl-smi">location_name</span> <span class="pl-k">==</span> <span class="pl-smi">.loc</span> <span class="pl-k">&amp;</span> <span class="pl-smi">peak</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>]<span class="pl-k">$</span><span class="pl-smi">model</span> %<span class="pl-k">&gt;</span>% unique()</td>
      </tr>
      <tr>
        <td id="L187" class="blob-num js-line-number" data-line-number="187"></td>
        <td id="LC187" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L188" class="blob-num js-line-number" data-line-number="188"></td>
        <td id="LC188" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L189" class="blob-num js-line-number" data-line-number="189"></td>
        <td id="LC189" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">.start</span> <span class="pl-k">&lt;-</span> min(<span class="pl-smi">tf</span>[<span class="pl-smi">truth</span> <span class="pl-k">&gt;</span> <span class="pl-c1">0</span> <span class="pl-k">&amp;</span> <span class="pl-smi">location_name</span><span class="pl-k">==</span><span class="pl-smi">.loc</span>, <span class="pl-smi">date</span>]) <span class="pl-k">-</span> <span class="pl-c1">8</span></td>
      </tr>
      <tr>
        <td id="L190" class="blob-num js-line-number" data-line-number="190"></td>
        <td id="LC190" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">.end</span> <span class="pl-k">&lt;-</span> max(<span class="pl-smi">df</span>[<span class="pl-smi">location_name</span><span class="pl-k">==</span><span class="pl-smi">.loc</span>, <span class="pl-smi">date</span>]) <span class="pl-k">+</span> <span class="pl-c1">7</span></td>
      </tr>
      <tr>
        <td id="L191" class="blob-num js-line-number" data-line-number="191"></td>
        <td id="LC191" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L192" class="blob-num js-line-number" data-line-number="192"></td>
        <td id="LC192" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">d</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">df</span>[<span class="pl-smi">location_name</span> <span class="pl-k">==</span> <span class="pl-smi">.loc</span> <span class="pl-k">&amp;</span> <span class="pl-smi">date</span> <span class="pl-k">&gt;</span> <span class="pl-smi">.start</span> <span class="pl-k">&amp;</span> <span class="pl-smi">model</span> <span class="pl-k">%in%</span> <span class="pl-smi">.mods</span>]</td>
      </tr>
      <tr>
        <td id="L193" class="blob-num js-line-number" data-line-number="193"></td>
        <td id="LC193" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">t</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">tf</span>[<span class="pl-smi">location_name</span> <span class="pl-k">==</span> <span class="pl-smi">.loc</span> <span class="pl-k">&amp;</span> <span class="pl-smi">date</span> <span class="pl-k">&gt;</span> <span class="pl-smi">.start</span>]</td>
      </tr>
      <tr>
        <td id="L194" class="blob-num js-line-number" data-line-number="194"></td>
        <td id="LC194" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L195" class="blob-num js-line-number" data-line-number="195"></td>
        <td id="LC195" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L196" class="blob-num js-line-number" data-line-number="196"></td>
        <td id="LC196" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L197" class="blob-num js-line-number" data-line-number="197"></td>
        <td id="LC197" class="blob-code blob-code-inner js-file-line">    <span class="pl-c"><span class="pl-c">#</span># Graph of daily death forecasts</span></td>
      </tr>
      <tr>
        <td id="L198" class="blob-num js-line-number" data-line-number="198"></td>
        <td id="LC198" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">gg1</span> <span class="pl-k">&lt;-</span> ggplot() <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L199" class="blob-num js-line-number" data-line-number="199"></td>
        <td id="LC199" class="blob-code blob-code-inner js-file-line">      <span class="pl-c"><span class="pl-c">#</span># Model forecasts</span></td>
      </tr>
      <tr>
        <td id="L200" class="blob-num js-line-number" data-line-number="200"></td>
        <td id="LC200" class="blob-code blob-code-inner js-file-line">      geom_line(<span class="pl-v">data</span> <span class="pl-k">=</span> <span class="pl-smi">d</span>, aes(<span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">date</span>, <span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">deaths_sm</span> <span class="pl-k">/</span> <span class="pl-c1">1000</span>, <span class="pl-v">group</span> <span class="pl-k">=</span> <span class="pl-smi">model_date</span>, <span class="pl-v">color</span> <span class="pl-k">=</span> <span class="pl-smi">model_long</span>, <span class="pl-v">alpha</span> <span class="pl-k">=</span> <span class="pl-smi">model_date</span>), <span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">2</span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L201" class="blob-num js-line-number" data-line-number="201"></td>
        <td id="LC201" class="blob-code blob-code-inner js-file-line">      <span class="pl-c"><span class="pl-c">#</span># Predicted peak</span></td>
      </tr>
      <tr>
        <td id="L202" class="blob-num js-line-number" data-line-number="202"></td>
        <td id="LC202" class="blob-code blob-code-inner js-file-line">      geom_point(<span class="pl-v">data</span> <span class="pl-k">=</span> <span class="pl-smi">d</span>[<span class="pl-smi">peak</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>], aes(<span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">date</span>, <span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">deaths_sm</span> <span class="pl-k">/</span> <span class="pl-c1">1000</span>, <span class="pl-v">color</span> <span class="pl-k">=</span> <span class="pl-smi">model_long</span>), <span class="pl-v">shape</span> <span class="pl-k">=</span> <span class="pl-c1">21</span>, <span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">2</span>, <span class="pl-v">fill</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>white<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L203" class="blob-num js-line-number" data-line-number="203"></td>
        <td id="LC203" class="blob-code blob-code-inner js-file-line">      <span class="pl-c"><span class="pl-c">#</span># Truth</span></td>
      </tr>
      <tr>
        <td id="L204" class="blob-num js-line-number" data-line-number="204"></td>
        <td id="LC204" class="blob-code blob-code-inner js-file-line">      geom_point(<span class="pl-v">data</span> <span class="pl-k">=</span> <span class="pl-smi">t</span>, aes(<span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">date</span>, <span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">truth_sm</span> <span class="pl-k">/</span> <span class="pl-c1">1000</span>), <span class="pl-v">shape</span> <span class="pl-k">=</span> <span class="pl-c1">21</span>, <span class="pl-v">fill</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>white<span class="pl-pds">&quot;</span></span>, <span class="pl-v">color</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>black<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L205" class="blob-num js-line-number" data-line-number="205"></td>
        <td id="LC205" class="blob-code blob-code-inner js-file-line">      <span class="pl-c"><span class="pl-c">#</span># True peak</span></td>
      </tr>
      <tr>
        <td id="L206" class="blob-num js-line-number" data-line-number="206"></td>
        <td id="LC206" class="blob-code blob-code-inner js-file-line">      geom_vline(<span class="pl-v">data</span> <span class="pl-k">=</span> <span class="pl-smi">t</span>[<span class="pl-smi">peak</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>], aes(<span class="pl-v">xintercept</span> <span class="pl-k">=</span> <span class="pl-smi">date</span>), <span class="pl-v">linetype</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>dashed<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L207" class="blob-num js-line-number" data-line-number="207"></td>
        <td id="LC207" class="blob-code blob-code-inner js-file-line">      <span class="pl-c"><span class="pl-c">#</span># Settings</span></td>
      </tr>
      <tr>
        <td id="L208" class="blob-num js-line-number" data-line-number="208"></td>
        <td id="LC208" class="blob-code blob-code-inner js-file-line">      scale_x_date(<span class="pl-en">breaks</span> <span class="pl-k">=</span> <span class="pl-k">function</span>(<span class="pl-smi">x</span>) seq.Date(<span class="pl-v">from</span> <span class="pl-k">=</span> min(<span class="pl-smi">x</span>) %<span class="pl-k">&gt;</span>% floor_date(<span class="pl-s"><span class="pl-pds">&quot;</span>month<span class="pl-pds">&quot;</span></span>), <span class="pl-v">to</span> <span class="pl-k">=</span> max(<span class="pl-smi">x</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>1 months<span class="pl-pds">&quot;</span></span>), <span class="pl-v">date_labels</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>%b<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L209" class="blob-num js-line-number" data-line-number="209"></td>
        <td id="LC209" class="blob-code blob-code-inner js-file-line">      theme_bw() <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L210" class="blob-num js-line-number" data-line-number="210"></td>
        <td id="LC210" class="blob-code blob-code-inner js-file-line">      <span class="pl-smi">theme</span> <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L211" class="blob-num js-line-number" data-line-number="211"></td>
        <td id="LC211" class="blob-code blob-code-inner js-file-line">      theme(<span class="pl-v">axis.text.x</span> <span class="pl-k">=</span> element_text(<span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">8</span>, <span class="pl-v">face</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>)) <span class="pl-k">+</span> </td>
      </tr>
      <tr>
        <td id="L212" class="blob-num js-line-number" data-line-number="212"></td>
        <td id="LC212" class="blob-code blob-code-inner js-file-line">      guides(<span class="pl-v">alpha</span> <span class="pl-k">=</span> <span class="pl-c1">F</span>, <span class="pl-v">color</span> <span class="pl-k">=</span> <span class="pl-c1">F</span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L213" class="blob-num js-line-number" data-line-number="213"></td>
        <td id="LC213" class="blob-code blob-code-inner js-file-line">      labs(<span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Deaths (Thousands)<span class="pl-pds">&quot;</span></span>, <span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Week of<span class="pl-pds">&quot;</span></span>, <span class="pl-v">title</span> <span class="pl-k">=</span> paste0(<span class="pl-smi">.loc</span>, <span class="pl-s"><span class="pl-pds">&quot;</span> - Smoothed Daily Deaths<span class="pl-pds">&quot;</span></span>)) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L214" class="blob-num js-line-number" data-line-number="214"></td>
        <td id="LC214" class="blob-code blob-code-inner js-file-line">      scale_color_manual(<span class="pl-v">values</span> <span class="pl-k">=</span> <span class="pl-smi">c.vals</span>, <span class="pl-v">name</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L215" class="blob-num js-line-number" data-line-number="215"></td>
        <td id="LC215" class="blob-code blob-code-inner js-file-line">      coord_cartesian(<span class="pl-v">ylim</span> <span class="pl-k">=</span> c(<span class="pl-c1">0</span>, <span class="pl-smi">.max</span>), <span class="pl-v">xlim</span> <span class="pl-k">=</span> c(<span class="pl-smi">.start</span>, <span class="pl-smi">.end</span>)) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L216" class="blob-num js-line-number" data-line-number="216"></td>
        <td id="LC216" class="blob-code blob-code-inner js-file-line">      facet_wrap(<span class="pl-k">~</span><span class="pl-smi">model_long</span>, <span class="pl-v">nrow</span> <span class="pl-k">=</span> <span class="pl-c1">1</span>)</td>
      </tr>
      <tr>
        <td id="L217" class="blob-num js-line-number" data-line-number="217"></td>
        <td id="LC217" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L218" class="blob-num js-line-number" data-line-number="218"></td>
        <td id="LC218" class="blob-code blob-code-inner js-file-line">    <span class="pl-c"><span class="pl-c">#</span># Graph of predicted peaks by model date</span></td>
      </tr>
      <tr>
        <td id="L219" class="blob-num js-line-number" data-line-number="219"></td>
        <td id="LC219" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">gg2</span> <span class="pl-k">&lt;-</span> ggplot() <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L220" class="blob-num js-line-number" data-line-number="220"></td>
        <td id="LC220" class="blob-code blob-code-inner js-file-line">      <span class="pl-c"><span class="pl-c">#</span># True peak</span></td>
      </tr>
      <tr>
        <td id="L221" class="blob-num js-line-number" data-line-number="221"></td>
        <td id="LC221" class="blob-code blob-code-inner js-file-line">      geom_vline(<span class="pl-v">data</span> <span class="pl-k">=</span> <span class="pl-smi">t</span>[<span class="pl-smi">peak</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>], aes(<span class="pl-v">xintercept</span> <span class="pl-k">=</span> <span class="pl-smi">date</span>), <span class="pl-v">linetype</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>dashed<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L222" class="blob-num js-line-number" data-line-number="222"></td>
        <td id="LC222" class="blob-code blob-code-inner js-file-line">      <span class="pl-c"><span class="pl-c">#</span># Predicted peaks</span></td>
      </tr>
      <tr>
        <td id="L223" class="blob-num js-line-number" data-line-number="223"></td>
        <td id="LC223" class="blob-code blob-code-inner js-file-line">      geom_point(<span class="pl-v">data</span> <span class="pl-k">=</span> <span class="pl-smi">d</span>[<span class="pl-smi">peak</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>], aes(<span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">date</span>, <span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">model_date</span>, <span class="pl-v">color</span> <span class="pl-k">=</span> <span class="pl-smi">model_long</span>, <span class="pl-v">fill</span> <span class="pl-k">=</span> <span class="pl-smi">model_long</span>)) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L224" class="blob-num js-line-number" data-line-number="224"></td>
        <td id="LC224" class="blob-code blob-code-inner js-file-line">      <span class="pl-c"><span class="pl-c">#</span># Settings</span></td>
      </tr>
      <tr>
        <td id="L225" class="blob-num js-line-number" data-line-number="225"></td>
        <td id="LC225" class="blob-code blob-code-inner js-file-line">      scale_x_date(<span class="pl-en">breaks</span> <span class="pl-k">=</span> <span class="pl-k">function</span>(<span class="pl-smi">x</span>) seq.Date(<span class="pl-v">from</span> <span class="pl-k">=</span> min(<span class="pl-smi">x</span>) %<span class="pl-k">&gt;</span>% floor_date(<span class="pl-s"><span class="pl-pds">&quot;</span>month<span class="pl-pds">&quot;</span></span>), <span class="pl-v">to</span> <span class="pl-k">=</span> max(<span class="pl-smi">x</span>), <span class="pl-v">by</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>1 months<span class="pl-pds">&quot;</span></span>), <span class="pl-v">date_labels</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>%b<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L226" class="blob-num js-line-number" data-line-number="226"></td>
        <td id="LC226" class="blob-code blob-code-inner js-file-line">      scale_color_manual(<span class="pl-v">values</span> <span class="pl-k">=</span> <span class="pl-smi">c.vals</span>, <span class="pl-v">name</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L227" class="blob-num js-line-number" data-line-number="227"></td>
        <td id="LC227" class="blob-code blob-code-inner js-file-line">      scale_fill_manual(<span class="pl-v">values</span> <span class="pl-k">=</span> <span class="pl-smi">c.vals</span>, <span class="pl-v">name</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L228" class="blob-num js-line-number" data-line-number="228"></td>
        <td id="LC228" class="blob-code blob-code-inner js-file-line">      labs(<span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Model Date<span class="pl-pds">&quot;</span></span>, <span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Actual and Predicted Peak<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L229" class="blob-num js-line-number" data-line-number="229"></td>
        <td id="LC229" class="blob-code blob-code-inner js-file-line">      theme_bw() <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L230" class="blob-num js-line-number" data-line-number="230"></td>
        <td id="LC230" class="blob-code blob-code-inner js-file-line">      <span class="pl-smi">theme</span> <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L231" class="blob-num js-line-number" data-line-number="231"></td>
        <td id="LC231" class="blob-code blob-code-inner js-file-line">      theme(<span class="pl-v">axis.text.x</span> <span class="pl-k">=</span> element_text(<span class="pl-v">size</span> <span class="pl-k">=</span> <span class="pl-c1">8</span>, <span class="pl-v">face</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>)) <span class="pl-k">+</span> </td>
      </tr>
      <tr>
        <td id="L232" class="blob-num js-line-number" data-line-number="232"></td>
        <td id="LC232" class="blob-code blob-code-inner js-file-line">      guides(<span class="pl-v">fill</span> <span class="pl-k">=</span> <span class="pl-c1">F</span>, <span class="pl-v">color</span> <span class="pl-k">=</span> <span class="pl-c1">F</span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L233" class="blob-num js-line-number" data-line-number="233"></td>
        <td id="LC233" class="blob-code blob-code-inner js-file-line">      coord_cartesian(<span class="pl-v">xlim</span> <span class="pl-k">=</span> c(<span class="pl-smi">.start</span>, <span class="pl-smi">.end</span>)) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L234" class="blob-num js-line-number" data-line-number="234"></td>
        <td id="LC234" class="blob-code blob-code-inner js-file-line">      facet_wrap(<span class="pl-k">~</span><span class="pl-smi">model_long</span>, <span class="pl-v">nrow</span> <span class="pl-k">=</span> <span class="pl-c1">1</span>)</td>
      </tr>
      <tr>
        <td id="L235" class="blob-num js-line-number" data-line-number="235"></td>
        <td id="LC235" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L236" class="blob-num js-line-number" data-line-number="236"></td>
        <td id="LC236" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">gg</span> <span class="pl-k">&lt;-</span> plot_grid(<span class="pl-smi">gg1</span>, <span class="pl-smi">gg2</span>, <span class="pl-v">align</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>v<span class="pl-pds">&quot;</span></span>, <span class="pl-v">axis</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>lr<span class="pl-pds">&quot;</span></span>, <span class="pl-v">ncol</span> <span class="pl-k">=</span> <span class="pl-c1">1</span>, <span class="pl-v">rel_heights</span> <span class="pl-k">=</span> c(<span class="pl-c1">1</span>, <span class="pl-smi">.5</span>))</td>
      </tr>
      <tr>
        <td id="L237" class="blob-num js-line-number" data-line-number="237"></td>
        <td id="LC237" class="blob-code blob-code-inner js-file-line">    print(<span class="pl-smi">gg</span>)</td>
      </tr>
      <tr>
        <td id="L238" class="blob-num js-line-number" data-line-number="238"></td>
        <td id="LC238" class="blob-code blob-code-inner js-file-line">  }</td>
      </tr>
      <tr>
        <td id="L239" class="blob-num js-line-number" data-line-number="239"></td>
        <td id="LC239" class="blob-code blob-code-inner js-file-line">  dev.off()</td>
      </tr>
      <tr>
        <td id="L240" class="blob-num js-line-number" data-line-number="240"></td>
        <td id="LC240" class="blob-code blob-code-inner js-file-line">}</td>
      </tr>
      <tr>
        <td id="L241" class="blob-num js-line-number" data-line-number="241"></td>
        <td id="LC241" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L242" class="blob-num js-line-number" data-line-number="242"></td>
        <td id="LC242" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>--Predictive Validity on Peak---------------------------------------</span></td>
      </tr>
      <tr>
        <td id="L243" class="blob-num js-line-number" data-line-number="243"></td>
        <td id="LC243" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L244" class="blob-num js-line-number" data-line-number="244"></td>
        <td id="LC244" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Subset to peak frame</span></td>
      </tr>
      <tr>
        <td id="L245" class="blob-num js-line-number" data-line-number="245"></td>
        <td id="LC245" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pf</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">df</span>[<span class="pl-smi">peak</span> <span class="pl-k">==</span> <span class="pl-c1">1</span>]</td>
      </tr>
      <tr>
        <td id="L246" class="blob-num js-line-number" data-line-number="246"></td>
        <td id="LC246" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L247" class="blob-num js-line-number" data-line-number="247"></td>
        <td id="LC247" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Calculate prediction week</span></td>
      </tr>
      <tr>
        <td id="L248" class="blob-num js-line-number" data-line-number="248"></td>
        <td id="LC248" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pf</span>[, <span class="pl-smi">wk</span> <span class="pl-k">:</span><span class="pl-k">=</span> as.numeric(floor((<span class="pl-smi">date_truth</span> <span class="pl-k">-</span> <span class="pl-smi">model_date</span>) <span class="pl-k">/</span> <span class="pl-c1">7</span>))]</td>
      </tr>
      <tr>
        <td id="L249" class="blob-num js-line-number" data-line-number="249"></td>
        <td id="LC249" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L250" class="blob-num js-line-number" data-line-number="250"></td>
        <td id="LC250" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Error Stats</span></td>
      </tr>
      <tr>
        <td id="L251" class="blob-num js-line-number" data-line-number="251"></td>
        <td id="LC251" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pf</span>[, <span class="pl-smi">error</span> <span class="pl-k">:</span><span class="pl-k">=</span> as.numeric(<span class="pl-smi">date</span> <span class="pl-k">-</span> <span class="pl-smi">date_truth</span>)]</td>
      </tr>
      <tr>
        <td id="L252" class="blob-num js-line-number" data-line-number="252"></td>
        <td id="LC252" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pf</span>[, <span class="pl-smi">abs_error</span> <span class="pl-k">:</span><span class="pl-k">=</span> abs(<span class="pl-smi">error</span>)]</td>
      </tr>
      <tr>
        <td id="L253" class="blob-num js-line-number" data-line-number="253"></td>
        <td id="LC253" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L254" class="blob-num js-line-number" data-line-number="254"></td>
        <td id="LC254" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span># Create a &quot;pooled&quot; model and refactor</span></td>
      </tr>
      <tr>
        <td id="L255" class="blob-num js-line-number" data-line-number="255"></td>
        <td id="LC255" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pool</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">pf</span> %<span class="pl-k">&gt;</span>% copy()</td>
      </tr>
      <tr>
        <td id="L256" class="blob-num js-line-number" data-line-number="256"></td>
        <td id="LC256" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pool</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">pool</span>[, <span class="pl-smi">model_short</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Pooled<span class="pl-pds">&quot;</span></span>]</td>
      </tr>
      <tr>
        <td id="L257" class="blob-num js-line-number" data-line-number="257"></td>
        <td id="LC257" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pf</span> <span class="pl-k">&lt;-</span> rbind(<span class="pl-smi">pf</span>, <span class="pl-smi">pool</span>)</td>
      </tr>
      <tr>
        <td id="L258" class="blob-num js-line-number" data-line-number="258"></td>
        <td id="LC258" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pf</span>[, <span class="pl-smi">model_short</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-k">factor</span>(<span class="pl-smi">model_short</span>, <span class="pl-v">levels</span> <span class="pl-k">=</span> levels(<span class="pl-smi">model_short</span>), <span class="pl-v">ordered</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>)]</td>
      </tr>
      <tr>
        <td id="L259" class="blob-num js-line-number" data-line-number="259"></td>
        <td id="LC259" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L260" class="blob-num js-line-number" data-line-number="260"></td>
        <td id="LC260" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span> Month of estimation</span></td>
      </tr>
      <tr>
        <td id="L261" class="blob-num js-line-number" data-line-number="261"></td>
        <td id="LC261" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pf</span>[, <span class="pl-smi">model_month</span> <span class="pl-k">:</span><span class="pl-k">=</span> format(<span class="pl-smi">model_date</span>, <span class="pl-v">format</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>%b<span class="pl-pds">&quot;</span></span>)]</td>
      </tr>
      <tr>
        <td id="L262" class="blob-num js-line-number" data-line-number="262"></td>
        <td id="LC262" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">pf</span>[, <span class="pl-smi">model_month</span> <span class="pl-k">:</span><span class="pl-k">=</span> <span class="pl-k">factor</span>(<span class="pl-smi">model_month</span>, <span class="pl-v">levels</span> <span class="pl-k">=</span> c(<span class="pl-s"><span class="pl-pds">&quot;</span>Mar<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>Apr<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>May<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>Jun<span class="pl-pds">&quot;</span></span>))]</td>
      </tr>
      <tr>
        <td id="L263" class="blob-num js-line-number" data-line-number="263"></td>
        <td id="LC263" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L264" class="blob-num js-line-number" data-line-number="264"></td>
        <td id="LC264" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L265" class="blob-num js-line-number" data-line-number="265"></td>
        <td id="LC265" class="blob-code blob-code-inner js-file-line"><span class="pl-en">peak.stats</span> <span class="pl-k">&lt;-</span> <span class="pl-k">function</span>(<span class="pl-smi">t</span>, <span class="pl-smi">by</span>) {</td>
      </tr>
      <tr>
        <td id="L266" class="blob-num js-line-number" data-line-number="266"></td>
        <td id="LC266" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">t</span>[, `:=`(<span class="pl-v">num</span> <span class="pl-k">=</span> uniqueN(<span class="pl-smi">location_name</span>), <span class="pl-v">me</span> <span class="pl-k">=</span> median(<span class="pl-smi">error</span>, <span class="pl-v">na.rm</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>), <span class="pl-v">mae</span> <span class="pl-k">=</span> median(<span class="pl-smi">abs_error</span>, <span class="pl-v">na.rm</span> <span class="pl-k">=</span> <span class="pl-c1">T</span>)), <span class="pl-v">by</span> <span class="pl-k">=</span> <span class="pl-smi">by</span>]</td>
      </tr>
      <tr>
        <td id="L267" class="blob-num js-line-number" data-line-number="267"></td>
        <td id="LC267" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">t</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">t</span>[, c(<span class="pl-smi">by</span>, <span class="pl-s"><span class="pl-pds">&quot;</span>num<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>me<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>mae<span class="pl-pds">&quot;</span></span>), <span class="pl-v">with</span> <span class="pl-k">=</span> <span class="pl-c1">F</span>] %<span class="pl-k">&gt;</span>% unique()</td>
      </tr>
      <tr>
        <td id="L268" class="blob-num js-line-number" data-line-number="268"></td>
        <td id="LC268" class="blob-code blob-code-inner js-file-line">}</td>
      </tr>
      <tr>
        <td id="L269" class="blob-num js-line-number" data-line-number="269"></td>
        <td id="LC269" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L270" class="blob-num js-line-number" data-line-number="270"></td>
        <td id="LC270" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">error.mod</span> <span class="pl-k">&lt;-</span> peak.stats(<span class="pl-smi">pf</span>, <span class="pl-v">by</span> <span class="pl-k">=</span> c(<span class="pl-s"><span class="pl-pds">&quot;</span>model_short<span class="pl-pds">&quot;</span></span>)) %<span class="pl-k">&gt;</span>% mutate(<span class="pl-v">wk</span> <span class="pl-k">=</span> <span class="pl-c1">0</span>) %<span class="pl-k">&gt;</span>% data.table()</td>
      </tr>
      <tr>
        <td id="L271" class="blob-num js-line-number" data-line-number="271"></td>
        <td id="LC271" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">error.m.wk</span> <span class="pl-k">&lt;-</span> peak.stats(<span class="pl-smi">pf</span>, <span class="pl-v">by</span> <span class="pl-k">=</span> c(<span class="pl-s"><span class="pl-pds">&quot;</span>model_short<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>model_month<span class="pl-pds">&quot;</span></span>,<span class="pl-s"><span class="pl-pds">&quot;</span>wk<span class="pl-pds">&quot;</span></span>))%<span class="pl-k">&gt;</span>% mutate(<span class="pl-v">super_region_name</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Global<span class="pl-pds">&quot;</span></span>) %<span class="pl-k">&gt;</span>% data.table()</td>
      </tr>
      <tr>
        <td id="L272" class="blob-num js-line-number" data-line-number="272"></td>
        <td id="LC272" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">error.m.wk.sr</span> <span class="pl-k">&lt;-</span> peak.stats(<span class="pl-smi">pf</span>, <span class="pl-v">by</span> <span class="pl-k">=</span> c(<span class="pl-s"><span class="pl-pds">&quot;</span>model_short<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>model_month<span class="pl-pds">&quot;</span></span>,<span class="pl-s"><span class="pl-pds">&quot;</span>wk<span class="pl-pds">&quot;</span></span>,<span class="pl-s"><span class="pl-pds">&quot;</span>super_region_name<span class="pl-pds">&quot;</span></span>))</td>
      </tr>
      <tr>
        <td id="L273" class="blob-num js-line-number" data-line-number="273"></td>
        <td id="LC273" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L274" class="blob-num js-line-number" data-line-number="274"></td>
        <td id="LC274" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L275" class="blob-num js-line-number" data-line-number="275"></td>
        <td id="LC275" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L276" class="blob-num js-line-number" data-line-number="276"></td>
        <td id="LC276" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>--Graph-------------------------------------------</span></td>
      </tr>
      <tr>
        <td id="L277" class="blob-num js-line-number" data-line-number="277"></td>
        <td id="LC277" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L278" class="blob-num js-line-number" data-line-number="278"></td>
        <td id="LC278" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> (<span class="pl-smi">graph.peakpv</span>) {</td>
      </tr>
      <tr>
        <td id="L279" class="blob-num js-line-number" data-line-number="279"></td>
        <td id="LC279" class="blob-code blob-code-inner js-file-line">  pdf(paste0(<span class="pl-s"><span class="pl-pds">&quot;</span>visuals/Figure_4_<span class="pl-pds">&quot;</span></span>, Sys.Date(), <span class="pl-s"><span class="pl-pds">&quot;</span>.pdf<span class="pl-pds">&quot;</span></span>), <span class="pl-v">width</span> <span class="pl-k">=</span> <span class="pl-c1">3</span>, <span class="pl-v">height</span> <span class="pl-k">=</span> <span class="pl-c1">8</span>)</td>
      </tr>
      <tr>
        <td id="L280" class="blob-num js-line-number" data-line-number="280"></td>
        <td id="LC280" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L281" class="blob-num js-line-number" data-line-number="281"></td>
        <td id="LC281" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">bar.mae</span> <span class="pl-k">&lt;-</span> scale_fill_gradient2(<span class="pl-v">high</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#d73027<span class="pl-pds">&quot;</span></span>, <span class="pl-v">low</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#4575b4<span class="pl-pds">&quot;</span></span>, <span class="pl-v">mid</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#ffffbf<span class="pl-pds">&quot;</span></span>, <span class="pl-v">midpoint</span> <span class="pl-k">=</span> <span class="pl-c1">30</span>, <span class="pl-v">name</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-pds">&quot;</span></span>, <span class="pl-v">breaks</span> <span class="pl-k">=</span> seq(<span class="pl-c1">0</span>, <span class="pl-c1">50</span>, <span class="pl-c1">25</span>), <span class="pl-v">labels</span> <span class="pl-k">=</span> paste0(seq(<span class="pl-c1">0</span>, <span class="pl-c1">50</span>, <span class="pl-c1">25</span>), <span class="pl-s"><span class="pl-pds">&quot;</span> Days<span class="pl-pds">&quot;</span></span>), <span class="pl-v">guide</span> <span class="pl-k">=</span> guide_colorbar(<span class="pl-v">barwidth</span> <span class="pl-k">=</span> <span class="pl-c1">10</span>, <span class="pl-v">barheight</span> <span class="pl-k">=</span> <span class="pl-smi">.3</span>), <span class="pl-v">na.value</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>white<span class="pl-pds">&quot;</span></span>, <span class="pl-v">limits</span> <span class="pl-k">=</span> c(<span class="pl-c1">0</span>, <span class="pl-c1">55</span>))</td>
      </tr>
      <tr>
        <td id="L282" class="blob-num js-line-number" data-line-number="282"></td>
        <td id="LC282" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">bar.me</span> <span class="pl-k">&lt;-</span> scale_fill_gradient2(<span class="pl-v">high</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#ef8a62<span class="pl-pds">&quot;</span></span>, <span class="pl-v">low</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#ef8a62<span class="pl-pds">&quot;</span></span>, <span class="pl-v">mid</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>#67a9cf<span class="pl-pds">&quot;</span></span>, <span class="pl-v">midpoint</span> <span class="pl-k">=</span> <span class="pl-c1">0</span>, <span class="pl-v">name</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-pds">&quot;</span></span>, <span class="pl-v">breaks</span> <span class="pl-k">=</span> seq(<span class="pl-k">-</span><span class="pl-c1">50</span>, <span class="pl-c1">50</span>, <span class="pl-c1">50</span>), <span class="pl-v">labels</span> <span class="pl-k">=</span> paste0(seq(<span class="pl-k">-</span><span class="pl-c1">50</span>, <span class="pl-c1">50</span>, <span class="pl-c1">50</span>), <span class="pl-s"><span class="pl-pds">&quot;</span> Days<span class="pl-pds">&quot;</span></span>), <span class="pl-v">guide</span> <span class="pl-k">=</span> guide_colorbar(<span class="pl-v">barwidth</span> <span class="pl-k">=</span> <span class="pl-c1">10</span>, <span class="pl-v">barheight</span> <span class="pl-k">=</span> <span class="pl-smi">.3</span>), <span class="pl-v">na.value</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>white<span class="pl-pds">&quot;</span></span>, <span class="pl-v">limits</span> <span class="pl-k">=</span> c(<span class="pl-k">-</span><span class="pl-c1">55</span>, <span class="pl-c1">55</span>))</td>
      </tr>
      <tr>
        <td id="L283" class="blob-num js-line-number" data-line-number="283"></td>
        <td id="LC283" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L284" class="blob-num js-line-number" data-line-number="284"></td>
        <td id="LC284" class="blob-code blob-code-inner js-file-line">  <span class="pl-c"><span class="pl-c">#</span> exclude models with less than 20 total locations for small sample size</span></td>
      </tr>
      <tr>
        <td id="L285" class="blob-num js-line-number" data-line-number="285"></td>
        <td id="LC285" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">exclude.mods</span> <span class="pl-k">&lt;-</span> <span class="pl-smi">error.mod</span>[<span class="pl-smi">num</span> <span class="pl-k">&lt;</span> <span class="pl-c1">1</span>, <span class="pl-smi">model_short</span>]</td>
      </tr>
      <tr>
        <td id="L286" class="blob-num js-line-number" data-line-number="286"></td>
        <td id="LC286" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L287" class="blob-num js-line-number" data-line-number="287"></td>
        <td id="LC287" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L288" class="blob-num js-line-number" data-line-number="288"></td>
        <td id="LC288" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">gg1</span> <span class="pl-k">&lt;-</span> ggplot(<span class="pl-smi">error.m.wk</span>[<span class="pl-smi">wk</span> <span class="pl-k">%in%</span> <span class="pl-c1">1</span><span class="pl-k">:</span><span class="pl-c1">6</span>  <span class="pl-k">&amp;</span> <span class="pl-k">!</span>(<span class="pl-smi">model_short</span> <span class="pl-k">%in%</span> <span class="pl-smi">exclude.mods</span>)]) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L289" class="blob-num js-line-number" data-line-number="289"></td>
        <td id="LC289" class="blob-code blob-code-inner js-file-line">    geom_tile(aes(<span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">wk</span>, <span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">model_short</span>, <span class="pl-v">fill</span> <span class="pl-k">=</span> <span class="pl-smi">mae</span>), <span class="pl-v">alpha</span> <span class="pl-k">=</span> <span class="pl-c1">1.0</span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L290" class="blob-num js-line-number" data-line-number="290"></td>
        <td id="LC290" class="blob-code blob-code-inner js-file-line">    facet_grid(<span class="pl-v">rows</span><span class="pl-k">=</span>vars(<span class="pl-smi">model_month</span>),<span class="pl-v">cols</span><span class="pl-k">=</span>vars(<span class="pl-smi">super_region_name</span>),<span class="pl-v">as.table</span> <span class="pl-k">=</span> <span class="pl-c1">F</span>,<span class="pl-v">scales</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>free_y<span class="pl-pds">&quot;</span></span>)<span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L291" class="blob-num js-line-number" data-line-number="291"></td>
        <td id="LC291" class="blob-code blob-code-inner js-file-line">    geom_text(aes(<span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">wk</span>, <span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">model_short</span>, <span class="pl-v">label</span> <span class="pl-k">=</span> paste0(round(<span class="pl-smi">mae</span>)))) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L292" class="blob-num js-line-number" data-line-number="292"></td>
        <td id="LC292" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">theme</span> <span class="pl-k">+</span> </td>
      </tr>
      <tr>
        <td id="L293" class="blob-num js-line-number" data-line-number="293"></td>
        <td id="LC293" class="blob-code blob-code-inner js-file-line">    theme(</td>
      </tr>
      <tr>
        <td id="L294" class="blob-num js-line-number" data-line-number="294"></td>
        <td id="LC294" class="blob-code blob-code-inner js-file-line">    <span class="pl-v">axis.text.x</span><span class="pl-k">=</span>element_text(<span class="pl-v">angle</span><span class="pl-k">=</span><span class="pl-c1">30</span>,<span class="pl-v">face</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>,<span class="pl-v">size</span><span class="pl-k">=</span><span class="pl-c1">10</span>,<span class="pl-v">hjust</span><span class="pl-k">=</span><span class="pl-c1">1</span>),</td>
      </tr>
      <tr>
        <td id="L295" class="blob-num js-line-number" data-line-number="295"></td>
        <td id="LC295" class="blob-code blob-code-inner js-file-line">    <span class="pl-v">strip.text.x</span><span class="pl-k">=</span>element_text(<span class="pl-v">face</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>,<span class="pl-v">size</span><span class="pl-k">=</span><span class="pl-c1">9</span>),</td>
      </tr>
      <tr>
        <td id="L296" class="blob-num js-line-number" data-line-number="296"></td>
        <td id="LC296" class="blob-code blob-code-inner js-file-line">    <span class="pl-v">strip.text.y</span><span class="pl-k">=</span>element_text(<span class="pl-v">face</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>,<span class="pl-v">size</span><span class="pl-k">=</span><span class="pl-c1">9</span>),</td>
      </tr>
      <tr>
        <td id="L297" class="blob-num js-line-number" data-line-number="297"></td>
        <td id="LC297" class="blob-code blob-code-inner js-file-line">    <span class="pl-v">plot.title</span><span class="pl-k">=</span>element_text(<span class="pl-v">face</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>,<span class="pl-v">size</span><span class="pl-k">=</span><span class="pl-c1">8</span>)</td>
      </tr>
      <tr>
        <td id="L298" class="blob-num js-line-number" data-line-number="298"></td>
        <td id="LC298" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L299" class="blob-num js-line-number" data-line-number="299"></td>
        <td id="LC299" class="blob-code blob-code-inner js-file-line">    )<span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L300" class="blob-num js-line-number" data-line-number="300"></td>
        <td id="LC300" class="blob-code blob-code-inner js-file-line">    xlab(<span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L301" class="blob-num js-line-number" data-line-number="301"></td>
        <td id="LC301" class="blob-code blob-code-inner js-file-line">    labs(<span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Forecasting Weeks<span class="pl-pds">&quot;</span></span>, <span class="pl-v">title</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>A) Accuracy - Median Absolute Error in Days<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L302" class="blob-num js-line-number" data-line-number="302"></td>
        <td id="LC302" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">bar.mae</span> <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L303" class="blob-num js-line-number" data-line-number="303"></td>
        <td id="LC303" class="blob-code blob-code-inner js-file-line">    scale_y_continuous(<span class="pl-v">breaks</span><span class="pl-k">=</span>seq(<span class="pl-c1">1</span>,<span class="pl-c1">6</span>)) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L304" class="blob-num js-line-number" data-line-number="304"></td>
        <td id="LC304" class="blob-code blob-code-inner js-file-line">    scale_x_discrete(<span class="pl-v">expand</span> <span class="pl-k">=</span> c(<span class="pl-c1">0</span>, <span class="pl-c1">0</span>)) <span class="pl-c"><span class="pl-c">#</span></span></td>
      </tr>
      <tr>
        <td id="L305" class="blob-num js-line-number" data-line-number="305"></td>
        <td id="LC305" class="blob-code blob-code-inner js-file-line">  </td>
      </tr>
      <tr>
        <td id="L306" class="blob-num js-line-number" data-line-number="306"></td>
        <td id="LC306" class="blob-code blob-code-inner js-file-line">  </td>
      </tr>
      <tr>
        <td id="L307" class="blob-num js-line-number" data-line-number="307"></td>
        <td id="LC307" class="blob-code blob-code-inner js-file-line">  print(<span class="pl-smi">gg1</span>)</td>
      </tr>
      <tr>
        <td id="L308" class="blob-num js-line-number" data-line-number="308"></td>
        <td id="LC308" class="blob-code blob-code-inner js-file-line">  dev.off()</td>
      </tr>
      <tr>
        <td id="L309" class="blob-num js-line-number" data-line-number="309"></td>
        <td id="LC309" class="blob-code blob-code-inner js-file-line">  </td>
      </tr>
      <tr>
        <td id="L310" class="blob-num js-line-number" data-line-number="310"></td>
        <td id="LC310" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L311" class="blob-num js-line-number" data-line-number="311"></td>
        <td id="LC311" class="blob-code blob-code-inner js-file-line">pdf(paste0(<span class="pl-s"><span class="pl-pds">&quot;</span>visuals/Extened_Data_Figure_4_<span class="pl-pds">&quot;</span></span>, Sys.Date(), <span class="pl-s"><span class="pl-pds">&quot;</span>.pdf<span class="pl-pds">&quot;</span></span>), <span class="pl-v">width</span> <span class="pl-k">=</span> <span class="pl-c1">3</span>, <span class="pl-v">height</span> <span class="pl-k">=</span> <span class="pl-c1">8</span>)</td>
      </tr>
      <tr>
        <td id="L312" class="blob-num js-line-number" data-line-number="312"></td>
        <td id="LC312" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L313" class="blob-num js-line-number" data-line-number="313"></td>
        <td id="LC313" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L314" class="blob-num js-line-number" data-line-number="314"></td>
        <td id="LC314" class="blob-code blob-code-inner js-file-line">  <span class="pl-smi">gg2</span> <span class="pl-k">&lt;-</span> ggplot(<span class="pl-smi">error.m.wk</span>[<span class="pl-smi">wk</span> <span class="pl-k">%in%</span> <span class="pl-c1">1</span><span class="pl-k">:</span><span class="pl-c1">6</span>  <span class="pl-k">&amp;</span> <span class="pl-k">!</span>(<span class="pl-smi">model_short</span> <span class="pl-k">%in%</span> <span class="pl-smi">exclude.mods</span>)]) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L315" class="blob-num js-line-number" data-line-number="315"></td>
        <td id="LC315" class="blob-code blob-code-inner js-file-line">    geom_tile(aes(<span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">wk</span>, <span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">model_short</span>, <span class="pl-v">fill</span> <span class="pl-k">=</span> <span class="pl-smi">me</span>), <span class="pl-v">alpha</span> <span class="pl-k">=</span> <span class="pl-c1">1.0</span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L316" class="blob-num js-line-number" data-line-number="316"></td>
        <td id="LC316" class="blob-code blob-code-inner js-file-line">    facet_grid(<span class="pl-v">rows</span><span class="pl-k">=</span>vars(<span class="pl-smi">model_month</span>),<span class="pl-v">cols</span><span class="pl-k">=</span>vars(<span class="pl-smi">super_region_name</span>),<span class="pl-v">as.table</span> <span class="pl-k">=</span> <span class="pl-c1">F</span>,<span class="pl-v">scales</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>free_y<span class="pl-pds">&quot;</span></span>)<span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L317" class="blob-num js-line-number" data-line-number="317"></td>
        <td id="LC317" class="blob-code blob-code-inner js-file-line">    geom_text(aes(<span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-smi">wk</span>, <span class="pl-v">x</span> <span class="pl-k">=</span> <span class="pl-smi">model_short</span>, <span class="pl-v">label</span> <span class="pl-k">=</span> paste0(round(<span class="pl-smi">me</span>)))) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L318" class="blob-num js-line-number" data-line-number="318"></td>
        <td id="LC318" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">theme</span> <span class="pl-k">+</span> </td>
      </tr>
      <tr>
        <td id="L319" class="blob-num js-line-number" data-line-number="319"></td>
        <td id="LC319" class="blob-code blob-code-inner js-file-line">    theme(</td>
      </tr>
      <tr>
        <td id="L320" class="blob-num js-line-number" data-line-number="320"></td>
        <td id="LC320" class="blob-code blob-code-inner js-file-line">      <span class="pl-v">axis.text.x</span><span class="pl-k">=</span>element_text(<span class="pl-v">angle</span><span class="pl-k">=</span><span class="pl-c1">30</span>,<span class="pl-v">face</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>,<span class="pl-v">size</span><span class="pl-k">=</span><span class="pl-c1">10</span>,<span class="pl-v">hjust</span><span class="pl-k">=</span><span class="pl-c1">1</span>),</td>
      </tr>
      <tr>
        <td id="L321" class="blob-num js-line-number" data-line-number="321"></td>
        <td id="LC321" class="blob-code blob-code-inner js-file-line">      <span class="pl-v">strip.text.x</span><span class="pl-k">=</span>element_text(<span class="pl-v">face</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>,<span class="pl-v">size</span><span class="pl-k">=</span><span class="pl-c1">9</span>),</td>
      </tr>
      <tr>
        <td id="L322" class="blob-num js-line-number" data-line-number="322"></td>
        <td id="LC322" class="blob-code blob-code-inner js-file-line">      <span class="pl-v">strip.text.y</span><span class="pl-k">=</span>element_text(<span class="pl-v">face</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>,<span class="pl-v">size</span><span class="pl-k">=</span><span class="pl-c1">9</span>),</td>
      </tr>
      <tr>
        <td id="L323" class="blob-num js-line-number" data-line-number="323"></td>
        <td id="LC323" class="blob-code blob-code-inner js-file-line">      <span class="pl-v">plot.title</span><span class="pl-k">=</span>element_text(<span class="pl-v">face</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>bold<span class="pl-pds">&quot;</span></span>,<span class="pl-v">size</span><span class="pl-k">=</span><span class="pl-c1">8</span>)</td>
      </tr>
      <tr>
        <td id="L324" class="blob-num js-line-number" data-line-number="324"></td>
        <td id="LC324" class="blob-code blob-code-inner js-file-line">    )<span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L325" class="blob-num js-line-number" data-line-number="325"></td>
        <td id="LC325" class="blob-code blob-code-inner js-file-line">    xlab(<span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L326" class="blob-num js-line-number" data-line-number="326"></td>
        <td id="LC326" class="blob-code blob-code-inner js-file-line">    labs(<span class="pl-v">y</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>Forecasting Weeks<span class="pl-pds">&quot;</span></span>, <span class="pl-v">title</span> <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">&quot;</span>A) Bias - Median Error in Days<span class="pl-pds">&quot;</span></span>) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L327" class="blob-num js-line-number" data-line-number="327"></td>
        <td id="LC327" class="blob-code blob-code-inner js-file-line">    <span class="pl-smi">bar.me</span> <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L328" class="blob-num js-line-number" data-line-number="328"></td>
        <td id="LC328" class="blob-code blob-code-inner js-file-line">    scale_y_continuous(<span class="pl-v">breaks</span><span class="pl-k">=</span>seq(<span class="pl-c1">1</span>,<span class="pl-c1">6</span>)) <span class="pl-k">+</span></td>
      </tr>
      <tr>
        <td id="L329" class="blob-num js-line-number" data-line-number="329"></td>
        <td id="LC329" class="blob-code blob-code-inner js-file-line">    scale_x_discrete(<span class="pl-v">expand</span> <span class="pl-k">=</span> c(<span class="pl-c1">0</span>, <span class="pl-c1">0</span>)) <span class="pl-c"><span class="pl-c">#</span></span></td>
      </tr>
      <tr>
        <td id="L330" class="blob-num js-line-number" data-line-number="330"></td>
        <td id="LC330" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L331" class="blob-num js-line-number" data-line-number="331"></td>
        <td id="LC331" class="blob-code blob-code-inner js-file-line">  </td>
      </tr>
      <tr>
        <td id="L332" class="blob-num js-line-number" data-line-number="332"></td>
        <td id="LC332" class="blob-code blob-code-inner js-file-line"> print(<span class="pl-smi">gg2</span>)</td>
      </tr>
      <tr>
        <td id="L333" class="blob-num js-line-number" data-line-number="333"></td>
        <td id="LC333" class="blob-code blob-code-inner js-file-line"> dev.off()</td>
      </tr>
      <tr>
        <td id="L334" class="blob-num js-line-number" data-line-number="334"></td>
        <td id="LC334" class="blob-code blob-code-inner js-file-line"> </td>
      </tr>
      <tr>
        <td id="L335" class="blob-num js-line-number" data-line-number="335"></td>
        <td id="LC335" class="blob-code blob-code-inner js-file-line">}</td>
      </tr>
      <tr>
        <td id="L336" class="blob-num js-line-number" data-line-number="336"></td>
        <td id="LC336" class="blob-code blob-code-inner js-file-line">  </td>
      </tr>
      <tr>
        <td id="L337" class="blob-num js-line-number" data-line-number="337"></td>
        <td id="LC337" class="blob-code blob-code-inner js-file-line">  </td>
      </tr>
      <tr>
        <td id="L338" class="blob-num js-line-number" data-line-number="338"></td>
        <td id="LC338" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
</table>

  <details class="details-reset details-overlay BlobToolbar position-absolute js-file-line-actions dropdown d-none" aria-hidden="true">
    <summary class="btn-octicon ml-0 px-2 p-0 bg-white border border-gray-dark rounded-1" aria-label="Inline file action toolbar">
      <svg class="octicon octicon-kebab-horizontal" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path d="M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path></svg>
    </summary>
    <details-menu>
      <ul class="BlobToolbar-dropdown dropdown-menu dropdown-menu-se mt-2" style="width:185px">
        <li>
          <clipboard-copy role="menuitem" class="dropdown-item" id="js-copy-lines" style="cursor:pointer;">
            Copy lines
          </clipboard-copy>
        </li>
        <li>
          <clipboard-copy role="menuitem" class="dropdown-item" id="js-copy-permalink" style="cursor:pointer;">
            Copy permalink
          </clipboard-copy>
        </li>
        <li><a class="dropdown-item js-update-url-with-hash" id="js-view-git-blame" role="menuitem" href="/pyliu47/covidcompare_deprecated/blame/1a20171085b22e4f9dd7d998a4648ec8aa3bd0d9/code/2_peak.r">View git blame</a></li>
          <li><a class="dropdown-item" id="js-new-issue" role="menuitem" href="/pyliu47/covidcompare_deprecated/issues/new">Reference in new issue</a></li>
      </ul>
    </details-menu>
  </details>

  </div>

    </div>

  


  <details class="details-reset details-overlay details-overlay-dark" id="jumpto-line-details-dialog">
    <summary data-hotkey="l" aria-label="Jump to line"></summary>
    <details-dialog class="Box Box--overlay d-flex flex-column anim-fade-in fast linejump" aria-label="Jump to line">
      <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="js-jump-to-line-form Box-body d-flex" action="" accept-charset="UTF-8" method="get">
        <input class="form-control flex-auto mr-3 linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" aria-label="Jump to line" autofocus>
        <button type="submit" class="btn" data-close-dialog>Go</button>
</form>    </details-dialog>
  </details>




  </div>
</div>

    </main>
  </div>
  

  </div>

        
<div class="footer container-xl width-full p-responsive" role="contentinfo">
  <div class="position-relative d-flex flex-row-reverse flex-lg-row flex-wrap flex-lg-nowrap flex-justify-center flex-lg-justify-between pt-6 pb-2 mt-6 f6 text-gray border-top border-gray-light ">
    <ul class="list-style-none d-flex flex-wrap col-12 col-lg-5 flex-justify-center flex-lg-justify-between mb-2 mb-lg-0">
      <li class="mr-3 mr-lg-0">&copy; 2020 GitHub, Inc.</li>
        <li class="mr-3 mr-lg-0"><a data-ga-click="Footer, go to terms, text:terms" href="https://github.com/site/terms">Terms</a></li>
        <li class="mr-3 mr-lg-0"><a data-ga-click="Footer, go to privacy, text:privacy" href="https://github.com/site/privacy">Privacy</a></li>
        <li class="mr-3 mr-lg-0"><a data-ga-click="Footer, go to security, text:security" href="https://github.com/security">Security</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://githubstatus.com/" data-ga-click="Footer, go to status, text:status">Status</a></li>
        <li><a data-ga-click="Footer, go to help, text:help" href="https://help.github.com">Help</a></li>

    </ul>

    <a aria-label="Homepage" title="GitHub" class="footer-octicon d-none d-lg-block mx-lg-4" href="https://github.com">
      <svg height="24" class="octicon octicon-mark-github" viewBox="0 0 16 16" version="1.1" width="24" aria-hidden="true"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path></svg>
</a>
   <ul class="list-style-none d-flex flex-wrap col-12 col-lg-5 flex-justify-center flex-lg-justify-between mb-2 mb-lg-0">
        <li class="mr-3 mr-lg-0"><a data-ga-click="Footer, go to contact, text:contact" href="https://github.com/contact">Contact GitHub</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://github.com/pricing" data-ga-click="Footer, go to Pricing, text:Pricing">Pricing</a></li>
      <li class="mr-3 mr-lg-0"><a href="https://developer.github.com" data-ga-click="Footer, go to api, text:api">API</a></li>
      <li class="mr-3 mr-lg-0"><a href="https://training.github.com" data-ga-click="Footer, go to training, text:training">Training</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://github.blog" data-ga-click="Footer, go to blog, text:blog">Blog</a></li>
        <li><a data-ga-click="Footer, go to about, text:about" href="https://github.com/about">About</a></li>
    </ul>
  </div>
  <div class="d-flex flex-justify-center pb-6">
    <span class="f6 text-gray-light"></span>
  </div>
</div>



  <div id="ajax-error-message" class="ajax-error-message flash flash-error">
    <svg class="octicon octicon-alert" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z"></path></svg>
    <button type="button" class="flash-close js-ajax-error-dismiss" aria-label="Dismiss error">
      <svg class="octicon octicon-x" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z"></path></svg>
    </button>
    You can’t perform that action at this time.
  </div>


    <script crossorigin="anonymous" async="async" integrity="sha512-bn/3rKJzBl2H64K38R8KaVcT26vKK7BJQC59lwYc+9fjlHzmy0fwh+hzBtsgTdhIi13dxjzNKWhdSN8WTM9qUw==" type="application/javascript" id="js-conditional-compat" data-src="https://github.githubassets.com/assets/compat-bootstrap-6e7ff7ac.js"></script>
    <script crossorigin="anonymous" integrity="sha512-XNLSAtJd4ZwEwjHoDp3kUwQHzrFIGmr4hnTNxaOl19CD7LbW//VRhLG8X9u4fYNYg+vusR8c1MeXG1foPhzJGQ==" type="application/javascript" src="https://github.githubassets.com/assets/environment-bootstrap-5cd2d202.js"></script>
    <script crossorigin="anonymous" async="async" integrity="sha512-mltvQjemV3MVO1HQOcoDzjSqA/ylEkm3eKp5hswwxXwKKZEHTEHngjkh8hObveLD1ftiJ2/CCERIJAOb14BqBQ==" type="application/javascript" src="https://github.githubassets.com/assets/vendor-9a5b6f42.js"></script>
    <script crossorigin="anonymous" async="async" integrity="sha512-wT2l5c+km1RMrNpil+RrCz2YuKqHisTJA2jZL7Ex+O+ZB9+o3B+2DDNpEhmnVlNES69Gc41o5hZ1bnP5/NWCyQ==" type="application/javascript" src="https://github.githubassets.com/assets/frameworks-c13da5e5.js"></script>
    
    <script crossorigin="anonymous" async="async" integrity="sha512-t9YRjtPm8ajR1AvkzvBUyI1Lv8hjxNeZsOJ2BhohdwgSKOKb6oARf0pjYRB6fWOvyC2ty7cEKd2uRPuznXY7Tg==" type="application/javascript" src="https://github.githubassets.com/assets/github-bootstrap-b7d6118e.js"></script>
    
      <script crossorigin="anonymous" async="async" integrity="sha512-4GcSWGoe36+BoWho4gtJcByZe8j43w+lt2/PDe3rmBxRVSgD29YipDwuIywe8fvOd2b2CszBqaPGxSznUtE3Xg==" type="application/javascript" data-module-id="./drag-drop.js" data-src="https://github.githubassets.com/assets/drag-drop-e0671258.js"></script>
      <script crossorigin="anonymous" async="async" integrity="sha512-2k8dDHk0yt52uKvOvgc9cwOXOeJhxBfVP5kPS2BrCdytDmtEIJ2yone26vFENAyk1a2aFQ7KDgEevRQafuAf8A==" type="application/javascript" data-module-id="./gist-vendor.js" data-src="https://github.githubassets.com/assets/gist-vendor-da4f1d0c.js"></script>
      <script crossorigin="anonymous" async="async" integrity="sha512-iv+4yAluOjiG50ZypUBIWIUCRDo6JEBf2twvmd5AelxgPQJO/XC1oNMGTMdDfKt30p7G7fHEOTZ2utHWDJ9PPQ==" type="application/javascript" data-module-id="./randomColor.js" data-src="https://github.githubassets.com/assets/randomColor-8affb8c8.js"></script>
    
    
  <div class="js-stale-session-flash flash flash-warn flash-banner" hidden
    >
    <svg class="octicon octicon-alert" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z"></path></svg>
    <span class="js-stale-session-flash-signed-in" hidden>You signed in with another tab or window. <a href="">Reload</a> to refresh your session.</span>
    <span class="js-stale-session-flash-signed-out" hidden>You signed out in another tab or window. <a href="">Reload</a> to refresh your session.</span>
  </div>
  <template id="site-details-dialog">
  <details class="details-reset details-overlay details-overlay-dark lh-default text-gray-dark hx_rsm" open>
    <summary role="button" aria-label="Close dialog"></summary>
    <details-dialog class="Box Box--overlay d-flex flex-column anim-fade-in fast hx_rsm-dialog hx_rsm-modal">
      <button class="Box-btn-octicon m-0 btn-octicon position-absolute right-0 top-0" type="button" aria-label="Close dialog" data-close-dialog>
        <svg class="octicon octicon-x" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z"></path></svg>
      </button>
      <div class="octocat-spinner my-6 js-details-dialog-spinner"></div>
    </details-dialog>
  </details>
</template>

  <div class="Popover js-hovercard-content position-absolute" style="display: none; outline: none;" tabindex="0">
  <div class="Popover-message Popover-message--bottom-left Popover-message--large Box box-shadow-large" style="width:360px;">
  </div>
</div>


  </body>
</html>

