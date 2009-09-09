
struct SharedBlock;

extern SharedBlock* gpSharedBlock;
extern HANDLE       ghDataLock;

struct SharedBlock
{
    short turingShared;
};
