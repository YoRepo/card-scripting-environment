--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 自然守护者  (ID: 80555116)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 4
-- ATK 1600 | DEF 400
-- Setcode: 5373994
--
-- Effect Text:
-- 对方对怪兽的召唤成功时，这张卡的攻击力直到结束阶段时上升300。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ガーディアン
function c80555116.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80555116,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c80555116.atkcon)
	e1:SetOperation(c80555116.atkop)
	c:RegisterEffect(e1)
end
function c80555116.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c80555116.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
