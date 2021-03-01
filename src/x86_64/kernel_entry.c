
extern output_text64(char*);

void kernel_init()
{
	char* crispOS_str = "Hello from crispOS";

	output_text64(crispOS_str);
}
