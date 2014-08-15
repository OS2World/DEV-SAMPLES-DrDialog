/*อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                              บ
บ  DrDialog Definitions                                                        บ
บ                                                                              บ
บ  Date: 06/15/93                                                              บ
บ                                                                              บ
บ  Written by: David C. Morrill                                                บ
บ                                                                              บ
บ  (c) Copyright IBM Corporation 1993                                          บ
บ                                                                              บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

/*อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                              บ
บ  Common 'style' bits for Turtle and Billboard controls:                      บ
บ                                                                              บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

#define CTL_CONTAINER 0x8000    /* Control is a container */

/*อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                              บ
บ  CANVAS 'style' bits:                                                        บ
บ                                                                              บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

#define CNV_BITMAP    0x000F    /* Bitmap selector mask */
#define CNV_SIZE      0x00F0    /* Frame thickness mask */
#define CNV_LEFT      0x0100    /* Text is left aligned */
#define CNV_RIGHT     0x0200    /* Text is right aligned */
#define CNV_TOP       0x0400    /* Text is top aligned */
#define CNV_BOTTOM    0x0800    /* Text is bottom aligned */
#define CNV_SEPARATOR 0x1000    /* Text should have a separator */
#define CNV_RAISED    0x2000    /* Raised style frame */
#define CNV_RIDGED    0x4000    /* Ridged style frame */

/*อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                              บ
บ  PAINT 'style' bits:                                                         บ
บ                                                                              บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

#define PNT_FOREGND   0x000F    /* Foreground color mask */
#define PNT_BACKGND   0x00F0    /* Background color mask */
#define PNT_PATTERN   0x0F00    /* Pattern mask */

/*อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                              บ
บ  MARQUEE Style Bits:                                                         บ
บ                                                                              บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

#define MRQ_BOLD      0x0001    /* Use Bold font */
#define MRQ_ITALIC    0x0002    /* Use Italic font */
#define MRQ_FONT      0x000C    /* Font family select mask: */
#define MRQ_HELV      0x0000    /* - Helvetica */
#define MRQ_TIMES     0x0004    /* - Times New Roman */
#define MRQ_COURIER   0x0008    /* - Courier */
#define MRQ_SYMBOL    0x000C    /* - Symbol */
#define MRQ_L2R       0x0010    /* Direction is left to right */
#define MRQ_EMBOSSED  0x0020    /* Embossed appearance */
#define MRQ_SPEED     0x00C0    /* Speed mask: */
#define MRQ_STOPPED   0x0000    /* - Stopped */
#define MRQ_SLOW      0x0040    /* - Slow */
#define MRQ_MEDIUM    0x0080    /* - Medium */
#define MRQ_FAST      0x00C0    /* - Fast */
#define MRQ_FOREGND   0x0F00    /* Foreground color mask */
#define MRQ_BACKGND   0xF000    /* Background color mask */

/*อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                              บ
บ  Billboard Style Bits:                                                       บ
บ                                                                              บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

#define BRD_MODE      0x0003    /* Mode flags: */
#define BRD_CENTER    0x0000    /* - Center */
#define BRD_SCALE     0x0001    /* - Scale to fit */
#define BRD_REPLICATE 0x0002    /* - Replicate */
#define BRD_DIR       0x000C    /* Direction mask: */
#define BRD_LEFT      0x0000    /* - right to left */
#define BRD_RIGHT     0x0004    /* - left to right */
#define BRD_TOP       0x0008    /* - bottom to top */
#define BRD_BOTTOM    0x000C    /* - top to bottom */
#define BRD_SPEED     0x0030    /* Speed mask: */
#define BRD_STOPPED   0x0000    /* - Stopped */
#define BRD_SLOW      0x0010    /* - Slow */
#define BRD_MEDIUM    0x0020    /* - Medium */
#define BRD_FAST      0x0030    /* - Fast */
#define BRD_BUTTON    0x0080    /* Button */

/*อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                              บ
บ  Turtle Style Bits:                                                          บ
บ                                                                              บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

#define TUR_BUTTON    0x0001H   /* Is a button */

/*อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                              บ
บ  Bag Button Style Bits:                                                      บ
บ                                                                              บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

#define BAG_TYPE      0x0003      /* Button type mask: */
#define BAG_BUTTON    0x0000      /* - Pushbutton */
#define BAG_CLICKER   0x0001      /* - Clicker */
#define BAG_CHECKBOX  0x0002      /* - Check box */
#define BAG_RADIO     0x0003      /* - Radio button */
#define BAG_RATE      0x000C      /* Clicker rate mask: */
#define BAG_SLOW      0x0000      /* - Slow */
#define BAG_MEDIUM    0x0004      /* - Medium */
#define BAG_FAST      0x0008      /* - Fast */
#define BAG_FASTEST   0x000C      /* - Fastest */
#define BAG_LEFT      0x0010      /* Text is left aligned */
#define BAG_RIGHT     0x0020      /* Text is right aligned */
#define BAG_TOP       0x0040      /* Text is top aligned */
#define BAG_BOTTOM    0x0080      /* Text is bottom aligned */
#define BAG_SIZE      0x0300      /* Frame thickness mask */
#define BAG_SHIFT     0x0C00      /* 'Bagged' window shift mask */
#define BAG_LED       0x1000      /* LED should be drawn */
#define BAG_LEDROUND  0x2000      /* LED should be round (not rectangular) */
#define BAG_LEDCOLOR  0xC000      /* LED color mask: */
#define BAG_LEDRED    0x0000      /* - Red */
#define BAG_LEDGREEN  0x4000      /* - Green */
#define BAG_LEDYELLOW 0x8000      /* - Yellow */
#define BAG_LEDCYAN   0xC000      /* - Cyan */

/*อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                              บ
บ  DrDialog Initialization Routine:                                            บ
บ                                                                              บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

int UseDrDialog ( );
