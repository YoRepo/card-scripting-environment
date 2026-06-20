--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 进化龙·依潘龙  (ID: 69633792)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 6
-- ATK 2400 | DEF 600
-- Setcode: 24654
--
-- Effect Text:
-- 这张卡用名字带有「进化虫」的怪兽的效果特殊召唤成功时，这张卡的攻击力下降500。
--[[ __CARD_HEADER_END__ ]]

--エヴォルダー・テリアス
function c69633792.initial_effect(c)
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69633792,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(aux.evospcon)
	e1:SetOperation(c69633792.atkop)
	c:RegisterEffect(e1)
end
function c69633792.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		--atkup
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
