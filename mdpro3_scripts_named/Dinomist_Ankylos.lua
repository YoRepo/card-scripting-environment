--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 雾动机龙·甲龙  (ID: 32134638)
-- Type: Monster / Effect / Pendulum
-- Attribute: WATER
-- Race: Machine
-- Level 4
-- Pendulum Scales: L6 / R6
-- ATK 1500 | DEF 2000
-- Setcode: 216
--
-- Effect Text:
-- ←6 【灵摆】 6→
-- ①：只在这张卡在灵摆区域存在才有1次，可以把以这张卡以外的自己场上的「雾动机龙」卡为对象发动的效果无效。那之后，这张卡破坏。
-- 【怪兽效果】
-- ①：只要这张卡在怪兽区域存在，自己的「雾动机龙」怪兽战斗破坏的怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--ダイナミスト・アンキロス
function c32134638.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32134638,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c32134638.negcon)
	e1:SetOperation(c32134638.negop)
	c:RegisterEffect(e1)
	--redirect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(LOCATION_REMOVED)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xd8))
	c:RegisterEffect(e2)
end
function c32134638.tfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xd8) and c:IsControler(tp) and c:IsOnField()
end
function c32134638.negcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return e:GetHandler():GetFlagEffect(32134638)==0 and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET)
		and g and g:IsExists(c32134638.tfilter,1,e:GetHandler(),tp)
		and Duel.IsChainDisablable(ev) and not Duel.IsChainDisabled(ev)
end
function c32134638.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectEffectYesNo(tp,e:GetHandler()) then
		e:GetHandler():RegisterFlagEffect(32134638,RESET_EVENT+RESETS_STANDARD,0,1)
		if Duel.NegateEffect(ev) then
			Duel.BreakEffect()
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
	end
end
