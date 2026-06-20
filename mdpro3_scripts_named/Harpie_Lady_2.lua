--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 鹰身女郎2  (ID: 27927359)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1300 | DEF 1400
-- Setcode: 100
--
-- Effect Text:
-- 这张卡的卡名当作「鹰身女郎」使用。这只怪兽战斗破坏的反转效果怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・レディ2
function c27927359.initial_effect(c)
	--Disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c27927359.operation)
	c:RegisterEffect(e1)
end
function c27927359.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and bc:IsType(TYPE_FLIP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x17a0000)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x17a0000)
		bc:RegisterEffect(e2)
	end
end
