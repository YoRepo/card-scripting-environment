--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 毛绒动物·狮子  (ID: 66457138)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 4
-- ATK 1600 | DEF 1200
-- Setcode: 169
--
-- Effect Text:
-- ①：这张卡的攻击宣言时发动。这张卡的攻击力直到战斗阶段结束时上升500。
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・ライオ
function c66457138.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c66457138.atkop)
	c:RegisterEffect(e1)
end
function c66457138.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
