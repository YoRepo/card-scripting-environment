--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 电控独眼巨人  (ID: 96428622)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 4
-- ATK 1400 | DEF 200
-- Setcode: 148
--
-- Effect Text:
-- 只要自己手卡数目是0张，这张卡的攻击力上升1000。
--[[ __CARD_HEADER_END__ ]]

--サイバネティック・サイクロプス
function c96428622.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1000)
	e1:SetCondition(c96428622.atkcon)
	c:RegisterEffect(e1)
end
function c96428622.atkcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==0
end
