#include <Blaze.h>

#include "imgui/imgui.h"

class ExampleLayer : public Blaze::Layer
{
public:
	ExampleLayer()
		: Layer("Example")
	{
	}

	void OnUpdate() override
	{
		if (Blaze::Input::IsKeyPressed(BZ_KEY_TAB))
			BZ_TRACE("Tab key is pressed (poll)!");
	}

	virtual void OnImGuiRender() override
	{
		ImGui::Begin("Test");
		ImGui::Text("Hello World");
		ImGui::End();
	}

	void OnEvent(Blaze::Event& event) override
	{
		if (event.GetEventType() == Blaze::EventType::KeyPressed)
		{
			Blaze::KeyPressedEvent& e = (Blaze::KeyPressedEvent&)event;
			if (e.GetKeyCode() == BZ_KEY_TAB)
				BZ_TRACE("Tab key is pressed (event)!");
			BZ_TRACE("{0}", (char)e.GetKeyCode());
		}
	}

};

class Sandbox : public Blaze::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
	}

	~Sandbox()
	{

	}

};

Blaze::Application* Blaze::CreateApplication()
{
	return new Sandbox();
}