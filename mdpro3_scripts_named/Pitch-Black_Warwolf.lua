--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 漆黑的战士 狼人  (ID: 88975532)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level 4
-- ATK 1600 | DEF 600
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，对方在战斗阶段不能把陷阱卡发动。
--[[ __CARD_HEADER_END__ ]]

--漆黒の戦士 ワーウルフ
function c88975532.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetCondition(c88975532.con)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c88975532.aclimit)
	c:RegisterEffect(e1)
end
function c88975532.con(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c88975532.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
