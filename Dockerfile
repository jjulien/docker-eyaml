FROM centos:7

RUN yum -y install rubygems

RUN gem install hiera-eyaml

ADD eyaml-wrapper /usr/local/bin/eyaml-wrapper

ENTRYPOINT ["/usr/local/bin/eyaml-wrapper"]
