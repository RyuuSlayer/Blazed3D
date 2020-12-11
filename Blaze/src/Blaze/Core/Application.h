#pragma once

#include "Blaze/Core/Base.h"

#include "Blaze/Core/Window.h"
#include "Blaze/Core/LayerStack.h"
#include "Blaze/Events/Event.h"
#include "Blaze/Events/ApplicationEvent.h"

#include "Blaze/Core/Timestep.h"

#include "Blaze/ImGui/ImGuiLayer.h"

int main(int argc, char** argv);

namespace Blaze {

	class Application
	{
	public:
		Application(const std::string& name = "Blaze App");
		virtual ~Application();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);

		Window& GetWindow() { return *m_Window; }

		void Close();

		ImGuiLayer* GetImGuiLayer() { return m_ImGuiLayer; }

		static Application& Get() { return *s_Instance; }
	private:
		void Run();
		bool OnWindowClose(WindowCloseEvent& e);
		bool OnWindowResize(WindowResizeEvent& e);
	private:
		Scope<Window> m_Window;
		ImGuiLayer* m_ImGuiLayer;
		bool m_Running = true;
		bool m_Minimized = false;
		LayerStack m_LayerStack;
		float m_LastFrameTime = 0.0f;
	private:
		static Application* s_Instance;
		friend int ::main(int argc, char** argv);
	};

	// To be defined in CLIENT
	Application* CreateApplication();

}
