#ifdef TERRAIN_TEMPERATE
	#define GC_INF_1 _80_str
	#define GC_INF_1_90 _90_str
	#define GC_INF_2 _80_str
	#define GC_INF_2_90 _90_str
	#define GC_VIC_1 _oli
	#define GC_VIC_2 _wdl
	#define GC_PLN_1 _wdl
	#define GC_HEL_1 _beg

	#define PL_INF_1 _80_moro
	#define PL_INF_2 _80_moro
	#define PL_VIC_1 _oli
	#define PL_VIC_2 _inv
	#define PL_HEL_1 _bgb

	#define GE_INF_1 _80_ols
	#define GE_INF_2 _80_wdl
	#define GE_VIC_1 _oli
	#define GE_VIC_2 _wdl
	#define GE_PLN_1 _n83
	#define GE_HEL_1 _n83

	#define DK_INF_1 _90_m84
	#define DK_VIC_1 _wdl
#endif

#ifdef TERRAIN_WINTER
	#define GC_INF_1 _80_win
	#define GC_INF_1_90 _90_win
	#define GC_INF_2 _80_win
	#define GC_INF_2_90 _90_win
	#define GC_VIC_1 _olw
	#define GC_VIC_2 _win
	#define GC_PLN_1 _wdl
	#define GC_HEL_1 _grg

	#define PL_INF_1 _80_win
	#define PL_INF_2 _80_win
	#define PL_VIC_1 _olw
	#define PL_VIC_2 _olw
	#define PL_HEL_1 _un

	#define GE_INF_1 _parka_80_win
	#define GE_INF_2 _parka_80_win
	#define GE_VIC_1 _win
	#define GE_VIC_2 _wiw
	#define GE_PLN_1 _n87
	#define GE_HEL_1 _un

	#define DK_INF_1 _90_win
	#define DK_VIC_1 _win
#endif

#ifdef TERRAIN_DESERT
	#define GC_INF_1 _80_str
	#define GC_INF_1_90 _90_str
	#define GC_INF_2 _80_str
	#define GC_INF_2_90 _90_str
	#define GC_VIC_1 _ols
	#define GC_VIC_2 _ols
	#define GC_PLN_1 _wdl
	#define GC_HEL_1 _brb

	#define PL_INF_1 _80_moro
	#define PL_INF_2 _80_moro
	#define PL_VIC_1 _ols
	#define PL_VIC_2 _inv
	#define PL_HEL_1 _wdl

	#define GE_INF_1 _80_ols
	#define GE_INF_2 _80_wdl
	#define GE_VIC_1 _trp
	#define GE_VIC_2 _des
	#define GE_PLN_1 _n83
	#define GE_HEL_1 _oli

	#define DK_INF_1 _90_m84
	#define DK_VIC_1 _des
#endif

// EAST AS ENEMY
#ifdef EAST_ENEMY
gm_efai_garrisons[]    = {gm_pl_army_garrison, gm_gc_army_garrison,gm_gc_army_garrison_90,gm_gc_army_uaz_patrol};
gm_efai_paratroopers[] = {gm_gc_army_l410t_para,gm_gc_army_l410t_para_90};
gm_efai_patrols[]      = {gm_gc_army_squad,gm_gc_army_squad_90,gm_gc_army_uaz_patrol,gm_gc_army_brdm2_patrol,gm_gc_army_9p133_patrol,gm_gc_army_bmp1_patrol, gm_gc_army_bmp1p_patrol,gm_gc_army_squad_btr60pb, gm_gc_army_squad_btr60pb_90, gm_pl_army_squad_skot2a,gm_gc_army_zsu234_platoon,gm_pl_army_t55a_platoon};
gm_efai_qrf[]          = {gm_gc_army_t55am2b_patrol,gm_gc_army_uaz_patrol,gm_pl_army_t55a_platoon,gm_pl_army_pt76_patrol,gm_pl_army_zsu234_platoon,gm_pl_army_squad_skot2a};
gm_efai_attackers[]    = {gm_gc_army_t55am2b_patrol, gm_pl_army_pt76_patrol,gm_gc_army_squad_btr60pb, gm_gc_army_squad_btr60pb_90, gm_gc_army_bmp1_patrol,gm_gc_army_bmp1p_patrol,gm_pl_airforce_mi2urpg,gm_gc_army_mi2urn};
#endif

#ifdef WEST_ENEMY
// WEST AS ENEMY
gm_efai_garrisons[]    = {gm_ge_bgs_garrison, gm_ge_army_garrison, gm_dk_army_garrison, gm_ge_army_spz1a2_patrol, gm_ge_army_iltis_patrol};
gm_efai_paratroopers[] = {gm_ge_army_do28d2_para,gm_ge_army_ch53g_para_land,gm_ge_army_ch53g_para,gm_ge_army_bo105swooper_para_land};
gm_efai_patrols[]      = {gm_ge_army_iltis_patrol,gm_ge_army_fuchs_recon_patrol,gm_ge_army_fuchs_patrol,gm_dk_army_squad_pnmk,gm_ge_army_squad_m113a1g,gm_ge_army_gepard_patrol,gm_ge_army_luchsa1_patrol,gm_ge_army_spz1a2_patrol,gm_ge_army_rakjpz2_patrol};
gm_efai_qrf[]          = {gm_ge_army_iltis_patrol,gm_ge_army_leo1a1_patrol,gm_dk_army_squad_m113a1dk,gm_ge_army_leo1a4_patrol,gm_ge_army_leo1a5_patrol,gm_dk_army_squad_leo1a3,gm_dk_army_squad_pnmk,gm_ge_army_luchsa2_patrol,gm_ge_army_spz1a2_patrol,gm_ge_army_rakjpz2_patrol};
gm_efai_attackers[]    = {gm_ge_army_leo1a1_patrol,gm_dk_army_squad_m113a1dk,gm_ge_army_squad_m113a1g,gm_ge_army_leo1a4_patrol,gm_ge_army_leo1a5_patrol,gm_dk_army_squad_leo1a3,gm_ge_army_spz1a2_patrol,gm_dk_army_squad_pnmk,gm_ge_army_fuchs_patrol,gm_ge_army_gepard_patrol,gm_ge_army_luchsa2_patrol,gm_ge_army_bo105pah1};
#endif

class grouptemplates
{
	// East Germany
	class default_pact
	{
		units[]    = {};
		ranks[]    = {};
		vehicles[] = {};
		init       = ;
		unitInit[] = {};
	};

	class gm_gc_army_squad : default_pact
	{
		#define UNITCOMP(GC_INF_1,GC_VIC_1) \
		units[]    =                                                     \
		{                                                                \
			gm_gc_army_squadleader_mpiak74n##GC_INF_1,                   \
			gm_gc_army_antitank_mpiak74n_rpg7##GC_INF_1,                 \
			gm_gc_army_antitank_assistant_mpiak74n_rpg7##GC_INF_1,       \
			gm_gc_army_machinegunner_lmgrpk##GC_INF_1,                   \
			gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk##GC_INF_1,\
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                      \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                      \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                      \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1                       \
		};                                                               \
		vehicles[] = {gm_gc_army_ural4320_cargo##GC_VIC_1}

		UNITCOMP(GC_INF_1,GC_VIC_1);
		unlocked = 1;
		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};
	class gm_gc_army_squad_btr60pb : default_pact
	{
		#define UNITCOMP(GC_INF_1,GC_VIC_1) \
		units[]    =                                                         \
		{                                                                    \
			gm_gc_army_squadleader_mpiak74n##GC_INF_1,                       \
			gm_gc_army_antitank_mpiak74n_rpg7##GC_INF_1,                     \
			gm_gc_army_antitank_assistant_mpiak74n_rpg7##GC_INF_1,           \
			gm_gc_army_machinegunner_lmgrpk##GC_INF_1,                       \
			gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk##GC_INF_1,    \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                          \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                          \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1                           \
		};                                                                   \
		vehicles[] = {gm_gc_army_btr60pb##GC_VIC_1}

		UNITCOMP(GC_INF_1,GC_VIC_1);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_gc_army_squad_90 : default_pact
	{
		#define UNITCOMP(GC_INF_1,GC_VIC_1) \
		units[]    =                                                     \
		{                                                                \
			gm_gc_army_squadleader_mpiak74n##GC_INF_1,                   \
			gm_gc_army_antitank_mpiak74n_rpg7##GC_INF_1,                 \
			gm_gc_army_antitank_assistant_mpiak74n_rpg7##GC_INF_1,       \
			gm_gc_army_machinegunner_lmgrpk##GC_INF_1,                   \
			gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk##GC_INF_1,\
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                      \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                      \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                      \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1                       \
		};                                                               \
		vehicles[] = {gm_gc_army_ural4320_cargo##GC_VIC_1}

		UNITCOMP(GC_INF_1_90,GC_VIC_1);
		unlocked = 1;
		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};
	class gm_gc_army_squad_btr60pb_90 : default_pact
	{
		#define UNITCOMP(GC_INF_1,GC_VIC_1) \
		units[]    =                                                         \
		{                                                                    \
			gm_gc_army_squadleader_mpiak74n##GC_INF_1,                       \
			gm_gc_army_antitank_mpiak74n_rpg7##GC_INF_1,                     \
			gm_gc_army_antitank_assistant_mpiak74n_rpg7##GC_INF_1,           \
			gm_gc_army_machinegunner_lmgrpk##GC_INF_1,                       \
			gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk##GC_INF_1,    \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                          \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1,                          \
			gm_gc_army_rifleman_mpiak74n##GC_INF_1                           \
		};                                                                   \
		vehicles[] = {gm_gc_army_btr60pb##GC_VIC_1}

		UNITCOMP(GC_INF_1_90,GC_VIC_1);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_gc_army_garrison : default_pact
	{
		#define UNITCOMP(GC_INF_1,GC_VIC_1) \
		units[]    = { \
		gm_gc_army_squadleader_mpiak74n##GC_INF_1,   \
		gm_gc_army_antitank_mpiak74n_rpg7##GC_INF_1, \
		gm_gc_army_antitank_mpiak74n_rpg7##GC_INF_1, \
		gm_gc_army_machinegunner_lmgrpk##GC_INF_1,   \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1, \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1       \
		}; \
		vehicles[] = {gm_gc_army_uaz469_dshkm##GC_VIC_1}

		unlocked = 1;
		UNITCOMP(GC_INF_1,GC_VIC_1);
		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};

	class gm_gc_army_garrison_90 : default_pact
	{
		#define UNITCOMP(GC_INF_1,GC_VIC_1) \
		units[]    = { \
		gm_gc_army_squadleader_mpiak74n##GC_INF_1,   \
		gm_gc_army_antitank_mpiak74n_rpg7##GC_INF_1, \
		gm_gc_army_antitank_mpiak74n_rpg7##GC_INF_1, \
		gm_gc_army_machinegunner_lmgrpk##GC_INF_1,   \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1, \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1,      \
		gm_gc_army_rifleman_mpiak74n##GC_INF_1       \
		}; \
		vehicles[] = {gm_gc_army_uaz469_dshkm##GC_VIC_1}

		unlocked = 1;
		UNITCOMP(GC_INF_1_90,GC_VIC_1);
		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};

	class gm_gc_army_9p133_patrol : default_pact
	{
		#define UNITCOMP(GC_VIC_2) \
		vehicles[] = {gm_gc_army_brdm2_9p133##GC_VIC_2,gm_gc_army_brdm2_9p133##GC_VIC_2}

		UNITCOMP(GC_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_gc_army_brdm2_patrol : default_pact
	{
		#define UNITCOMP(GC_VIC_2) \
		vehicles[] = {gm_gc_army_brdm2##GC_VIC_2,gm_gc_army_brdm2##GC_VIC_2}

		UNITCOMP(GC_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_gc_army_uaz_patrol : default_pact
	{
		#define UNITCOMP(GC_VIC_1) \
		vehicles[] = {gm_gc_army_uaz469_spg9##GC_VIC_1,gm_gc_army_uaz469_spg9##GC_VIC_1}

		UNITCOMP(GC_VIC_1);
		unlocked = 1;
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_gc_army_bmp1_patrol : default_pact
	{
		#define UNITCOMP(GC_VIC_1) \
		vehicles[] = {gm_gc_army_bmp1sp2##GC_VIC_1,gm_gc_army_bmp1sp2##GC_VIC_1}

		UNITCOMP(GC_VIC_1);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_gc_army_bmp1p_patrol : default_pact
	{
		#define UNITCOMP(GC_VIC_1) \
		vehicles[] = {gm_gc_army_bmp1p##GC_VIC_1,gm_gc_army_bmp1p##GC_VIC_1}

		UNITCOMP(GC_VIC_1);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_gc_army_t55am2b_patrol : default_pact
	{
		#define UNITCOMP(GC_VIC_1) \
		vehicles[] = {gm_gc_army_t55am2b##GC_VIC_1, gm_gc_army_t55am2b##GC_VIC_1, gm_gc_army_t55am2b##GC_VIC_1}

		UNITCOMP(GC_VIC_1);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_gc_army_zsu234_platoon : default_pact
	{
		#define UNITCOMP(GC_VIC_2) \
		vehicles[] = {gm_gc_army_zsu234v1##GC_VIC_2, gm_gc_army_zsu234v1##GC_VIC_2}

		UNITCOMP(GC_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};

	class gm_gc_army_l410t_para : default_pact
	{
		isAirmobile  = 1;
		useParachute = 1;
		#define UNITCOMP(GC_PLN_1,GC_INF_2) \
		units[]    =                                         \
		{                                                    \
			gm_gc_army_sf_squadleader_mpikms72##GC_INF_2,    \
			gm_gc_army_sf_rifleman_mpikms72##GC_INF_2,       \
			gm_gc_army_sf_rifleman_mpikms72##GC_INF_2,       \
			gm_gc_army_sf_rifleman_pm63##GC_INF_2,           \
			gm_gc_army_sf_rifleman_pm63##GC_INF_2,           \
			gm_gc_army_sf_machinegunner_lmgrpk##GC_INF_2,    \
			gm_gc_army_sf_machinegunner_lmgrpk##GC_INF_2,    \
			gm_gc_army_sf_antitank_mpikms72_rpg7##GC_INF_2,  \
			gm_gc_army_sf_antitank_mpikms72_rpg7##GC_INF_2,  \
			gm_gc_army_sf_marksman_svd##GC_INF_2             \
		};                                                   \
		vehicles[] = {gm_gc_airforce_l410t##GC_PLN_1}

		UNITCOMP(GC_PLN_1,GC_INF_2);
		forceBackPackType = gm_backpack_rs9_parachute;
		unitInit   = "_this setSkill 1";
	};
	class gm_gc_army_mi2t_para : default_pact
	{
		isAirmobile  = 1;
		#define UNITCOMP(GC_HEL_1,GC_INF_2) \
		units[]    =                                        \
		{                                                   \
			gm_gc_army_sf_squadleader_mpikms72##GC_INF_2,   \
			gm_gc_army_sf_rifleman_pm63##GC_INF_2,          \
			gm_gc_army_sf_rifleman_pm63##GC_INF_2,          \
			gm_gc_army_sf_machinegunner_lmgrpk##GC_INF_2,   \
			gm_gc_army_sf_antitank_mpikms72_rpg7##GC_INF_2, \
			gm_gc_army_sf_antitank_mpikms72_rpg7##GC_INF_2  \
		};                                                  \
		vehicles[] = {gm_gc_airforce_mi2t##GC_HEL_1}

		UNITCOMP(GC_HEL_1,GC_INF_2);
		unitInit   = "_this setSkill 1";
	};

	class gm_gc_army_l410t_para_90 : default_pact
	{
		isAirmobile  = 1;
		useParachute = 1;
		#define UNITCOMP(GC_PLN_1,GC_INF_2) \
		units[]    =                                         \
		{                                                    \
			gm_gc_army_sf_squadleader_mpikms72##GC_INF_2,    \
			gm_gc_army_sf_rifleman_mpikms72##GC_INF_2,       \
			gm_gc_army_sf_rifleman_mpikms72##GC_INF_2,       \
			gm_gc_army_sf_rifleman_pm63##GC_INF_2,           \
			gm_gc_army_sf_rifleman_pm63##GC_INF_2,           \
			gm_gc_army_sf_machinegunner_lmgrpk##GC_INF_2,    \
			gm_gc_army_sf_machinegunner_lmgrpk##GC_INF_2,    \
			gm_gc_army_sf_antitank_mpikms72_rpg7##GC_INF_2,  \
			gm_gc_army_sf_antitank_mpikms72_rpg7##GC_INF_2,  \
			gm_gc_army_sf_marksman_svd##GC_INF_2             \
		};                                                   \
		vehicles[] = {gm_gc_airforce_l410t##GC_PLN_1}

		UNITCOMP(GC_PLN_1,GC_INF_2_90);
		forceBackPackType = gm_backpack_rs9_parachute;
		unitInit   = "_this setSkill 1";
	};
	class gm_gc_army_mi2t_para_90 : default_pact
	{
		isAirmobile  = 1;
		#define UNITCOMP(GC_HEL_1,GC_INF_2) \
		units[]    =                                        \
		{                                                   \
			gm_gc_army_sf_squadleader_mpikms72##GC_INF_2,   \
			gm_gc_army_sf_rifleman_pm63##GC_INF_2,          \
			gm_gc_army_sf_rifleman_pm63##GC_INF_2,          \
			gm_gc_army_sf_machinegunner_lmgrpk##GC_INF_2,   \
			gm_gc_army_sf_antitank_mpikms72_rpg7##GC_INF_2, \
			gm_gc_army_sf_antitank_mpikms72_rpg7##GC_INF_2  \
		};                                                  \
		vehicles[] = {gm_gc_airforce_mi2t##GC_HEL_1}

		UNITCOMP(GC_HEL_1,GC_INF_2_90);
		unitInit   = "_this setSkill 1";
	};

	class gm_gc_army_mi2urn_para : default_pact
	{
		#define UNITCOMP(GC_HEL_1) \
		vehicles[] = {gm_gc_airforce_mi2urn##GC_HEL_1,gm_gc_airforce_mi2urn##GC_HEL_1}

		UNITCOMP(GC_HEL_1);
	};
	class gm_gc_army_mi2us_para : default_pact
	{
		#define UNITCOMP(GC_HEL_1) \
		vehicles[] = {gm_gc_airforce_mi2us##GC_HEL_1,gm_gc_airforce_mi2us##GC_HEL_1}

		UNITCOMP(GC_HEL_1);
	};

	// Poland
	class gm_pl_army_squad : default_pact
	{
		units[]    =
		{
			#define UNITCOMP(PL_INF_1) \
			gm_pl_army_squadleader_akm##PL_INF_1,                \
			gm_pl_army_antitank_akm_rpg7##PL_INF_1,              \
			gm_pl_army_antitank_assistant_akm_rpg7##PL_INF_1,    \
			gm_pl_army_machinegunner_pk##PL_INF_1,               \
			gm_pl_army_machinegunner_assistant_akm_pk##PL_INF_1, \
			gm_pl_army_rifleman_akm##PL_INF_1,                   \
			gm_pl_army_rifleman_akm##PL_INF_1,                   \
			gm_pl_army_rifleman_akm##PL_INF_1,                   \
			gm_pl_army_rifleman_akm##PL_INF_1,                   \
			gm_pl_army_rifleman_akm##PL_INF_1,                   \
			gm_pl_army_rifleman_akm##PL_INF_1,                   \
			gm_pl_army_rifleman_akm##PL_INF_1,                   \
			gm_pl_army_rifleman_akm##PL_INF_1

			UNITCOMP(PL_INF_1)
		};
		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};
	class gm_pl_army_garrison : default_pact
	{
		#define UNITCOMP(PL_INF_1,PL_VIC_1) \
		units[]    = { \
		gm_pl_army_squadleader_akm##PL_INF_1,                 \
		gm_pl_army_antitank_akm_rpg7##PL_INF_1,               \
		gm_pl_army_antitank_akm_rpg7##PL_INF_1,               \
		gm_pl_army_antitank_assistant_akm_rpg7##PL_INF_1,     \
		gm_pl_army_machinegunner_pk##PL_INF_1,                \
		gm_pl_army_rifleman_akm##PL_INF_1,               \
		gm_pl_army_rifleman_akm##PL_INF_1,                    \
		gm_pl_army_rifleman_akm##PL_INF_1,                    \
		gm_pl_army_rifleman_akm##PL_INF_1,                    \
		gm_pl_army_rifleman_akm##PL_INF_1,                    \
		gm_pl_army_rifleman_akm##PL_INF_1,                    \
		gm_pl_army_rifleman_akm##PL_INF_1,                    \
		gm_pl_army_rifleman_akm##PL_INF_1,                    \
		gm_pl_army_machinegunner_assistant_akm_pk##PL_INF_1   \
		}; \
		vehicles[] = {gm_pl_army_uaz469_dshkm##PL_VIC_1}

		unlocked = 1;
		UNITCOMP(PL_INF_1,PL_VIC_1);

		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};

	class gm_pl_army_squad_skot2a : default_pact
	{
		#define UNITCOMP(PL_VIC_1,PL_INF_1) \
		units[]    =                                              \
		{                                                         \
			gm_pl_army_squadleader_akm##PL_INF_1,                 \
			gm_pl_army_antitank_akm_rpg7##PL_INF_1,               \
			gm_pl_army_antitank_assistant_akm_rpg7##PL_INF_1,     \
			gm_pl_army_machinegunner_pk##PL_INF_1,                \
			gm_pl_army_machinegunner_assistant_akm_pk##PL_INF_1,  \
			gm_pl_army_rifleman_akm##PL_INF_1,                    \
			gm_pl_army_rifleman_akm##PL_INF_1,                    \
			gm_pl_army_rifleman_akm##PL_INF_1                     \
		};                                                        \
		vehicles[] = {gm_pl_army_ot64a##PL_VIC_1}

		UNITCOMP(PL_VIC_1,PL_INF_1);
		init       = "_this setBehaviour 'AWARE'; _this setSpeedMode 'LIMITED'";
	};
	class gm_pl_army_pt76_patrol : default_pact
	{
		#define UNITCOMP(PL_VIC_1) \
		vehicles[] = {gm_pl_army_pt76b##PL_VIC_1, gm_pl_army_pt76b##PL_VIC_1}

		UNITCOMP(PL_VIC_1);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_pl_army_t55a_platoon : default_pact
	{
		#define UNITCOMP(PL_VIC_1) \
		vehicles[] = {gm_pl_army_t55a##PL_VIC_1, gm_pl_army_t55a##PL_VIC_1, gm_pl_army_t55a##PL_VIC_1}

		UNITCOMP(PL_VIC_1);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_pl_army_zsu234_platoon : default_pact
	{
		#define UNITCOMP(PL_VIC_2) \
		vehicles[] = {gm_pl_army_zsu234v1##PL_VIC_2, gm_pl_army_zsu234v1##PL_VIC_1}

		UNITCOMP(PL_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};

	class gm_pl_army_mi2p_para : default_pact
	{
		isAirmobile  = 1;
		useParachute = 1;
		#define UNITCOMP(PL_HEL_1,PL_INF_2) \
		units[]    =                                    \
		{                                               \
			gm_pl_army_sf_squadleader_akmn##PL_INF_2,   \
			gm_pl_army_sf_rifleman_pm63##PL_INF_2,      \
			gm_pl_army_sf_rifleman_pm63##PL_INF_2,      \
			gm_pl_army_sf_machinegunner_rpk##PL_INF_2,  \
			gm_pl_army_sf_machinegunner_rpk##PL_INF_2,  \
			gm_pl_army_sf_antitank_akmn_rpg7##PL_INF_2, \
			gm_pl_army_sf_antitank_akmn_rpg7##PL_INF_2, \
			gm_pl_army_sf_marksman_svd##PL_INF_2        \
		};                                              \
		vehicles[] = {gm_pl_airforce_mi2p##PL_HEL_1}

		UNITCOMP(PL_HEL_1,PL_INF_2);
		forceBackPackType = gm_backpack_rs9_parachute;
		unitInit   = "_this setSkill 1";
	};

	class gm_pl_airforce_mi2urp : default_pact
	{
		#define UNITCOMP(PL_HEL_1) \
		vehicles[] = {gm_pl_airforce_mi2urp##PL_HEL_1,gm_pl_airforce_mi2urp##PL_HEL_1}

		UNITCOMP(PL_HEL_1);
	};
	class gm_pl_airforce_mi2urpg : default_pact
	{
		#define UNITCOMP(PL_HEL_1) \
		vehicles[] = {gm_pl_airforce_mi2urpg##PL_HEL_1,gm_pl_airforce_mi2urpg##PL_HEL_1}

		UNITCOMP(PL_HEL_1);
	};

	// West Germany
	class default_nato
	{
		units[]    = {};
		ranks[]    = {};
		vehicles[] = {};
		init       = ;
		unitInit[] = {};
	};

	class gm_ge_army_squad_kat1_451 : default_nato
	{
		#define UNITCOMP(GE_INF_1,GE_VIC_1) \
		units[]    = \
		{ \
			gm_ge_army_squadleader_g3a3_p2a1##GE_INF_1,            \
			gm_ge_army_antitank_g3a3_pzf44##GE_INF_1,              \
			gm_ge_army_antitank_assistant_g3a3_pzf44##GE_INF_1,    \
			gm_ge_army_machinegunner_mg3##GE_INF_1,                \
			gm_ge_army_machinegunner_assistant_g3a3_mg3##GE_INF_1, \
			gm_ge_army_rifleman_g3a3##GE_INF_1,                    \
			gm_ge_army_rifleman_g3a3##GE_INF_1,                    \
			gm_ge_army_rifleman_g3a3##GE_INF_1,                    \
			gm_ge_army_rifleman_g3a3##GE_INF_1                     \
		};                                                         \
		vehicles[] = {gm_ge_army_kat1_451_cargo##GE_VIC_1}

		UNITCOMP(GE_INF_1,GE_VIC_1);
		unlocked = 1;
		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};

	class gm_ge_army_squad_m113a1g : default_nato
	{
		#define UNITCOMP(GE_INF_1,GE_VIC_1) \
		units[]    = \
		{ \
			gm_ge_army_squadleader_g3a3_p2a1##GE_INF_1,              \
			gm_ge_army_antitank_g3a3_pzf44##GE_INF_1,                \
			gm_ge_army_antitank_assistant_g3a3_pzf44##GE_INF_1,      \
			gm_ge_army_machinegunner_mg3##GE_INF_1,                  \
			gm_ge_army_machinegunner_assistant_g3a3_mg3##GE_INF_1,   \
			gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
			gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
			gm_ge_army_rifleman_g3a3##GE_INF_1                       \
		};                                                           \
		vehicles[] = {gm_ge_army_m113a1g_apc##GE_VIC_1}

		UNITCOMP(GE_INF_1,GE_VIC_1);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_garrison : default_nato
	{
		#define UNITCOMP(GE_INF_1,GE_VIC_2) \
		units[]    = { \
		gm_ge_army_squadleader_g3a3_p2a1##GE_INF_1,              \
		gm_ge_army_antitank_g3a3_pzf44##GE_INF_1,                \
		gm_ge_army_antitank_g3a3_pzf44##GE_INF_1,                \
		gm_ge_army_antitank_assistant_g3a3_pzf44##GE_INF_1,      \
		gm_ge_army_machinegunner_mg3##GE_INF_1,                  \
		gm_ge_army_machinegunner_assistant_g3a3_mg3##GE_INF_1,   \
		gm_ge_army_rifleman_g3a3##GE_INF_1,                 \
		gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
		gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
		gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
		gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
		gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
		gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
		gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
		gm_ge_army_rifleman_g3a3##GE_INF_1,                      \
		gm_ge_army_rifleman_g3a3##GE_INF_1                       \
		}; \
		vehicles[] = {gm_ge_army_iltis_mg3##GE_VIC_2}

		UNITCOMP(GE_INF_1,GE_VIC_2);
		unlocked = 1;
		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};
	class gm_ge_army_m113_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_m113a1g_apc##GE_VIC_2,gm_ge_army_m113a1g_apc_milan##GE_VIC_2, gm_ge_army_m113a1g_apc##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_iltis_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_iltis_milan##GE_VIC_2,gm_ge_army_iltis_milan##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		unlocked = 1;
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_spz1a2_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_marder1a2##GE_VIC_2,gm_ge_army_marder1a2##GE_VIC_2, gm_ge_army_marder1a2##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_fuchs_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_fuchsa0_engineer##GE_VIC_2,gm_ge_army_fuchsa0_reconnaissance##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_fuchs_recon_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_fuchsa0_reconnaissance##GE_VIC_2,gm_ge_army_fuchsa1_jammer##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_leo1a1_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_leopard1a1a1##GE_VIC_2,gm_ge_army_leopard1a1a1##GE_VIC_2, gm_ge_army_leopard1a1a1##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_leo1a4_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_leopard1a4##GE_VIC_2,gm_ge_army_leopard1a4##GE_VIC_2,gm_ge_army_leopard1a4##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_leo1a5_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_leopard1a5##GE_VIC_2,gm_ge_army_leopard1a5##GE_VIC_2,gm_ge_army_leopard1a5##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_rakjpz2_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_rakjpz2##GE_VIC_2,gm_ge_army_rakjpz2##GE_VIC_2,gm_ge_army_rakjpz2##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_gepard_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_1) \
		vehicles[] = {gm_ge_army_gepard1a1##GE_VIC_1,gm_ge_army_gepard1a1##GE_VIC_1}

		UNITCOMP(GE_VIC_1);
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_luchsa1_patrol : default_nato
	{
		vehicles[] = {gm_ge_army_luchsa1_OLI,gm_ge_army_luchsa1_OLI};
		init       = "_this setBehaviour 'AWARE'";
	};
	class gm_ge_army_luchsa2_patrol : default_nato
	{
		#define UNITCOMP(GE_VIC_2) \
		vehicles[] = {gm_ge_army_luchsa2##GE_VIC_2,gm_ge_army_luchsa2##GE_VIC_2}

		UNITCOMP(GE_VIC_2);
		init       = "_this setBehaviour 'AWARE'";
	};

	class gm_ge_army_do28d2_para : default_nato
	{
		isAirmobile  = 1;
		useParachute = 1;
		#define UNITCOMP(GE_PLN_1,GE_INF_1) \
		units[]    = \
		{  \
			gm_ge_army_squadleader_g3a3_p2a1##GE_INF_1, \
			gm_ge_army_antitank_g3a3_pzf44##GE_INF_1,   \
			gm_ge_army_antitank_g3a3_pzf44##GE_INF_1,   \
			gm_ge_army_machinegunner_mg3##GE_INF_1,     \
			gm_ge_army_machinegunner_mg3##GE_INF_1,     \
			gm_ge_army_rifleman_g3a3##GE_INF_1,         \
			gm_ge_army_rifleman_g3a3##GE_INF_1,         \
			gm_ge_army_rifleman_g3a3##GE_INF_1,         \
			gm_ge_army_rifleman_g3a3##GE_INF_1,         \
			gm_ge_army_rifleman_g3a3##GE_INF_1          \
		}; \
		vehicles[] = {gm_ge_airforce_do28d2##GE_PLN_1}

		UNITCOMP(GE_PLN_1,GE_INF_1);
		forceBackPackType = gm_backpack_t10_parachute;
		unitInit   = "_this setSkill 1";
	};
	class gm_ge_army_ch53g_para_land : default_nato
	{
		isAirmobile  = 1;
		#define UNITCOMP(GE_HEL_1,GE_INF_1) \
		units[]    = \
		{ \
			gm_ge_army_squadleader_g3a3_p2a1##GE_INF_1,\
			gm_ge_army_antitank_g3a3_pzf44##GE_INF_1,  \
			gm_ge_army_antitank_g3a3_pzf44##GE_INF_1,  \
			gm_ge_army_machinegunner_mg3##GE_INF_1,    \
			gm_ge_army_machinegunner_mg3##GE_INF_1,    \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1,        \
			gm_ge_army_rifleman_g3a3##GE_INF_1 \
		}; \
		vehicles[] = {gm_ge_army_ch53g##GE_HEL_1}

		UNITCOMP(GE_HEL_1,GE_INF_1);

		unitInit   = "_this setSkill 1";
	};
	class gm_ge_army_ch53g_para : gm_ge_army_ch53g_para_land
	{
		useParachute = 1;
		forceBackPackType = gm_backpack_t10_parachute;
	};
	class gm_ge_army_bo105swooper_para_land : default_nato
	{
		isAirmobile  = 1;
		#define UNITCOMP(GE_HEL_1,GE_INF_2) \
		units[]    = \
		{ \
			gm_ge_army_sf_squadleader_mp5sd3_p2a1##GE_INF_2, \
			gm_ge_army_sf_antitank_mp5a2_pzf84##GE_INF_2, \
			gm_ge_army_sf_antitank_mp5a2_pzf84##GE_INF_2, \
			gm_ge_army_sf_rifleman_mp5a3##GE_INF_2, \
			gm_ge_army_sf_rifleman_mp5a3##GE_INF_2, \
			gm_ge_army_sf_marksman_g3a3##GE_INF_2, \
			gm_ge_army_sf_rifleman_g3a4##GE_INF_2, \
			gm_ge_army_sf_rifleman_g3a4##GE_INF_2 \
		}; \
		vehicles[] = {gm_ge_army_bo105p1m_vbh_swooper##GE_HEL_1}

		UNITCOMP(GE_HEL_1,GE_INF_2);
		unitInit   = "_this setSkill 1";
	};

	class gm_ge_army_bo105pah1 : default_nato
	{
		#define UNITCOMP(GE_HEL_1) \
		vehicles[] = {gm_ge_army_bo105p_pah1##GE_HEL_1,gm_ge_army_bo105p_pah1##GE_HEL_1}

		UNITCOMP(GE_HEL_1);
	};

	class gm_ge_bgs_garrison : default_nato
	{
		units[]    =
		{
			gm_ge_bgs_squadleader_mp5a2_p2a1_80_smp,
			gm_ge_bgs_machinegunner_mg3_80_smp,
			gm_ge_bgs_machinegunner_assistant_mp5a2_mg3_80_smp,
			gm_ge_bgs_machinegunner_mg3_80_smp,
			gm_ge_bgs_machinegunner_assistant_mp5a2_mg3_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp,
			gm_ge_bgs_rifleman_mp5a2_80_smp
		};
		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};

	// Denmark
	class gm_dk_army_squad_m113a1dk : default_nato
	{
		#define UNITCOMP(DK_INF_1,DK_VIC_1) \
		units[]    = \
		{ \
			gm_dk_army_squadleader_gvm95_p2a1##DK_INF_1, \
			gm_dk_army_antitank_gvm95_pzf84##DK_INF_1, \
			gm_dk_army_antitank_assistant_gvm95_pzf84##DK_INF_1, \
			gm_dk_army_machinegunner_mg3##DK_INF_1, \
			gm_dk_army_machinegunner_assistant_gvm95_mg3##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1 \
		}; \
		vehicles[] = {gm_dk_army_m113a1dk_apc##DK_VIC_1}

		init       = "_this setBehaviour 'AWARE'";

		UNITCOMP(DK_INF_1,DK_VIC_1);
	};
	class gm_dk_army_garrison : default_nato
	{
		units[]    =
		{
			#define UNITCOMP(DK_INF_1) \
			gm_dk_army_squadleader_gvm95_p2a1##DK_INF_1, \
			gm_dk_army_antitank_gvm95_pzf84##DK_INF_1, \
			gm_dk_army_antitank_gvm95_pzf84##DK_INF_1, \
			gm_dk_army_antitank_assistant_gvm95_pzf84##DK_INF_1, \
			gm_dk_army_machinegunner_mg3##DK_INF_1, \
			gm_dk_army_machinegunner_assistant_gvm95_mg3##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1, \
			gm_dk_army_rifleman_gvm95##DK_INF_1

			UNITCOMP(DK_INF_1)
		};
		init       = "_this setBehaviour 'SAFE'; _this setSpeedMode 'LIMITED'";
	};
	class gm_dk_army_squad_pnmk : default_nato
	{
		#define UNITCOMP(DK_VIC_1) \
		vehicles[] = {gm_dk_army_m113a2dk##DK_VIC_1,gm_dk_army_m113a2dk##DK_VIC_1}

		UNITCOMP(DK_VIC_1);
		init       = "_this setBehaviour 'SAFE'";
	};
	class gm_dk_army_squad_leo1a3 : default_nato
	{
		#define UNITCOMP(DK_VIC_1) \
		vehicles[] = {gm_dk_army_leopard1a3##DK_VIC_1,gm_dk_army_leopard1a3##DK_VIC_1,gm_dk_army_leopard1a3##DK_VIC_1}

		UNITCOMP(DK_VIC_1);
		init       = "_this setBehaviour 'SAFE'";
	};
	class gm_dk_army_squad_leo1a5dk1 : default_nato
	{
		#define UNITCOMP(DK_VIC_1) \
		vehicles[] = {gm_dk_army_Leopard1a5dk1##DK_VIC_1,gm_dk_army_Leopard1a5dk1##DK_VIC_1,gm_dk_army_Leopard1a5dk1_dozer##DK_VIC_1}

		UNITCOMP(DK_VIC_1);
		init       = "_this setBehaviour 'SAFE'";
	};
};