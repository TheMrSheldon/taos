USERDIR = $(SRCDIR)/user

APP_INCLUDEDIRS = $(SRCDIR)/libsys
APP_CXXFLAGS = -I$(APP_INCLUDEDIRS)

app-% :
	echo $(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.o,$(shell find $(USERDIR)/$* -name *.cpp))

app-% : $(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.o,$(shell find $(USERDIR)/$* -name *.cpp))


$(OBJDIR)/user/%.o: $(USERDIR)/%.cpp $(MAKEFILE_LIST)
	@echo "CXX		$@"
	@if test \( ! \( -d $(@D) \) \) ;then mkdir -p $(@D);fi
	$(CXX) -c $(APP_CXXFLAGS) -o $@ $<
