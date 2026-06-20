--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 雷帝神  (ID: 40473581)
-- Type: Monster / Effect / Spirit
-- Attribute: EARTH
-- Race: Thunder
-- Level 4
-- ATK 2000 | DEF 1600
--
-- Effect Text:
-- 这张卡不能特殊召唤。召唤·反转回合的结束阶段时回到主人的手卡。这张卡给与对方玩家的战斗伤害减半。
--[[ __CARD_HEADER_END__ ]]

--雷帝神
function c40473581.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--half damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e4:SetValue(aux.ChangeBattleDamage(1,HALF_DAMAGE))
	c:RegisterEffect(e4)
end
