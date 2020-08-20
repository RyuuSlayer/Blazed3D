workspace "Blaze"
	architecture "x64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Blaze/vendor/GLFW/include"
IncludeDir["Glad"] = "Blaze/vendor/Glad/include"
IncludeDir["ImGui"] = "Blaze/vendor/imgui"
IncludeDir["glm"] = "Blaze/vendor/glm"

group "Dependencies"
	include "Blaze/vendor/GLFW"
	include "Blaze/vendor/Glad"
	include "Blaze/vendor/imgui"

group ""

project "Blaze"
	location "Blaze"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "bzpch.h"
	pchsource "Blaze/src/bzpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl"
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}"
	}

	links 
	{ 
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"BZ_PLATFORM_WINDOWS",
			"BZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

	filter "configurations:Debug"
		defines "BZ_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "BZ_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "BZ_DIST"
		runtime "Release"
		optimize "on"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Blaze/vendor/spdlog/include",
		"Blaze/src",
		"Blaze/vendor",
		"%{IncludeDir.glm}"
	}

	links
	{
		"Blaze"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"BZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "BZ_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "BZ_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "BZ_DIST"
		runtime "Release"
		optimize "on"