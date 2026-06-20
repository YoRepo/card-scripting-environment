--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 阿修罗  (ID: 2134346)
-- Type: Monster / Effect / Spirit
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1700 | DEF 1200
--
-- Effect Text:
-- 这张卡不能特殊召唤。召唤·反转回合的结束阶段时回到主人的手卡。可以对对方场上的全部怪兽攻击1次。
--[[ __CARD_HEADER_END__ ]]

--阿修羅
function c2134346.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--attack all
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_ATTACK_ALL)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
