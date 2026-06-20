--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 焰紫龙 巨火虫  (ID: 37038993)
-- Type: Monster / Effect / Tuner / Synchro
-- Attribute: FIRE
-- Race: Reptile
-- Level 2
-- ATK 800 | DEF 1400
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只
-- ①：这张卡从场上送去墓地的场合发动。对方场上的全部怪兽的攻击力下降500。
--[[ __CARD_HEADER_END__ ]]

--焔紫竜ピュラリス
function c37038993.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1,1)
	c:EnableReviveLimit()
	--synchro summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37038993,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c37038993.atkcon)
	e1:SetOperation(c37038993.atkop)
	c:RegisterEffect(e1)
end
function c37038993.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c37038993.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
