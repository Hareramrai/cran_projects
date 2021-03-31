# frozen_string_literal: true

RSpec.shared_context "packages basic & package details text" do
  let(:packages_text) do
    <<~FILE_TEXT
      Package: A3
      Version: 1.0.0
      Depends: R (>= 2.15.0), xtable, pbapply
      License: GPL (>= 2)

      Package: aaSEA
      Version: 1.1.0
      Depends: R(>= 3.4.0)
      License: GPL-3
    FILE_TEXT
  end

  let(:package_details_text) do
    <<~FILE_TEXT
      Package: A3
      Type: Package
      Title: Accurate, Adaptable, and Accessible Error Metrics for Predictive Models
      Version: 1.0.0
      Author: Scott Fortmann-Roe
      Maintainer: Scott Fortmann-Roe <scottfr@berkeley.edu>
      Description: Supplies tools
      License: GPL (>= 2)
      Depends: R (>= 2.15.0), xtable, pbapply
      Date/Publication: 2015-08-16 23:05:52
    FILE_TEXT
  end
end

RSpec.shared_context "parsed package & package details" do
  let(:package) do
    {
      "Package" => "XML",
      "Version" => "1.0.0",
      "License" => "MIT",
      "Depends" => "R (>= 2.15.0), xtable, pbapply",
    }
  end

  let(:package_details) do
    {
      authors: "Scott Fortmann-Roe",
      date_and_publication: "2015-08-16 23:05:52",
      dependencies: "R (>= 2.15.0), xtable, pbapply",
      license: "GPL (>= 2)",
      maintainers: "Scott Fortmann-Roe <scottfr@berkeley.edu>",
      name: "A3",
      r_version_needed: "(>= 2.15.0)",
      title: "Accurate, Adaptable, and Accessible Error Metrics for Predictive Models",
      version: "1.0.0",
    }
  end
end
